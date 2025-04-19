import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'detailed_device_info_widget.dart' show DetailedDeviceInfoWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedDeviceInfoModel
    extends FlutterFlowModel<DetailedDeviceInfoWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (powerXthreshhold)] action in DetailedDeviceInfo widget.
  ApiCallResponse? powerxthreshold;
  InstantTimer? instantTimer2;
  // Stores action output result for [Backend Call - API (GetSensorData)] action in DetailedDeviceInfo widget.
  ApiCallResponse? sensordataAPIpageload;
  InstantTimer? instantTimer3;
  // Stores action output result for [Backend Call - API (dailyEnergyList)] action in DetailedDeviceInfo widget.
  ApiCallResponse? dailyEnergyListAPI;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - API (ToggleRelayOn)] action in Container widget.
  ApiCallResponse? apiResultxizCopy;
  // Stores action output result for [Backend Call - API (ToggleRelayOFF)] action in Container widget.
  ApiCallResponse? apiResultghqCopy;
  DateTime? datePicked1;
  // Stores action output result for [Backend Call - API (workingSchedule)] action in Text widget.
  ApiCallResponse? selectedStartTimeAPI;
  DateTime? datePicked2;
  // Stores action output result for [Backend Call - API (workingSchedule)] action in Text widget.
  ApiCallResponse? selectedStopTimeAPI;
  // Stores action output result for [Backend Call - API (workingSchedule)] action in Icon widget.
  ApiCallResponse? resetStartTimeAPI;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer2?.cancel();
    instantTimer3?.cancel();
  }
}
