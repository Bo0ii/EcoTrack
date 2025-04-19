import '/backend/api_requests/api_calls.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'carbon_emissions_widget.dart' show CarbonEmissionsWidget;
import 'package:flutter/material.dart';

class CarbonEmissionsModel extends FlutterFlowModel<CarbonEmissionsWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetSensorData)] action in CarbonEmissions widget.
  ApiCallResponse? sensordataAPIpageload3;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    navBarModel.dispose();
  }
}
