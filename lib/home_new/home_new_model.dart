import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
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
  var scanDeviceId = '';
  // Stores action output result for [Backend Call - API (ToggleRelayOn)] action in Container widget.
  ApiCallResponse? apiResultxizCopy;
  // Stores action output result for [Backend Call - API (ToggleRelayOFF)] action in Container widget.
  ApiCallResponse? apiResultghqCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
