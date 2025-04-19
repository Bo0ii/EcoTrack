import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_new_widget.dart' show HomeNewWidget;
import 'package:flutter/material.dart';

class HomeNewModel extends FlutterFlowModel<HomeNewWidget> {
  ///  Local state fields for this page.

  DocumentReference? totalCost;

  String? userDeviceIds;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in HomeNew widget.
  UsersRecord? adminUser;
  // Stores action output result for [Firestore Query - Query a collection] action in HomeNew widget.
  DevicesRecord? deviceRef;
  // Stores action output result for [Backend Call - API (GetSensorData)] action in HomeNew widget.
  ApiCallResponse? sensordataAPIpageload;
  // Stores action output result for [Firestore Query - Query a collection] action in HomeNew widget.
  UserDirectoryRecord? userDirectoryEntry;
  // Stores action output result for [Firestore Query - Query a collection] action in HomeNew widget.
  UsersInHouseholdRecord? userinhouseholdREF;
  // Stores action output result for [Firestore Query - Query a collection] action in HomeNew widget.
  DevicesRecord? deviceRef2;
  // Stores action output result for [Backend Call - API (GetSensorData)] action in HomeNew widget.
  ApiCallResponse? sensordataAPIpageload2;
  // Stores action output result for [Backend Call - API (ToggleRelayOn)] action in Container widget.
  ApiCallResponse? apiResultxizCopy;
  // Stores action output result for [Backend Call - API (ToggleRelayOFF)] action in Container widget.
  ApiCallResponse? apiResultghqCopy;
  // Stores action output result for [Custom Action - computeApiFilter] action in Row widget.
  String? computeApiFilter;
  // Stores action output result for [Custom Action - getPowerThresholdStartTime] action in Row widget.
  String? getPowerThresholdStartTime;
  // Stores action output result for [Custom Action - computeApiFilter] action in Row widget.
  String? computeApiFilterCopy;
  // Stores action output result for [Custom Action - getPowerThresholdStartTime] action in Row widget.
  String? getPowerThresholdStartTimeCopy;
  // State field(s) for householdIdnoID widget.
  FocusNode? householdIdnoIDFocusNode;
  TextEditingController? householdIdnoIDTextController;
  String? Function(BuildContext, String?)?
      householdIdnoIDTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? foundHousehold;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    householdIdnoIDFocusNode?.dispose();
    householdIdnoIDTextController?.dispose();

    navBarModel.dispose();
  }
}
