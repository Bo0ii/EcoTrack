// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// This custom action returns a string that is a comma-separated list of the sensor IDs.
String computeApiFilter(String deviceId) {
  // Convert the deviceId to lowercase to match Home Assistant's naming convention.
  deviceId = deviceId.toLowerCase();

  // Use a regular expression to separate the alphabetic part from any trailing digits.
  // For example, if deviceId is "ecot2":
  //   match.group(1) will be "ecot"
  //   match.group(2) will be "2"
  final RegExp regex = RegExp(r'^(.*?)(\d+)$');
  final Match? match = regex.firstMatch(deviceId);

  String sensorPowerId;
  String sensorThresholdId;

  if (match != null) {
    // Build sensor IDs such that:
    // For deviceId "ecot2":
    //   sensorPowerId becomes "sensor.ecot2_pzem_power_2"
    //   sensorThresholdId becomes "sensor.ecot2_threshold_2"
    sensorPowerId = 'sensor.' + deviceId + '_pzem_power_' + match.group(2)!;
    sensorThresholdId = 'sensor.' + deviceId + '_threshold_' + match.group(2)!;
  } else {
    // If deviceId has no trailing numbers, use a standard format.
    sensorPowerId = 'sensor.' + deviceId + '_pzem_power';
    sensorThresholdId = 'sensor.' + deviceId + '_threshold';
  }

  // Combine the two sensor IDs separated by a comma.
  return sensorPowerId + ',' + sensorThresholdId;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
