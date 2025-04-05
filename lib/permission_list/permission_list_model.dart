import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'permission_list_widget.dart' show PermissionListWidget;
import 'package:flutter/material.dart';

class PermissionListModel extends FlutterFlowModel<PermissionListWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in permissionList widget.
  UsersRecord? userRef;
  // Stores action output result for [Firestore Query - Query a collection] action in permissionList widget.
  DevicesRecord? selectedDeviceId;
  // State field(s) for Checkbox widget.
  Map<UsersInHouseholdRecord, bool> checkboxValueMap1 = {};
  List<UsersInHouseholdRecord> get checkboxCheckedItems1 =>
      checkboxValueMap1.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for Checkbox widget.
  Map<UsersInHouseholdRecord, bool> checkboxValueMap2 = {};
  List<UsersInHouseholdRecord> get checkboxCheckedItems2 =>
      checkboxValueMap2.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
