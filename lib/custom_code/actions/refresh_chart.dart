// Automatic FlutterFlow imports
import '/backend/backend.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_charts/charts.dart'; // Ensure Syncfusion is imported

Future<void> refreshChart(BuildContext context) async {
  print("Refreshing chart...");

  // Ensure FlutterFlow detects state change
  FFAppState().update(() {
    FFAppState().powerState = List.from(FFAppState().powerState);
    FFAppState().timeState = List.from(FFAppState().timeState);
  });

  // Find the nearest chart widget and trigger a rebuild
  final state = context.findAncestorStateOfType<State>();
  state?.setState(() {});

  print("Chart refresh complete.");
}
