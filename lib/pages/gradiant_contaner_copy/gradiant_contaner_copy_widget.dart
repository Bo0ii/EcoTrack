import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'gradiant_contaner_copy_model.dart';
export 'gradiant_contaner_copy_model.dart';

class GradiantContanerCopyWidget extends StatefulWidget {
  const GradiantContanerCopyWidget({super.key});

  static String routeName = 'GradiantContanerCopy';
  static String routePath = '/gradiantContanerCopy';

  @override
  State<GradiantContanerCopyWidget> createState() =>
      _GradiantContanerCopyWidgetState();
}

class _GradiantContanerCopyWidgetState extends State<GradiantContanerCopyWidget>
    with TickerProviderStateMixin {
  late GradiantContanerCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GradiantContanerCopyModel());

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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Opacity(
                          opacity: 0.9,
                          child: Lottie.asset(
                            'assets/jsons/Animation_-_1744078081068.json',
                            width: 392.83,
                            height: 870.0,
                            fit: BoxFit.fill,
                            frameRate: FrameRate(120.0),
                            reverse: true,
                            animate: true,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.17),
                          child: Container(
                            width: 393.7,
                            height: 466.47,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white, Color(0x00FFFFFF)],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.99),
                          child: Container(
                            width: 393.7,
                            height: 386.01,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0x00FFFFFF), Colors.white],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                            ),
                          ),
                        ),
                      ],
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
