import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_new_copy_widget.dart' show HomeNewCopyWidget;
import 'package:flutter/material.dart';

class HomeNewCopyModel extends FlutterFlowModel<HomeNewCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in HomeNewCopy widget.
  UsersRecord? userREF;
  // Stores action output result for [Firestore Query - Query a collection] action in HomeNewCopy widget.
  DevicesRecord? deviceRef;
  // Stores action output result for [Backend Call - API (GetSensorData)] action in HomeNewCopy widget.
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
