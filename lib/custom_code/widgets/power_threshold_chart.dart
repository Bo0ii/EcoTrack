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

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:ui'; // For Shader

// Data model for each chart data point.
class ChartData {
  final String timeLabel;
  final double power;
  final double threshold;

  ChartData({
    required this.timeLabel,
    required this.power,
    required this.threshold,
  });
}

class PowerThresholdChart extends StatefulWidget {
  final double width;
  final double height;
  final List<dynamic> historyData; // Raw arrays from Home Assistant.
  final String deviceId; // e.g., "ecot"

  const PowerThresholdChart({
    Key? key,
    required this.width,
    required this.height,
    required this.historyData,
    required this.deviceId,
  }) : super(key: key);

  @override
  _PowerThresholdChartState createState() => _PowerThresholdChartState();
}

class _PowerThresholdChartState extends State<PowerThresholdChart> {
  List<ChartData> chartData = [];
  double maxY = 0;
  Timer? _timer;
  int selectedIndex = -1; // Track which point is selected

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    // Configure the tooltip for single tap activation.
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      header: '',
      canShowMarker: true,
      duration: 999999, // stays until we hide it manually
    );

    _processData();
    // Auto-refresh every 10 minutes (only then the chart re-animates).
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) {
      _processData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _processData() {
    List<DateTime> timeline = [];
    List<double> powerSeries = [];
    List<double> thresholdSeries = [];
    double localMaxY = 0;

    // Keys for the sensors.
    final powerKey = 'sensor.${widget.deviceId}_pzem_power';
    final thresholdKey = 'sensor.${widget.deviceId}_threshold';

    // 1) Get current UTC time and shift to local (+4).
    final DateTime nowUtc = DateTime.now().toUtc();
    final DateTime localNow = nowUtc.add(const Duration(hours: 4));

    // Use a 6-hour window.
    final DateTime cutoff = localNow.subtract(const Duration(hours: 6));

    // Maps to accumulate data per 30-minute slot.
    Map<DateTime, List<double>> powerMap = {};
    Map<DateTime, List<double>> threshMap = {};

    DateTime? latestDataTime;

    // 2) Parse historyData.
    for (var array in widget.historyData) {
      if (array is List && array.isNotEmpty) {
        final firstItem = array[0] as Map<String, dynamic>;
        final entityId = firstItem['entity_id'] as String?;
        if (entityId == null) continue;
        if (entityId != powerKey && entityId != thresholdKey) continue;

        for (var rec in array) {
          final record = rec as Map<String, dynamic>;
          final tsStr = record['last_changed'] as String?;
          final stateStr = record['state'] as String?;
          if (tsStr == null || stateStr == null) continue;
          final DateTime? rawUtc = DateTime.tryParse(tsStr);
          if (rawUtc == null) continue;
          final DateTime localTs = rawUtc.add(const Duration(hours: 4));
          if (localTs.isBefore(cutoff) || localTs.isAfter(localNow)) continue;
          final DateTime slotTs = DateTime(
            localTs.year,
            localTs.month,
            localTs.day,
            localTs.hour,
            localTs.minute - (localTs.minute % 30),
          );
          final double? val = double.tryParse(stateStr);
          if (val == null) continue;
          if (latestDataTime == null || localTs.isAfter(latestDataTime)) {
            latestDataTime = localTs;
          }
          if (entityId == powerKey) {
            powerMap.putIfAbsent(slotTs, () => []).add(val);
          } else {
            threshMap.putIfAbsent(slotTs, () => []).add(val);
          }
        }
      }
    }

    if (latestDataTime == null) {
      setState(() {
        chartData = [];
      });
      return;
    }

    // 3) Define the end time as the earlier of latest data time or now.
    final DateTime endTime =
        latestDataTime!.isBefore(localNow) ? latestDataTime! : localNow;

    // Round down cutoff and end times to 30-minute boundaries.
    DateTime startSlot = DateTime(
      cutoff.year,
      cutoff.month,
      cutoff.day,
      cutoff.hour,
      cutoff.minute - (cutoff.minute % 30),
    );
    DateTime endSlot = DateTime(
      endTime.year,
      endTime.month,
      endTime.day,
      endTime.hour,
      endTime.minute - (endTime.minute % 30),
    );

    // 4) Build the timeline.
    DateTime slot = startSlot;
    while (!slot.isAfter(endSlot)) {
      timeline.add(slot);
      slot = slot.add(const Duration(minutes: 30));
    }

    // 5) Compute average power and threshold for each slot.
    for (DateTime ts in timeline) {
      final List<double> pList = powerMap[ts] ?? [];
      final List<double> tList = threshMap[ts] ?? [];
      double avgP =
          pList.isNotEmpty ? pList.reduce((a, b) => a + b) / pList.length : 0.0;
      double avgT =
          tList.isNotEmpty ? tList.reduce((a, b) => a + b) / tList.length : 0.0;
      if (avgP > localMaxY) localMaxY = avgP;
      if (avgT > localMaxY) localMaxY = avgT;
      powerSeries.add(avgP);
      thresholdSeries.add(avgT);
    }

    // 6) Build chart data list.
    List<ChartData> tempData = [];
    for (int i = 0; i < timeline.length; i++) {
      final formatted = DateFormat.jm().format(timeline[i]); // e.g., "8:00 PM"
      final parts = formatted.split(' ');
      final label =
          (parts.length == 2) ? '${parts[0]}\n${parts[1]}' : formatted;
      tempData.add(ChartData(
        timeLabel: label,
        power: powerSeries[i],
        threshold: thresholdSeries[i],
      ));
    }

    // 7) Limit to maximum 9 bars.
    if (tempData.length > 9) {
      tempData = tempData.sublist(tempData.length - 9);
      double newMax = 0;
      for (var d in tempData) {
        if (d.power > newMax) newMax = d.power;
        if (d.threshold > newMax) newMax = d.threshold;
      }
      localMaxY = newMax;
    }

    setState(() {
      chartData = tempData;
      maxY = localMaxY;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    // Create custom annotations for threshold points.
    // Only include every even index to reduce crowding.
    final List<CartesianChartAnnotation> annotations = [];
    for (int i = 0; i < chartData.length; i++) {
      if (i % 2 == 0) {
        final data = chartData[i];
        annotations.add(
          CartesianChartAnnotation(
            widget: Padding(
              padding:
                  const EdgeInsets.only(top: 10), // Always 20px below the dot
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1500),
                builder: (context, animValue, child) {
                  return Opacity(
                    opacity: animValue,
                    child: Transform.translate(
                      // Animate from an extra 10px below to its final position
                      offset: Offset(0, 10 * (1 - animValue)),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  '${data.threshold.toStringAsFixed(1)} W',
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              ),
            ),
            coordinateUnit: CoordinateUnit.point,
            // Use the time label for x and threshold for y.
            x: data.timeLabel,
            y: data.threshold,
            horizontalAlignment: ChartAlignment.center,
            verticalAlignment: ChartAlignment.near,
          ),
        );
      }
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SfCartesianChart(
        backgroundColor: Colors.transparent,
        plotAreaBackgroundColor: Colors.transparent,
        margin: const EdgeInsets.all(10),
        plotAreaBorderWidth: 0,
        tooltipBehavior: _tooltipBehavior,
        annotations: annotations,
        primaryXAxis: CategoryAxis(
          labelRotation: 0,
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          isVisible: false,
          majorGridLines: const MajorGridLines(width: 0),
        ),
        series: <CartesianSeries<ChartData, String>>[
          // Column series for power with vertical gradient.
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.timeLabel,
            yValueMapper: (ChartData data, _) => data.power,
            name: 'Power',
            animationDuration: 1500,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            dataLabelSettings: const DataLabelSettings(isVisible: false),
            selectionBehavior: SelectionBehavior(
              enable: true,
              toggleSelection: false, // we manage toggling manually
              unselectedOpacity: 0.3,
            ),
            onPointTap: (ChartPointDetails details) {
              if (selectedIndex == details.pointIndex) {
                // Unselect: reset the column and hide tooltip.
                setState(() => selectedIndex = -1);
                _tooltipBehavior.hide();
              } else {
                setState(() => selectedIndex = details.pointIndex!);
                _tooltipBehavior.showByIndex(
                    details.seriesIndex!, details.pointIndex!);
              }
            },
            onCreateShader: (ShaderDetails details) {
              final rect = Rect.fromLTWH(0, 0, widget.width, widget.height);
              return const LinearGradient(
                colors: [Colors.transparent, Colors.blue],
                stops: [0.0, 1.0],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(rect);
            },
          ),
          // Spline series for threshold with markers.
          SplineSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.timeLabel,
            yValueMapper: (ChartData data, _) =>
                (data.threshold == 0) ? null : data.threshold,
            name: 'Threshold',
            animationDuration: 1500,
            splineType: SplineType.natural,
            width: 4,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              width: 12,
              height: 12,
            ),
            selectionBehavior: SelectionBehavior(
              enable: true,
              toggleSelection: true, // we manage toggling manually
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
              final rect = Rect.fromLTWH(0, 0, widget.width, widget.height);
              return const LinearGradient(
                colors: [Colors.orange, Colors.red],
                stops: [0.0, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(rect);
            },
          ),
        ],
      ),
    );
  }
}
