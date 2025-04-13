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

/// Data class for each bar.
class _ChartBar {
  final String label;
  final double value;
  _ChartBar({required this.label, required this.value});
}

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
    // Same tooltip configuration as in PowerThresholdChart.
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      header: '', // No header text (match your power threshold chart)
      canShowMarker: true,
      duration: 999999, // Tooltip stays visible until manually hidden
    );
    // Process the data after the first frame is drawn.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _processHistoryData();
    });
  }

  @override
  void didUpdateWidget(covariant DailyEnergyBarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.historyData != oldWidget.historyData) {
      _processHistoryData();
    }
  }

  /// Processes the optimized API data (expected in attributes.data) into
  /// a list of daily final energy values.
  void _processHistoryData() {
    // Extract the list from the optimized API output.
    final List<dynamic> rawList = widget.historyData.isNotEmpty &&
            widget.historyData[0] is Map &&
            widget.historyData[0]['attributes'] != null &&
            widget.historyData[0]['attributes']['data'] != null
        ? List.from(widget.historyData[0]['attributes']['data'])
        : [];

    // Determine the date range for the last [widget.days] days.
    final DateTime now = DateTime.now().toLocal();
    final DateTime lastDay = DateTime(now.year, now.month, now.day);
    final DateTime startDay = lastDay.subtract(Duration(days: widget.days - 1));

    // Build a map where key is a day (formatted as yyyy-MM-dd) and value is the energy.
    final Map<String, double> mapped = {};
    for (var item in rawList) {
      if (item is Map<String, dynamic> &&
          item.containsKey('date') &&
          item.containsKey('value')) {
        final String dateStr = item['date'];
        final double? val = double.tryParse(item['value'].toString());
        if (val != null) {
          mapped[dateStr] = val;
        }
      }
    }

    // Build the list of chart bars.
    final List<_ChartBar> chartBars = [];
    for (int i = 0; i < widget.days; i++) {
      final DateTime day = startDay.add(Duration(days: i));
      final String key = DateFormat('yyyy-MM-dd').format(day);
      final String label = DateFormat.MMMd().format(day);
      final double value = mapped.containsKey(key) ? mapped[key]! : 0.0;
      chartBars.add(_ChartBar(label: label, value: value));
    }

    setState(() {
      bars = chartBars;
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

    // Determine the maximum energy value for scaling the Y-axis.
    final double maxVal =
        bars.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SfCartesianChart(
        backgroundColor: Colors.transparent,
        plotAreaBackgroundColor: Colors.transparent,
        plotAreaBorderWidth: 0,
        margin: const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(fontSize: 12),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          isVisible: false, // Hide the left axis numbers.
          minimum: 0,
          maximum: maxVal * 1.2,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          majorGridLines: const MajorGridLines(width: 0),
          labelFormat: '{value}',
        ),
        series: <CartesianSeries<_ChartBar, String>>[
          ColumnSeries<_ChartBar, String>(
            width: 1.0, // Full category width for improved hit area.
            dataSource: bars,
            xValueMapper: (data, _) => data.label,
            yValueMapper: (data, _) => data.value,
            name: 'Energy (kWh)',
            animationDuration: 1500,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            dataLabelSettings: const DataLabelSettings(isVisible: false),
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
                colors: [Colors.transparent, Colors.blue],
                stops: [0.0, 1.0],
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
