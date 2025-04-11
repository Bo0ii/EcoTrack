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

class DailyEnergyBarChart extends StatefulWidget {
  final double width;
  final double height;
  final List<dynamic> chartData;

  const DailyEnergyBarChart({
    Key? key,
    required this.width,
    required this.height,
    required this.chartData,
  }) : super(key: key);

  @override
  _DailyEnergyBarChartState createState() => _DailyEnergyBarChartState();
}

class _DailyEnergyBarChartState extends State<DailyEnergyBarChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chartData.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final List<_ChartBar> bars = widget.chartData.map((e) {
      return _ChartBar(
        label: e['date'],
        value: (e['value'] as num).toDouble(),
      );
    }).toList();

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        series: <ChartSeries<_ChartBar, String>>[
          ColumnSeries<_ChartBar, String>(
            dataSource: bars,
            xValueMapper: (data, _) => data.label,
            yValueMapper: (data, _) => data.value,
            name: 'Energy (kWh)',
            animationDuration: 1500,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            onCreateShader: (details) {
              return const LinearGradient(
                colors: [Colors.lightBlue, Colors.blue],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(details.rect);
            },
          )
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

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
