import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'new_gradiant_model.dart';
export 'new_gradiant_model.dart';

class NewGradiantWidget extends StatefulWidget {
  const NewGradiantWidget({super.key});

  static String routeName = 'NewGradiant';
  static String routePath = '/newGradiant';

  @override
  State<NewGradiantWidget> createState() => _NewGradiantWidgetState();
}

class _NewGradiantWidgetState extends State<NewGradiantWidget>
    with TickerProviderStateMixin {
  late NewGradiantModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewGradiantModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(3.0, 3.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 500.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 593.4,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Transform.scale(
                            scaleX: 2.5,
                            scaleY: 1.6,
                            origin: Offset(59.0, -13.0),
                            child: ClipRect(
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                  sigmaX: 19.0,
                                  sigmaY: 19.0,
                                ),
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Lottie.asset(
                                    'assets/jsons/Animation_-_1744398367492.json',
                                    width: 787.9,
                                    height: 394.74,
                                    fit: BoxFit.cover,
                                    frameRate: FrameRate(120.0),
                                    reverse: true,
                                    animate: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Container(
                        width: 593.4,
                        height: 300.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Transform.scale(
                          scaleX: -2.4,
                          scaleY: -1.3,
                          origin: Offset(59.0, -13.0),
                          child: ClipRect(
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 19.0,
                                sigmaY: 19.0,
                              ),
                              child: Opacity(
                                opacity: 0.8,
                                child: Lottie.asset(
                                  'assets/jsons/Animation_-_1744398367492.json',
                                  width: 787.9,
                                  height: 281.8,
                                  fit: BoxFit.cover,
                                  frameRate: FrameRate(120.0),
                                  reverse: true,
                                  animate: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animateOnPageLoad(
                  animationsMap['containerOnPageLoadAnimation']!),
            ),
          ],
        ),
      ),
    );
  }
}
