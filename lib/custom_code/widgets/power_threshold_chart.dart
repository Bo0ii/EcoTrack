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
import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart'; // For compute()

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

Future<List<ChartData>> processChartData(Map<String, dynamic> args) async {
  final List<dynamic> historyData = args['historyData'];
  final String deviceId = args['deviceId'];

  final powerPrefix = 'sensor.${deviceId}_pzem_power';
  final thresholdPrefix = 'sensor.${deviceId}_threshold';

  final nowUtc = DateTime.now().toUtc();
  final localNow = nowUtc.add(const Duration(hours: 4));
  final cutoff = localNow.subtract(const Duration(hours: 6));

  final powerMap = <DateTime, List<double>>{};
  final threshMap = <DateTime, List<double>>{};
  DateTime? latestDataTime;

  for (var array in historyData) {
    if (array is List) {
      for (var rec in array) {
        if (rec is! Map<String, dynamic>) continue;
        final entityId = rec['entity_id'] as String?;
        if (entityId == null) continue;

        final isPower = entityId.startsWith(powerPrefix);
        final isThreshold = entityId.startsWith(thresholdPrefix);
        if (!isPower && !isThreshold) continue;

        final tsStr = rec['last_changed'] as String?;
        final stateStr = rec['state'] as String?;
        if (tsStr == null || stateStr == null) continue;
        final rawUtc = DateTime.tryParse(tsStr);
        if (rawUtc == null) continue;
        final localTs = rawUtc.add(const Duration(hours: 4));
        if (localTs.isBefore(cutoff) || localTs.isAfter(localNow)) continue;

        final slotTs = DateTime(
          localTs.year,
          localTs.month,
          localTs.day,
          localTs.hour,
          localTs.minute - (localTs.minute % 30),
        );

        final val = double.tryParse(stateStr);
        if (val == null) continue;

        if (latestDataTime == null || localTs.isAfter(latestDataTime)) {
          latestDataTime = localTs;
        }

        if (isPower) {
          powerMap.putIfAbsent(slotTs, () => []).add(val);
        } else if (isThreshold) {
          threshMap.putIfAbsent(slotTs, () => []).add(val);
        }
      }
    }
  }

  if (latestDataTime == null) return [];

  final endTime = latestDataTime.isBefore(localNow) ? latestDataTime : localNow;
  final startSlot = DateTime(
    cutoff.year,
    cutoff.month,
    cutoff.day,
    cutoff.hour,
    cutoff.minute - (cutoff.minute % 30),
  );
  final endSlot = DateTime(
    endTime.year,
    endTime.month,
    endTime.day,
    endTime.hour,
    endTime.minute - (endTime.minute % 30),
  );

  List<DateTime> timeline = [];
  DateTime slot = startSlot;
  while (!slot.isAfter(endSlot)) {
    timeline.add(slot);
    slot = slot.add(const Duration(minutes: 30));
  }

  List<ChartData> tempData = [];
  for (DateTime ts in timeline) {
    final pList = powerMap[ts] ?? [];
    final tList = threshMap[ts] ?? [];
    final avgP =
        pList.isNotEmpty ? pList.reduce((a, b) => a + b) / pList.length : 0.0;
    final avgT =
        tList.isNotEmpty ? tList.reduce((a, b) => a + b) / tList.length : 0.0;
    final formatted = DateFormat.jm().format(ts);
    final parts = formatted.split(' ');
    final label = parts.length == 2 ? '${parts[0]}\n${parts[1]}' : formatted;

    tempData.add(ChartData(
      timeLabel: label,
      power: avgP,
      threshold: avgT,
    ));
  }

  if (tempData.length > 9) {
    tempData = tempData.sublist(tempData.length - 9);
  }

  return tempData;
}

class PowerThresholdChart extends StatefulWidget {
  final double width;
  final double height;
  final List<dynamic> historyData;
  final String deviceId;

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
  int selectedIndex = -1;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      header: '',
      canShowMarker: true,
      duration: 999999,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _processData();
      _timer = Timer.periodic(
          const Duration(minutes: 10), (timer) => _processData());
    });
  }

  @override
  void didUpdateWidget(covariant PowerThresholdChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.historyData != oldWidget.historyData) {
      _processData();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _processData() async {
    if (widget.historyData.isEmpty) return;
    final args = {
      'historyData': widget.historyData,
      'deviceId': widget.deviceId,
    };

    final List<ChartData> processedData = await compute(processChartData, args);

    double max = 0;
    for (var d in processedData) {
      if (d.power > max) max = d.power;
      if (d.threshold > max) max = d.threshold;
    }

    if (mounted) {
      setState(() {
        chartData = processedData;
        maxY = max;
      });
    }
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

    final List<CartesianChartAnnotation> annotations = [];
    for (int i = 0; i < chartData.length; i++) {
      if (i % 2 == 0) {
        final data = chartData[i];
        annotations.add(
          CartesianChartAnnotation(
            widget: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1500),
                builder: (context, animValue, child) {
                  return Opacity(
                    opacity: animValue,
                    child: Transform.translate(
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
              toggleSelection: true,
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
