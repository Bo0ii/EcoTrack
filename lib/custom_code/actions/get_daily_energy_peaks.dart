// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl/intl.dart';

List<dynamic> getDailyEnergyPeaks(List<dynamic> historyData, int days) {
  final Map<String, double> lastReadingByDate = {};

  for (var record in historyData) {
    if (record is! Map<String, dynamic>) continue;

    final timeStr = record['last_changed'] ?? record['last_updated'];
    final valueStr = record['state'];
    if (timeStr == null || valueStr == null) continue;

    final ts = DateTime.tryParse(timeStr);
    final val = double.tryParse(valueStr.toString());
    if (ts == null || val == null) continue;

    final localDate = ts.toUtc().add(const Duration(hours: 4));
    final key = "${localDate.year}-${localDate.month}-${localDate.day}";

    lastReadingByDate[key] = val;
  }

  final List<dynamic> output = [];
  final sortedKeys = lastReadingByDate.keys.toList()..sort();
  final recentKeys = sortedKeys.takeLast(days);

  for (final key in recentKeys) {
    final parts = key.split("-");
    final formatted = DateFormat.MMMd().format(DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    ));
    output.add({
      "date": formatted,
      "value": lastReadingByDate[key],
    });
  }

  return output;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
