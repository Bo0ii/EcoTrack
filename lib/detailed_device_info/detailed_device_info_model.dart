import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'detailed_device_info_widget.dart' show DetailedDeviceInfoWidget;
import 'package:flutter/material.dart';

class DetailedDeviceInfoModel
    extends FlutterFlowModel<DetailedDeviceInfoWidget> {
  ///  Local state fields for this page.

  bool isEmailValid = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (powerXthreshhold)] action in DetailedDeviceInfo widget.
  ApiCallResponse? powerXthreshhold;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
