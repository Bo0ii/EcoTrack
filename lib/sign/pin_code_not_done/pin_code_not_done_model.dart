import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pin_code_not_done_widget.dart' show PinCodeNotDoneWidget;
import 'package:flutter/material.dart';

class PinCodeNotDoneModel extends FlutterFlowModel<PinCodeNotDoneWidget> {
  ///  Local state fields for this page.

  bool isEmailValid = true;

  bool codeResent = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();
  }
}
