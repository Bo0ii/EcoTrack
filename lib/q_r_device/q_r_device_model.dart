import '/flutter_flow/flutter_flow_util.dart';
import 'q_r_device_widget.dart' show QRDeviceWidget;
import 'package:flutter/material.dart';

class QRDeviceModel extends FlutterFlowModel<QRDeviceWidget> {
  ///  Local state fields for this page.

  String? qrCodeString;

  String? editedFriendlyName;

  ///  State fields for stateful widgets in this page.

  // State field(s) for plugname widget.
  FocusNode? plugnameFocusNode;
  TextEditingController? plugnameTextController;
  String? Function(BuildContext, String?)? plugnameTextControllerValidator;
  var qrCodeR = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    plugnameFocusNode?.dispose();
    plugnameTextController?.dispose();
  }
}
