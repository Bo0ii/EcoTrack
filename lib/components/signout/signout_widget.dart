import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'signout_model.dart';
export 'signout_model.dart';

class SignoutWidget extends StatefulWidget {
  const SignoutWidget({super.key});

  @override
  State<SignoutWidget> createState() => _SignoutWidgetState();
}

class _SignoutWidgetState extends State<SignoutWidget> {
  late SignoutModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignoutModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
          width: 220.0,
          height: 220.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFD1E7E9)],
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
                  width: 76.54,
                  height: 71.9,
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
                      'g8k6isnh' /* You have successfully register... */,
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
                      S1Widget.routeName,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.leftToRight,
                        ),
                      },
                    );
                  },
                  text: FFLocalizations.of(context).getText(
                    'nlyc059p' /* Continue to setup */,
                  ),
                  options: FFButtonOptions(
                    width: 146.1,
                    height: 32.3,
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
