// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Returns an ISO8601 formatted string for the time "local now minus 6 hours"
// using the same regional time logic as in the PowerX Threshold widget.
String getPowerThresholdStartTime() {
  // Get the current UTC time.
  final DateTime nowUtc = DateTime.now().toUtc();

  // Adjust to local time by adding 4 hours.
  final DateTime localNow = nowUtc.add(const Duration(hours: 4));

  // Subtract 6 hours to represent the last 6 hours’ cutoff.
  final DateTime startTime = localNow.subtract(const Duration(hours: 6));

  // Return the ISO8601 formatted string.
  return startTime.toIso8601String();
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
