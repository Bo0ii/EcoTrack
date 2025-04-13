import '/backend/backend.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'automation_widget.dart' show AutomationWidget;
import 'package:flutter/material.dart';

class AutomationModel extends FlutterFlowModel<AutomationWidget> {
  ///  Local state fields for this page.

  List<String> userDeviceIds = [];
  void addToUserDeviceIds(String item) => userDeviceIds.add(item);
  void removeFromUserDeviceIds(String item) => userDeviceIds.remove(item);
  void removeAtIndexFromUserDeviceIds(int index) =>
      userDeviceIds.removeAt(index);
  void insertAtIndexInUserDeviceIds(int index, String item) =>
      userDeviceIds.insert(index, item);
  void updateUserDeviceIdsAtIndex(int index, Function(String) updateFn) =>
      userDeviceIds[index] = updateFn(userDeviceIds[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Automation widget.
  List<DevicesRecord>? deviceList;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // State field(s) for Switch widget.
  bool? switchValue3;
  // State field(s) for Switch widget.
  bool? switchValue4;
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
