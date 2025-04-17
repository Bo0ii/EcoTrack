import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 's4qr_widget.dart' show S4qrWidget;
import 'package:flutter/material.dart';

class S4qrModel extends FlutterFlowModel<S4qrWidget> {
  ///  Local state fields for this page.

  String? qrCodeString;

  String? editedFriendlyName;

  ///  State fields for stateful widgets in this page.

  // State field(s) for plugname widget.
  FocusNode? plugnameFocusNode;
  TextEditingController? plugnameTextController;
  String? Function(BuildContext, String?)? plugnameTextControllerValidator;
  // State field(s) for pluglocation widget.
  FormFieldController<List<String>>? pluglocationValueController;
  String? get pluglocationValue =>
      pluglocationValueController?.value?.firstOrNull;
  set pluglocationValue(String? val) =>
      pluglocationValueController?.value = val != null ? [val] : [];
  var qrCodeR = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    plugnameFocusNode?.dispose();
    plugnameTextController?.dispose();
  }
}
