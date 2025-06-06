import '/backend/backend.dart';
import '/components/dark_light/dark_light_widget.dart';
import '/components/pssword_vald/pssword_vald_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'sign_up_widget.dart' show SignUpWidget;
import 'package:flutter/material.dart';

class SignUpModel extends FlutterFlowModel<SignUpWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for darkLight component.
  late DarkLightModel darkLightModel;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for householdId widget.
  FocusNode? householdIdFocusNode;
  TextEditingController? householdIdTextController;
  String? Function(BuildContext, String?)? householdIdTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for passwordConfirm widget.
  FocusNode? passwordConfirmFocusNode;
  TextEditingController? passwordConfirmTextController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)?
      passwordConfirmTextControllerValidator;
  // Model for PsswordVald component.
  late PsswordValdModel psswordValdModel1;
  // Model for PsswordVald component.
  late PsswordValdModel psswordValdModel2;
  // Model for PsswordVald component.
  late PsswordValdModel psswordValdModel3;
  // Model for PsswordVald component.
  late PsswordValdModel psswordValdModel4;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  UsersRecord? adminRef;

  @override
  void initState(BuildContext context) {
    darkLightModel = createModel(context, () => DarkLightModel());
    passwordVisibility = false;
    passwordConfirmVisibility = false;
    psswordValdModel1 = createModel(context, () => PsswordValdModel());
    psswordValdModel2 = createModel(context, () => PsswordValdModel());
    psswordValdModel3 = createModel(context, () => PsswordValdModel());
    psswordValdModel4 = createModel(context, () => PsswordValdModel());
  }

  @override
  void dispose() {
    darkLightModel.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    householdIdFocusNode?.dispose();
    householdIdTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmTextController?.dispose();

    psswordValdModel1.dispose();
    psswordValdModel2.dispose();
    psswordValdModel3.dispose();
    psswordValdModel4.dispose();
  }
}
