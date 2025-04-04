import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'forget_password_widget.dart' show ForgetPasswordWidget;
import 'package:flutter/material.dart';

class ForgetPasswordModel extends FlutterFlowModel<ForgetPasswordWidget> {
  ///  Local state fields for this page.

  bool isEmailValid = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for householdId widget.
  FocusNode? householdIdFocusNode;
  TextEditingController? householdIdTextController;
  String? Function(BuildContext, String?)? householdIdTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    householdIdFocusNode?.dispose();
    householdIdTextController?.dispose();
  }
}
