import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'home_new_widget.dart' show HomeNewWidget;
import 'package:flutter/material.dart';

class HomeNewModel extends FlutterFlowModel<HomeNewWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in HomeNew widget.
  UsersRecord? userREF;
  // Stores action output result for [Firestore Query - Query a collection] action in HomeNew widget.
  DevicesRecord? deviceRef;
  // Stores action output result for [Backend Call - API (GetSensorData)] action in HomeNew widget.
  ApiCallResponse? sensordataAPIpageload;
  Completer<ApiCallResponse>? apiRequestCompleter;
  var scanDeviceId = '';
  // Stores action output result for [Backend Call - API (ToggleRelayOn)] action in Container widget.
  ApiCallResponse? apiResultxizCopy;
  // Stores action output result for [Backend Call - API (ToggleRelayOFF)] action in Container widget.
  ApiCallResponse? apiResultghqCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
