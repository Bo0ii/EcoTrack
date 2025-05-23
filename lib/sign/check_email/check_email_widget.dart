import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'check_email_model.dart';
export 'check_email_model.dart';

class CheckEmailWidget extends StatefulWidget {
  const CheckEmailWidget({super.key});

  static String routeName = 'CheckEmail';
  static String routePath = '/checkEmail';

  @override
  State<CheckEmailWidget> createState() => _CheckEmailWidgetState();
}

class _CheckEmailWidgetState extends State<CheckEmailWidget> {
  late CheckEmailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckEmailModel());
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
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        valueOrDefault<double>(
                          MediaQuery.sizeOf(context).width >= 512.0
                              ? 72.0
                              : 32.0,
                          0.0,
                        ),
                        0.0,
                        valueOrDefault<double>(
                          MediaQuery.sizeOf(context).width >= 512.0
                              ? 72.0
                              : 32.0,
                          0.0,
                        )),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 512.0,
                      ),
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 64.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 10.0, 0.0, 0.0),
                                              child: Lottie.asset(
                                                'assets/jsons/Animation_-_1742592529666_(1).json',
                                                width: 188.04,
                                                height: 184.6,
                                                fit: BoxFit.contain,
                                                frameRate: FrameRate(120.0),
                                                repeat: false,
                                                animate: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '7xhtonw5' /* Check Your Email */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .headlineLarge
                                                .override(
                                                  font: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineLarge,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  lineHeight: 1.3,
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'kk32ee64' /* We’ve sent a password reset li... */,
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                  color: Color(0xFF979494),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.3,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 0.0, 16.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              context.pushNamed(
                                                LoginPageWidget.routeName,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType
                                                            .leftToRight,
                                                  ),
                                                },
                                              );
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              '8j0qqe9q' /* Back to Sign in */,
                                            ),
                                            options: FFButtonOptions(
                                              width: 230.0,
                                              height: 52.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        font:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall,
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                      ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 32.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
