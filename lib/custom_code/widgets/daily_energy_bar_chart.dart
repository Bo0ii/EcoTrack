// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DailyEnergyBarChart extends StatefulWidget {
  final double width;
  final double height;
  final List<dynamic> historyData; // Raw API response from Home Assistant
  final int days; // Number of days to display; default is 15

  const DailyEnergyBarChart({
    Key? key,
    required this.width,
    required this.height,
    required this.historyData,
    this.days = 15,
  }) : super(key: key);

  @override
  _DailyEnergyBarChartState createState() => _DailyEnergyBarChartState();
}

class _DailyEnergyBarChartState extends State<DailyEnergyBarChart> {
  late TooltipBehavior _tooltipBehavior;
  List<_ChartBar> bars = [];
  bool isLoading = true;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );

    // Process the history data after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _processHistoryData();
    });
  }

  /// Processes the raw API data:
  /// 1. Flattens the API response (in case it's a nested list).
  /// 2. For each record, it uses the timestamp from either
  ///    "last_changed" or "last_updated" and parses the sensor reading.
  /// 3. It uses the UTC timestamp directly (no toLocal conversion)
  ///    so that the date matches what Home Assistant shows.
  /// 4. It groups records by day (using a padded key "YYYY-MM-DD")
  ///    and keeps the record with the latest timestamp of that day.
  /// 5. It then generates a full timeline of the last [widget.days] days,
  ///    assigning a value of 0 if no reading exists for a day.
  void _processHistoryData() {
    final List<dynamic> flattened = [];
    // Flatten the API response (to handle nested lists)
    if (widget.historyData is List) {
      for (var item in widget.historyData) {
        if (item is List) {
          flattened.addAll(item);
        } else {
          flattened.add(item);
        }
      }
    }

    // Map to store the latest record for each day.
    // Key: padded date string ("YYYY-MM-DD"), Value: a map with keys 'timestamp' and 'value'
    final Map<String, Map<String, dynamic>> dailyRecord = {};

    for (var record in flattened) {
      if (record is! Map<String, dynamic>) continue;
      final timeStr = record['last_changed'] ?? record['last_updated'];
      final valueStr = record['state'];
      if (timeStr == null || valueStr == null) continue;

      final ts = DateTime.tryParse(timeStr);
      final val = double.tryParse(valueStr.toString());
      if (ts == null || val == null) continue;

      // Here we DO NOT convert to local time; we keep UTC.
      final utcTs = ts;
      // Debug: print the raw UTC timestamp.
      // print("UTC timestamp: $utcTs");

      // Create a padded day key "YYYY-MM-DD" based on UTC date.
      final dayKey = "${utcTs.year.toString().padLeft(4, '0')}-"
          "${utcTs.month.toString().padLeft(2, '0')}-"
          "${utcTs.day.toString().padLeft(2, '0')}";

      // Keep the record with the latest UTC timestamp for that day.
      if (!dailyRecord.containsKey(dayKey) ||
          utcTs.isAfter(dailyRecord[dayKey]!['timestamp'])) {
        dailyRecord[dayKey] = {'timestamp': utcTs, 'value': val};
      }
    }

    // For debugging, output the processed day keys.
    print("Days with data (UTC): ${dailyRecord.keys.toList()}");

    // Build a simple map: dayKey -> sensor reading value.
    final Map<String, double> dailyLastReading = {};
    dailyRecord.forEach((key, record) {
      dailyLastReading[key] = record['value'] as double;
    });

    // Generate a timeline for the last [widget.days] days using UTC.
    final DateTime utcNow = DateTime.now().toUtc();
    // Get today's UTC date (at midnight).
    final DateTime lastDay = DateTime(utcNow.year, utcNow.month, utcNow.day);
    final DateTime startDay = lastDay.subtract(Duration(days: widget.days - 1));
    print("Timeline from $startDay to $lastDay (UTC)");

    final List<_ChartBar> timelineBars = [];
    for (int i = 0; i < widget.days; i++) {
      final DateTime day = startDay.add(Duration(days: i));
      final String dayKey = "${day.year.toString().padLeft(4, '0')}-"
          "${day.month.toString().padLeft(2, '0')}-"
          "${day.day.toString().padLeft(2, '0')}";
      final double value = dailyLastReading.containsKey(dayKey)
          ? dailyLastReading[dayKey]!
          : 0.0;
      // Format the label using UTC date.
      final String label = DateFormat.MMMd().format(day);
      timelineBars.add(_ChartBar(label: label, value: value));
      print("Day: $dayKey, Label: $label, Value: $value");
    }

    setState(() {
      bars = timelineBars;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (bars.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: Text("No data available")),
      );
    }

    // Determine the maximum value from bars for the Y-axis.
    final double maxVal =
        bars.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(fontSize: 12),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: maxVal * 1.2, // Add headroom
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          labelFormat: '{value}',
        ),
        series: <CartesianSeries<_ChartBar, String>>[
          ColumnSeries<_ChartBar, String>(
            dataSource: bars,
            xValueMapper: (data, _) => data.label,
            yValueMapper: (data, _) => data.value,
            name: 'Energy (kWh)',
            animationDuration: 1500,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.top,
            ),
            selectionBehavior: SelectionBehavior(
              enable: true,
              toggleSelection: false,
              unselectedOpacity: 0.3,
            ),
            onPointTap: (ChartPointDetails details) {
              if (selectedIndex == details.pointIndex) {
                setState(() => selectedIndex = -1);
                _tooltipBehavior.hide();
              } else {
                setState(() => selectedIndex = details.pointIndex!);
                _tooltipBehavior.showByIndex(
                    details.seriesIndex!, details.pointIndex!);
              }
            },
            onCreateShader: (ShaderDetails details) {
              final Rect rect =
                  Rect.fromLTWH(0, 0, widget.width, widget.height);
              return const LinearGradient(
                colors: [Colors.lightBlue, Colors.blue],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(rect);
            },
          ),
        ],
      ),
    );
  }
}

class _ChartBar {
  final String label;
  final double value;
  _ChartBar({required this.label, required this.value});
}
