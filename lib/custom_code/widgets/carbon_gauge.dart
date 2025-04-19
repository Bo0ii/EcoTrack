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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CarbonGauge extends StatelessWidget {
  final double width;
  final double height;
  final String value;

  const CarbonGauge({
    Key? key,
    required this.width,
    required this.height,
    required this.value,
  }) : super(key: key);

  double extractNumber(String text) {
    for (final part in text.split(RegExp(r'[^0-9.,]+'))) {
      final parsed = double.tryParse(part.replaceAll(',', '.'));
      if (parsed != null) return parsed;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final double parsedValue = extractNumber(value);
    const double maxValue = 1.5;

    final double clampedValue = parsedValue.clamp(0.0, maxValue);
    final double displayValue = clampedValue < 0.01 ? 0.01 : clampedValue;

    Color getColorForValue(double value) {
      if (value <= 0.29) return const Color(0xFF5BA6A6); // Green
      if (value <= 1.0) return const Color(0xFFFFD700); // Yellow
      return const Color(0xFFFF8C00); // Orange
    }

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.topCenter, // Keep gauge aligned at the top
        children: [
          SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 1500,
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: maxValue,
                startAngle: 180,
                endAngle: 0,
                showTicks: false,
                showLabels: false,
                canScaleToFit: true,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.15,
                  thicknessUnit: GaugeSizeUnit.factor,
                  color: Color(0xFFEAEAEA),
                ),
                pointers: [
                  RangePointer(
                    value: displayValue,
                    width: 0.15,
                    sizeUnit: GaugeSizeUnit.factor,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    animationType: AnimationType.easeOutBack,
                    color: getColorForValue(clampedValue),
                  ),
                  NeedlePointer(
                    value: displayValue,
                    enableAnimation: true,
                    animationType: AnimationType.easeOutBack,
                    needleLength: 0.85,
                    needleStartWidth: 2,
                    needleEndWidth: 4,
                    knobStyle: const KnobStyle(knobRadius: 0),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromRGBO(91, 166, 166, 0),
                        Color(0xFF5BA6A6),
                      ],
                      stops: [0.2, 0.8],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: -20, // Push text further down below the needle
            child: Column(
              children: [
                Text(
                  '${clampedValue.toStringAsFixed(3)} Kg/CO₂',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5BA6A6),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Carbon Footprint',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
