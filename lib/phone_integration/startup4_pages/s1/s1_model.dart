import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 's1_widget.dart' show S1Widget;
import 'package:flutter/material.dart';

class S1Model extends FlutterFlowModel<S1Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for MyHome widget.
  FocusNode? myHomeFocusNode;
  TextEditingController? myHomeTextController;
  String? Function(BuildContext, String?)? myHomeTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    myHomeFocusNode?.dispose();
    myHomeTextController?.dispose();
  }
}
