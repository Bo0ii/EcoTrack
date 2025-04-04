// Automatic FlutterFlow imports
import '/backend/backend.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

/// Single data model for both 3/5-days and "Today" logic.
class _EnergyPoint {
  final DateTime utcTime;
  final double reading;
  _EnergyPoint(this.utcTime, this.reading);
}

class EnergyHistoryChart extends StatefulWidget {
  final double width;
  final double height;

  // -- For 3/5 Days usage:
  final List<String> timeData; // e.g. "2025-03-18T01:31:35.939389+00:00"
  final List<String> energyData; // e.g. "0.123"

  // -- For "Today" usage (JSON arrays from threshold & power sensors):
  final List<dynamic> thresholdJson;
  final List<dynamic> powerJson;

  const EnergyHistoryChart({
    Key? key,
    required this.width,
    required this.height,
    required this.timeData,
    required this.energyData,
    required this.thresholdJson,
    required this.powerJson,
  }) : super(key: key);

  @override
  _EnergyHistoryChartState createState() => _EnergyHistoryChartState();
}

class _EnergyHistoryChartState extends State<EnergyHistoryChart> {
  String selectedFilter = "Today"; // "Today", "3 Days", or "5 Days"

  // For 3/5 Days logic:
  late List<_EnergyPoint> sortedPoints;
  List<String> _barDayKeys = [];

  @override
  void initState() {
    super.initState();
    // Parse & sort the raw cumulative data for 3/5 days.
    sortedPoints = _parseAndSortUTC();
  }

  // =========================================================================
  // PART A: 3/5 DAYS LOGIC (unchanged)
  // =========================================================================

  /// Parse timeData & energyData into a sorted list of (utcTime, reading).
  List<_EnergyPoint> _parseAndSortUTC() {
    final inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSZ");
    List<_EnergyPoint> points = [];
    for (int i = 0; i < widget.timeData.length; i++) {
      try {
        final dt = inputFormat.parse(widget.timeData[i], true).toUtc();
        final val = double.tryParse(widget.energyData[i]) ?? 0.0;
        points.add(_EnergyPoint(dt, val));
      } catch (e) {
        debugPrint("Parse error (3/5 days): $e");
      }
    }
    points.sort((a, b) => a.utcTime.compareTo(b.utcTime));
    return points;
  }

  /// Return the reading at or before utcBoundary (for 3/5 days logic).
  double _readingAtOrBefore(DateTime utcBoundary) {
    double result =
        (sortedPoints.isNotEmpty) ? sortedPoints.first.reading : 0.0;
    for (var p in sortedPoints) {
      if (p.utcTime.isAfter(utcBoundary)) break;
      result = p.reading;
    }
    return result;
  }

  /// Build daily usage bars for X days (3 or 5).
  List<BarChartGroupData> _buildDailyBarDataMidnightDelta(int days) {
    final nowLocal = DateTime.now();
    final earliestDayLocal = DateTime(
      nowLocal.year,
      nowLocal.month,
      nowLocal.day,
    ).subtract(Duration(days: days - 1));

    List<DateTime> localDayStarts = [];
    for (int i = 0; i < days; i++) {
      localDayStarts.add(earliestDayLocal.add(Duration(days: i)));
    }

    final df = DateFormat("yyyy-MM-dd");
    Map<String, double> dayUsageMap = {};

    for (var dayStartLocal in localDayStarts) {
      final dayKey = df.format(dayStartLocal);
      var dayEndLocal = dayStartLocal.add(const Duration(days: 1));
      if (dayEndLocal.isAfter(nowLocal)) {
        dayEndLocal = nowLocal;
      }

      final dayStartUTC = dayStartLocal.toUtc();
      final dayEndUTC = dayEndLocal.toUtc();

      double startVal = _readingAtOrBefore(dayStartUTC);
      double endVal = _readingAtOrBefore(dayEndUTC);
      double usage = endVal - startVal;
      if (usage < 0) usage = 0;
      dayUsageMap[dayKey] = usage;
    }

    _barDayKeys = localDayStarts.map((d) => df.format(d)).toList();
    List<BarChartGroupData> groups = [];
    for (int i = 0; i < _barDayKeys.length; i++) {
      final dayKey = _barDayKeys[i];
      final usageVal = dayUsageMap[dayKey] ?? 0.0;
      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: usageVal,
              width: 16,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }
    return groups;
  }

