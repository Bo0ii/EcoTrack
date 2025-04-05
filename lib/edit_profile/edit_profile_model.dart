import '/flutter_flow/flutter_flow_util.dart';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:flutter/material.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  // State field(s) for yourAge widget.
  FocusNode? yourAgeFocusNode;
  TextEditingController? yourAgeTextController;
  String? Function(BuildContext, String?)? yourAgeTextControllerValidator;
  // State field(s) for yourTitle widget.
  FocusNode? yourTitleFocusNode1;
  TextEditingController? yourTitleTextController1;
  String? Function(BuildContext, String?)? yourTitleTextController1Validator;
  // State field(s) for yourTitle widget.
  FocusNode? yourTitleFocusNode2;
  TextEditingController? yourTitleTextController2;
  String? Function(BuildContext, String?)? yourTitleTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();

    yourAgeFocusNode?.dispose();
    yourAgeTextController?.dispose();

    yourTitleFocusNode1?.dispose();
    yourTitleTextController1?.dispose();

    yourTitleFocusNode2?.dispose();
    yourTitleTextController2?.dispose();
  }
}
