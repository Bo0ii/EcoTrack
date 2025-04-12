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

import '/custom_code/actions/index.dart'; // Imports custom actions (if any remain)

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DailyEnergyBarChart extends StatefulWidget {
  final double width;
  final double height;
  final List<dynamic>
      historyData; // Raw API response from the Home Assistant history API.
  final int days; // Number of days to display (optional, default is 7)

  const DailyEnergyBarChart({
    Key? key,
    required this.width,
    required this.height,
    required this.historyData,
    this.days = 7,
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
    // Process the API data once the widget is built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _processHistoryData();
    });
  }

  /// Processes the raw history API data.
  /// 1. Flattens the response if it’s a nested list.
  /// 2. Groups records by day (using the last reading of each day).
  /// 3. Sorts the days and takes the last [widget.days] entries.
  void _processHistoryData() {
    if (widget.historyData.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    // Flatten the response in case it's a list of lists.
    final List<dynamic> flattened = [];
    for (var item in widget.historyData) {
      if (item is List) {
        flattened.addAll(item);
      } else {
        flattened.add(item);
      }
    }

    // Map to store the latest reading for each day.
    final Map<String, double> lastReadingByDate = {};

    for (var record in flattened) {
      if (record is! Map<String, dynamic>) continue;

      // Use 'last_changed' if available, otherwise 'last_updated'.
      final timeStr = record['last_changed'] ?? record['last_updated'];
      final valueStr = record['state'];
      if (timeStr == null || valueStr == null) continue;

      final ts = DateTime.tryParse(timeStr);
      final val = double.tryParse(valueStr.toString());
      if (ts == null || val == null) continue;

      // Convert to local time (adjust as needed).
      final localTs = ts.toUtc().add(const Duration(hours: 4));

      // Create a key in the format YYYY-MM-DD (zero-padded).
      final key = "${localTs.year.toString().padLeft(4, '0')}-"
          "${localTs.month.toString().padLeft(2, '0')}-"
          "${localTs.day.toString().padLeft(2, '0')}";

      // For cumulative sensors, the latest reading is the one with the greatest timestamp.
      // Here, we simply override it when a new record for the same day is encountered.
      lastReadingByDate[key] = val;
    }

    // Sort the days chronologically.
    final sortedKeys = lastReadingByDate.keys.toList()
      ..sort((a, b) => DateTime.parse(a).compareTo(DateTime.parse(b)));

    // Limit results to the last [widget.days] days.
    final recentKeys = sortedKeys.length > widget.days
        ? sortedKeys.sublist(sortedKeys.length - widget.days)
        : sortedKeys;

    List<_ChartBar> tempBars = [];
    for (final key in recentKeys) {
      // Parse the key back into DateTime for formatting.
      final dateParts = key.split("-");
      final dateTime = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      );
      final formattedDate = DateFormat.MMMd().format(dateTime);
      final value = lastReadingByDate[key]!;
      tempBars.add(_ChartBar(label: formattedDate, value: value));
    }

    setState(() {
      bars = tempBars;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Optionally, you can replace the gray default background by wrapping the chart in a Scaffold
    // or Container with a proper background color.
    if (isLoading) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    // If no bars to display, show a friendly message.
    if (bars.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: Text("No data available")),
      );
    }

    // Determine maximum value for Y-axis scaling.
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