  /// Render the 3/5 Days bar chart.
  Widget _buildBarChart(List<BarChartGroupData> groups) {
    if (groups.isEmpty) {
      return const Center(
        child: Text(
          "No Data Available",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: groups,
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= _barDayKeys.length) {
                  return const Text("");
                }
                final dayKey = _barDayKeys[idx];
                final dt = DateTime.parse(dayKey);
                return Text(
                  "${dt.day}/${dt.month}",
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
      ),
    );
  }

  // =========================================================================
  // PART B: "TODAY" LOGIC => Bar for Power + Step line for Threshold
  // =========================================================================

  /// Parse the sensor JSON => sorted (utcTime, reading).
  List<_EnergyPoint> _parseSensorJson(List<dynamic> sensorArray) {
    List<_EnergyPoint> list = [];
    for (var item in sensorArray) {
      try {
        final rawTime = item['last_changed'] ?? "";
        final dt = DateTime.parse(rawTime).toUtc();
        final rawVal = item['state'] ?? "0";
        final val = double.tryParse(rawVal) ?? 0.0;
        list.add(_EnergyPoint(dt, val));
      } catch (e) {
        debugPrint("Parse error (Today sensor): $e");
      }
    }
    list.sort((a, b) => a.utcTime.compareTo(b.utcTime));
    return list;
  }

  /// Helper: find the last threshold reading at or before [boundaryTime].
  double _lastThresholdAtOrBefore(
    List<_EnergyPoint> thresholdPoints,
    DateTime boundaryTime,
  ) {
    double result = 0.0; // fallback if none
    for (var p in thresholdPoints) {
      if (p.utcTime.isAfter(boundaryTime)) break;
      result = p.reading;
    }
    return result;
  }

  /// Build a step line for threshold over 12 half-hour buckets (0..11).
  /// i=0 => cutoffUTC, i=11 => cutoffUTC+5.5h
  List<FlSpot> _buildThresholdStepLineSpots(
      List<_EnergyPoint> thresholdPoints) {
    final nowLocal = DateTime.now();
    final cutoffLocal = nowLocal.subtract(const Duration(hours: 6));
    final cutoffUTC = cutoffLocal.toUtc();

    List<FlSpot> spots = [];
    for (int i = 0; i < 12; i++) {
      final bucketTime = cutoffUTC.add(Duration(minutes: i * 30));
      final val = _lastThresholdAtOrBefore(thresholdPoints, bucketTime);
      spots.add(FlSpot(i.toDouble(), val));
    }
    return spots;
  }

  /// Build half-hour bar groups for the last 6 hours of power data.
  /// i=0 => [cutoff, cutoff+30m), i=1 => next 30m, etc.
  List<BarChartGroupData> _buildPowerBarGroups(List<_EnergyPoint> powerPoints) {
    final nowLocal = DateTime.now();
    final cutoffLocal = nowLocal.subtract(const Duration(hours: 6));
    final cutoffUTC = cutoffLocal.toUtc();

    List<BarChartGroupData> groups = [];
    for (int i = 0; i < 12; i++) {
      final bucketStart = cutoffUTC.add(Duration(minutes: i * 30));
      final bucketEnd = cutoffUTC.add(Duration(minutes: (i + 1) * 30));

      final bucketVals = powerPoints
          .where((p) {
            return p.utcTime.isAfter(bucketStart) &&
                p.utcTime.isBefore(bucketEnd);
          })
          .map((p) => p.reading)
          .toList();

      double avg = 0;
      if (bucketVals.isNotEmpty) {
        avg = bucketVals.reduce((a, b) => a + b) / bucketVals.length;
      }

      groups.add(
        BarChartGroupData(
          x: i, // integer index for half-hour bucket
          barRods: [
            BarChartRodData(
              toY: avg,
              width: 12,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }
    return groups;
  }

  /// Build a stacked chart with bar for Power and step line for Threshold.
  Widget _buildTodayCombinedChart() {
    // 1) Parse your JSON arrays
    final powerPoints = _parseSensorJson(widget.powerJson);
    final thresholdPoints = _parseSensorJson(widget.thresholdJson);

    // If empty, show message
    if (powerPoints.isEmpty && thresholdPoints.isEmpty) {
      return const Center(child: Text("No Data Available"));
    }

    // 2) Build the bar groups for power
    final powerGroups = _buildPowerBarGroups(powerPoints);

    // 3) Build the step line spots for threshold
    final thresholdSpots = _buildThresholdStepLineSpots(thresholdPoints);

    // If both are effectively empty, show message
    final hasAnyBars = powerGroups.any((g) => g.barRods[0].toY != 0);
    final hasAnyThreshold = thresholdSpots.any((s) => s.y != 0);
    if (!hasAnyBars && !hasAnyThreshold) {
      return const Center(child: Text("No Data (last 6h)"));
    }

    // 4) Combine them in a Stack with auto-scaling
    return Stack(
      children: [
        // A) BarChart for power
        BarChart(
          BarChartData(
            barGroups: powerGroups,
            alignment: BarChartAlignment.spaceBetween,
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final i = value.toInt();
                    if (i < 0 || i > 11) return const Text("");
                    final now = DateTime.now();
                    final cutoff = now.subtract(const Duration(hours: 6));
                    final dt = cutoff.add(Duration(minutes: i * 30));
                    // e.g. "12:00 pm"
                    return Text(
                      DateFormat('h:mma').format(dt).toLowerCase(),
                      style: const TextStyle(fontSize: 10),
                    );
                  },
                ),
              ),
            ),
            barTouchData: BarTouchData(enabled: true),
          ),
        ),

        // B) Overlaid line chart for threshold
        IgnorePointer(
          ignoring: true,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(show: false),
              lineTouchData: LineTouchData(enabled: false),
              lineBarsData: [
                LineChartBarData(
                  spots: thresholdSpots,
                  // isCurved: false => pure step line
                  // If you want some smoothing, set isCurved: true
                  isCurved: false,
                  color: Colors.red,
                  barWidth: 2,
                  dotData: FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // PART C: BUILD METHOD => SELECT "TODAY" OR "3/5 DAYS"
  // =========================================================================
  @override
  Widget build(BuildContext context) {
    Widget chartWidget;
    if (selectedFilter == "Today") {
      chartWidget = _buildTodayCombinedChart();
    } else {
      final barData = (selectedFilter == "3 Days")
          ? _buildDailyBarDataMidnightDelta(3)
          : _buildDailyBarDataMidnightDelta(5);
      chartWidget = _buildBarChart(barData);
    }

    return Column(
      children: [
        // Filter Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFilterButton("Today"),
            const SizedBox(width: 8),
            _buildFilterButton("3 Days"),
            const SizedBox(width: 8),
            _buildFilterButton("5 Days"),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: chartWidget,
        ),
      ],
    );
  }

  Widget _buildFilterButton(String label) {
    final isSelected = (selectedFilter == label);
    return ElevatedButton(
      onPressed: () => setState(() => selectedFilter = label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey,
        foregroundColor: Colors.white,
      ),
      child: Text(label),
    );
  }
}
