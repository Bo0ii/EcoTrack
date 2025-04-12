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
  bool isLoading = true;
  int selectedIndex = -1;

  // We'll store the overall timeline plus two separate lists for normal vs peak bars.
  List<_ChartBar> allBars = [];
  List<_ChartBar> normalBars = [];
  List<_ChartBar> peakBars = [];

  @override
  void initState() {
    super.initState();
    // Tooltip only shows on hover/tap; no persistent data labels
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _processHistoryData();
    });
  }

  /// 1) Flatten if nested
  /// 2) Convert timestamps to local time and group by YYYY-MM-DD (latest reading)
  /// 3) Build a timeline for last [widget.days] days => [allBars]
  /// 4) Identify the max bar.
  /// 5) Fill normalBars with real val except highest bar => 0
  ///    fill peakBars with 0 except highest bar => real val
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

      if (!dailyRecord.containsKey(dayKey) ||
          localTs.isAfter(dailyRecord[dayKey]!['timestamp'])) {
        dailyRecord[dayKey] = {'timestamp': localTs, 'value': val};
      }
    }

    // Build a map: dayKey -> reading
    final Map<String, double> dailyLastReading = {};
    dailyRecord.forEach((key, record) {
      dailyLastReading[key] = record['value'] as double;
    });

    final nowLocal = DateTime.now().toLocal();
    final lastDay = DateTime(nowLocal.year, nowLocal.month, nowLocal.day);
    final startDay = lastDay.subtract(Duration(days: widget.days - 1));

    // Build the timeline
    final List<_ChartBar> timelineBars = [];
    for (int i = 0; i < widget.days; i++) {
      final DateTime day = startDay.add(Duration(days: i));
      final String dayKey = "${day.year.toString().padLeft(4, '0')}-"
          "${day.month.toString().padLeft(2, '0')}-"
          "${day.day.toString().padLeft(2, '0')}";
      final double value = dailyLastReading[dayKey] ?? 0.0;
      final String label = DateFormat.MMMd().format(day);
      timelineBars.add(_ChartBar(label: label, value: value));
    }

    // Identify maximum
    double maxVal = 0;
    if (timelineBars.isNotEmpty) {
      maxVal = timelineBars.map((b) => b.value).reduce((a, b) => a > b ? a : b);
    }

    // Separate normal vs. peak
    final List<_ChartBar> tmpNormal = [];
    final List<_ChartBar> tmpPeak = [];
    for (final bar in timelineBars) {
      if ((bar.value - maxVal).abs() < 1e-9 && maxVal > 0) {
        // This bar is the highest
        tmpNormal.add(_ChartBar(label: bar.label, value: 0));
        tmpPeak.add(_ChartBar(label: bar.label, value: bar.value));
      } else {
        // Normal
        tmpNormal.add(bar);
        tmpPeak.add(_ChartBar(label: bar.label, value: 0));
      }
    }

    setState(() {
      allBars = timelineBars;
      normalBars = tmpNormal;
      peakBars = tmpPeak;
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
    if (allBars.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: Text("No data available")),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SfCartesianChart(
        // Minimal style like your PowerXThreshold
        backgroundColor: Colors.transparent,
        plotAreaBackgroundColor: Colors.transparent,
        plotAreaBorderWidth: 0,
        // Add some margin so the bars aren't cropped at the edges
        margin: const EdgeInsets.all(10),

        // Hide the legend, so we see only "Energy (kWh)" in tooltips
        legend: Legend(isVisible: false),

        tooltipBehavior: _tooltipBehavior,

        // Hide the numeric axis and horizontal lines
        primaryYAxis: NumericAxis(
          isVisible: false,
          majorGridLines: const MajorGridLines(width: 0),
        ),

        // Show X-axis labels but remove vertical grid lines
        primaryXAxis: CategoryAxis(
          labelRotation: 0,
          majorGridLines: const MajorGridLines(width: 0),
        ),

        series: <CartesianSeries<_ChartBar, String>>[
          // Normal (blue) bars
          ColumnSeries<_ChartBar, String>(
            name: 'Energy (kWh)',
            dataSource: normalBars,
            xValueMapper: (bar, _) => bar.label,
            yValueMapper: (bar, _) => bar.value,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            animationDuration: 1500,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
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
            // Single gradient for the entire series => transparent->blue
            onCreateShader: (ShaderDetails shader) {
              return const LinearGradient(
                colors: [Colors.transparent, Colors.blue],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(shader.rect);
            },
          ),

          // Peak (orange) bars
          ColumnSeries<_ChartBar, String>(
            name: 'Energy (kWh)',
            dataSource: peakBars,
            xValueMapper: (bar, _) => bar.label,
            yValueMapper: (bar, _) => bar.value,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            animationDuration: 1500,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
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
            // Single gradient => transparent->orange
            onCreateShader: (ShaderDetails shader) {
              return const LinearGradient(
                colors: [Colors.transparent, Colors.orange],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(shader.rect);
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
