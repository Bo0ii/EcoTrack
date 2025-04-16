import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'proccessing_q_r_model.dart';
export 'proccessing_q_r_model.dart';

class ProccessingQRWidget extends StatefulWidget {
  const ProccessingQRWidget({super.key});

  @override
  State<ProccessingQRWidget> createState() => _ProccessingQRWidgetState();
}

class _ProccessingQRWidgetState extends State<ProccessingQRWidget> {
  late ProccessingQRModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProccessingQRModel());
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
          width: 237.47,
          height: 236.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD1E7E9), Colors.white],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(0.0, -1.0),
              end: AlignmentDirectional(0, 1.0),
            ),
            borderRadius: BorderRadius.circular(26.0),
            border: Border.all(
              color: Color(0xFFA1A1A1),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, -0.55),
                child: Lottie.asset(
                  'assets/jsons/Animation_-_1742663589083.json',
                  width: 86.26,
                  height: 84.9,
                  fit: BoxFit.cover,
                  frameRate: FrameRate(120.0),
                  repeat: false,
                  animate: true,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.37),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(19.0, 0.0, 19.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'kgjve6zb' /* You have successfully register... */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.06, 0.83),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.goNamed(
                      HomeNewWidget.routeName,
                      queryParameters: {
                        'email': serializeParam(
                          '',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 350),
                        ),
                      },
                    );
                  },
                  text: FFLocalizations.of(context).getText(
                    'jwvh4eaq' /* Back to home */,
                  ),
                  options: FFButtonOptions(
                    width: 141.1,
                    height: 31.26,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF63B1BF),
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
