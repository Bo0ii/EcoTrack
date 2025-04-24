import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_new_widget.dart' show HomeNewWidget;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeNewModel extends FlutterFlowModel<HomeNewWidget> {
  ///  Local state fields for this page.

  DocumentReference? totalCost;

  String? userDeviceIds;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for NavBar component.
  late NavBarModel navBarModel;
  // Stores action output result for [Backend Call - API (GetSensorData)] action in HomeNew widget.
  ApiCallResponse? sensordataAPIpageload;
  // Stores action output result for [Backend Call - API (GetSensorData)] action in HomeNew widget.
  ApiCallResponse? sensordataAPIpageload2;
  // Stores action output result for [Backend Call - Query - Users] action in HomeNew widget.
  UsersRecord? adminUser;
  // Stores action output result for [Backend Call - Query - Devices] action in HomeNew widget.
  DevicesRecord? deviceRef;
  // Stores action output result for [Backend Call - Query - UserDirectory] action in HomeNew widget.
  UserDirectoryRecord? userDirectoryEntry;
  // Stores action output result for [Backend Call - Query - UsersInHousehold] action in HomeNew widget.
  UsersInHouseholdRecord? userinhouseholdREF;
  // Stores action output result for [Backend Call - Query - Devices] action in HomeNew widget.
  DevicesRecord? deviceRef2;
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
  
  // Added Lottie animation controller and visibility state
  late AnimationController lottieController;
  late AnimationController lottieController2;
  bool isVisible = true;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
    lottieController = AnimationController(vsync: context as TickerProvider);
    lottieController2 = AnimationController(vsync: context as TickerProvider);
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navBarModel.dispose();
    lottieController.dispose();
    lottieController2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
