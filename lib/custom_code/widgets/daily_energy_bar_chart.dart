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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _processHistoryData();
    });
  }

  /// Processes the raw API data:
  /// 1. Flattens the API response.
  /// 2. Converts timestamps to local time and groups by day,
  ///    using the latest reading for each day.
  /// 3. Builds a timeline of [widget.days] days, filling 0 if a day is missing data.
  void _processHistoryData() {
    final List<dynamic> flattened = [];
    if (widget.historyData is List) {
      for (var item in widget.historyData) {
        if (item is List) {
          flattened.addAll(item);
        } else {
          flattened.add(item);
        }
      }
    }

    final Map<String, Map<String, dynamic>> dailyRecord = {};

    for (var record in flattened) {
      if (record is! Map<String, dynamic>) continue;

      final timeStr = record['last_changed'] ?? record['last_updated'];
      final valueStr = record['state'];
      if (timeStr == null || valueStr == null) continue;

      final ts = DateTime.tryParse(timeStr);
      final val = double.tryParse(valueStr.toString());
      if (ts == null || val == null) continue;

      final localTs = ts.toLocal();
      final dayKey = "${localTs.year.toString().padLeft(4, '0')}-"
          "${localTs.month.toString().padLeft(2, '0')}-"
          "${localTs.day.toString().padLeft(2, '0')}";

      // Keep the latest reading for each day
      if (!dailyRecord.containsKey(dayKey) ||
          localTs.isAfter(dailyRecord[dayKey]!['timestamp'])) {
        dailyRecord[dayKey] = {'timestamp': localTs, 'value': val};
      }
    }

    final Map<String, double> dailyLastReading = {};
    dailyRecord.forEach((key, record) {
      dailyLastReading[key] = record['value'] as double;
    });

    final DateTime localNow = DateTime.now().toLocal();
    final DateTime lastDay =
        DateTime(localNow.year, localNow.month, localNow.day);
    final DateTime startDay = lastDay.subtract(Duration(days: widget.days - 1));

    final List<_ChartBar> timelineBars = [];
    for (int i = 0; i < widget.days; i++) {
      final DateTime day = startDay.add(Duration(days: i));
      final String dayKey = "${day.year.toString().padLeft(4, '0')}-"
          "${day.month.toString().padLeft(2, '0')}-"
          "${day.day.toString().padLeft(2, '0')}";
      final double value = dailyLastReading.containsKey(dayKey)
          ? dailyLastReading[dayKey]!
          : 0.0;
      final String label = DateFormat.MMMd().format(day);
      timelineBars.add(_ChartBar(label: label, value: value));
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

    // Compute the maximum value among bars for color interpolation
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
          maximum: maxVal * 1.2,
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
                  details.seriesIndex!,
                  details.pointIndex!,
                );
              }
            },

            // Single color per bar, interpolated from lightBlue -> orange
            // as value goes from 0 -> maxVal
            pointColorMapper: (bar, index) {
              if (maxVal <= 0) {
                return Colors.lightBlue;
              }
              final double fraction = bar.value / maxVal;
              return Color.lerp(Colors.lightBlue, Colors.orange, fraction)!;
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
