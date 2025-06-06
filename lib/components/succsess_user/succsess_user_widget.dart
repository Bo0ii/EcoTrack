import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'succsess_user_model.dart';
export 'succsess_user_model.dart';

class SuccsessUserWidget extends StatefulWidget {
  const SuccsessUserWidget({
    super.key,
    this.userRef,
  });

  final DocumentReference? userRef;

  @override
  State<SuccsessUserWidget> createState() => _SuccsessUserWidgetState();
}

class _SuccsessUserWidgetState extends State<SuccsessUserWidget> {
  late SuccsessUserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuccsessUserModel());
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
                      '31nzucyp' /* You have successfully register... */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: FlutterFlowTheme.of(context).bodyMedium,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.06, 0.83),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.goNamed(
                      S6Widget.routeName,
                      queryParameters: {
                        'userRef': serializeParam(
                          widget.userRef,
                          ParamType.DocumentReference,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 280),
                        ),
                      },
                    );
                  },
                  text: FFLocalizations.of(context).getText(
                    'bll665cz' /* Continue to setup */,
                  ),
                  options: FFButtonOptions(
                    width: 146.1,
                    height: 32.3,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF63B1BF),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: FlutterFlowTheme.of(context).titleSmall,
                          color: Colors.white,
                          fontSize: 13.0,
                          letterSpacing: 0.0,
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
