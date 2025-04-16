import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'de_link_model.dart';
export 'de_link_model.dart';

class DeLinkWidget extends StatefulWidget {
  const DeLinkWidget({
    super.key,
    required this.devicRef,
    required this.deviceId,
    this.friendlyName,
  });

  final DocumentReference? devicRef;
  final String? deviceId;
  final String? friendlyName;

  @override
  State<DeLinkWidget> createState() => _DeLinkWidgetState();
}

class _DeLinkWidgetState extends State<DeLinkWidget> {
  late DeLinkModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeLinkModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 230.0,
          height: 230.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFF4A2A2)],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(-0.34, -1.0),
              end: AlignmentDirectional(0.34, 1.0),
            ),
            borderRadius: BorderRadius.circular(26.0),
            border: Border.all(
              color: Color(0xFFA1A1A1),
            ),
          ),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.9,
                child: Align(
                  alignment: AlignmentDirectional(0.22, -0.92),
                  child: Lottie.asset(
                    'assets/jsons/Animation_-_1744583730309-YCA6d.json',
                    width: 135.16,
                    height: 71.9,
                    fit: BoxFit.cover,
                    frameRate: FrameRate(120.0),
                    reverse: true,
                    animate: true,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.31),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(19.0, 0.0, 19.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'tvfx1jwz' /* Are you sure you want to Delin... */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: Color(0xFF7E8993),
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.69, 0.83),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed(
                      DetailedDeviceInfoWidget.routeName,
                      queryParameters: {
                        'deviceId': serializeParam(
                          '',
                          ParamType.String,
                        ),
                        'deviceReference': serializeParam(
                          widget.devicRef,
                          ParamType.DocumentReference,
                        ),
                        'deviceName': serializeParam(
                          widget.friendlyName,
                          ParamType.String,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                        ),
                      },
                    );
                  },
                  text: FFLocalizations.of(context).getText(
                    'bcampsbo' /* No */,
                  ),
                  options: FFButtonOptions(
                    width: 85.5,
                    height: 32.3,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF97C0C7),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: Colors.white,
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily),
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.76, 0.82),
                child: FFButtonWidget(
                  onPressed: () async {
                    await widget.devicRef!.delete();

                    context.pushNamed(HomeNewWidget.routeName);
                  },
                  text: FFLocalizations.of(context).getText(
                    'njkyhfuq' /* Yes */,
                  ),
                  options: FFButtonOptions(
                    width: 85.5,
                    height: 32.3,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFFDE5656),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: Colors.white,
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily),
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
