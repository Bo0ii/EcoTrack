import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'noti_settings_model.dart';
export 'noti_settings_model.dart';

class NotiSettingsWidget extends StatefulWidget {
  const NotiSettingsWidget({super.key});

  static String routeName = 'notiSettings';
  static String routePath = '/notiSettings';

  @override
  State<NotiSettingsWidget> createState() => _NotiSettingsWidgetState();
}

class _NotiSettingsWidgetState extends State<NotiSettingsWidget> {
  late NotiSettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotiSettingsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 500.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xA3C6FEFF),
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white
                    ],
                    stops: [0.0, 0.4, 0.6, 0.7, 0.95],
                    begin: AlignmentDirectional(-1.0, -0.98),
                    end: AlignmentDirectional(1.0, 0.98),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30.0,
                                    borderWidth: 1.0,
                                    buttonSize: 50.0,
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Color(0xFF373737),
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      context.pushNamed(
                                        ProfileWidget.routeName,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.leftToRight,
                                            duration:
                                                Duration(milliseconds: 220),
                                          ),
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: SwitchListTile.adaptive(
                            value: _model.pushNotificationsValue ??= true,
                            onChanged: (newValue) async {
                              safeSetState(() =>
                                  _model.pushNotificationsValue = newValue);
                              if (newValue) {
                                await requestPermission(
                                    notificationsPermission);
                                HapticFeedback.lightImpact();
                              }
                            },
                            title: Text(
                              FFLocalizations.of(context).getText(
                                'e50x4ad4' /* Push Notifications */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineSmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .headlineSmallFamily),
                                  ),
                            ),
                            subtitle: Text(
                              FFLocalizations.of(context).getText(
                                'rrx166ap' /* Receive Push notifications fro... */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodySmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodySmallFamily),
                                  ),
                            ),
                            activeColor: Color(0xFF73ACAE),
                            activeTrackColor: Color(0xFFB8D2D2),
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 12.0, 24.0, 12.0),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: SwitchListTile.adaptive(
                            value: _model.emailNotificationsValue ??= true,
                            onChanged: (newValue) async {
                              safeSetState(() =>
                                  _model.emailNotificationsValue = newValue);
                              if (newValue) {
                                await requestPermission(
                                    notificationsPermission);
                                HapticFeedback.lightImpact();
                              }
                            },
                            title: Text(
                              FFLocalizations.of(context).getText(
                                'e5wswlxp' /* Email Notifications */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineSmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .headlineSmallFamily),
                                  ),
                            ),
                            subtitle: Text(
                              FFLocalizations.of(context).getText(
                                'zbsm9zqa' /* Receive email notifications fr... */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodySmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodySmallFamily),
                                  ),
                            ),
                            activeColor: Color(0xFF639D9F),
                            activeTrackColor: Color(0xFFB8D2D2),
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 12.0, 24.0, 12.0),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: SwitchListTile.adaptive(
                            value: _model.locationTrackingValue ??= true,
                            onChanged: (newValue) async {
                              safeSetState(() =>
                                  _model.locationTrackingValue = newValue);
                              if (newValue) {
                                await requestPermission(cameraPermission);
                                HapticFeedback.lightImpact();
                              }
                            },
                            title: Text(
                              FFLocalizations.of(context).getText(
                                'm4o3rzgz' /* Camera Control */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineSmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .headlineSmallFamily),
                                  ),
                            ),
                            subtitle: Text(
                              FFLocalizations.of(context).getText(
                                's8h1qkff' /* Allow us to track your locatio... */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodySmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodySmallFamily),
                                  ),
                            ),
                            activeColor: Color(0xFF639D9F),
                            activeTrackColor: Color(0xFFB8D2D2),
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 12.0, 24.0, 12.0),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 24.0, 0.0, 50.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  context.pop();
                                },
                                text: FFLocalizations.of(context).getText(
                                  'oqrff2pq' /* Save Changes */,
                                ),
                                options: FFButtonOptions(
                                  width: 190.0,
                                  height: 50.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .textColor,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
