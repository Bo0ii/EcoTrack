// Automatic FlutterFlow imports
import '/backend/backend.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String computeEnergySensorId(String deviceId) {
  deviceId = deviceId.toLowerCase();
  final regex = RegExp(r"^.*?(\d+)$");
  final match = regex.firstMatch(deviceId);

  if (match != null) {
    return "sensor.${deviceId}_pzem_energy_kwh_${match.group(1)}";
  } else {
    return "sensor.${deviceId}_pzem_energy_kwh";
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
