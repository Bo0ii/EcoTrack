// Automatic FlutterFlow imports
import '/backend/backend.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Top-level variables to cache the start time and when it was computed.
String? _cachedStartTime;
DateTime? _cachedTimestamp;

/// Returns an ISO8601 formatted string for the time "local now minus 6 hours."
/// Instead of recalculating on every call, this function caches the value
/// and only refreshes it if more than 60 seconds have passed.
String getPowerThresholdStartTime() {
  // Get the current UTC time.
  final DateTime nowUtc = DateTime.now().toUtc();

  // If there's no cached value, or if it's older than 60 seconds, recompute.
  if (_cachedStartTime == null ||
      _cachedTimestamp == null ||
      nowUtc.difference(_cachedTimestamp!).inSeconds > 60) {
    // Adjust to local time by adding 4 hours.
    final DateTime localNow = nowUtc.add(const Duration(hours: 4));
    // Subtract 6 hours to represent the last 6 hours’ cutoff.
    final DateTime startTime = localNow.subtract(const Duration(hours: 6));
    // Cache the computed start time and timestamp.
    _cachedStartTime = startTime.toIso8601String();
    _cachedTimestamp = nowUtc;
  }

  return _cachedStartTime!;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
