import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'noti_settings_widget.dart' show NotiSettingsWidget;
import 'package:flutter/material.dart';

class NotiSettingsModel extends FlutterFlowModel<NotiSettingsWidget> {
  ///  Local state fields for this page.

  bool isEmailValid = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Push_Notifications widget.
  bool? pushNotificationsValue;
  // State field(s) for Email_Notifications widget.
  bool? emailNotificationsValue;
  // State field(s) for Location_Tracking widget.
  bool? locationTrackingValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
