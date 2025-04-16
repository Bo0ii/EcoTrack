import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
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

class _GradiantContanerCopyWidgetState
    extends State<GradiantContanerCopyWidget> {
  late GradiantContanerCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GradiantContanerCopyModel());
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
        body: Stack(
          children: [
            Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Container(
                        width: 593.4,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Transform.scale(
                          scaleX: 1.6,
                          scaleY: 1.0,
                          origin: Offset(38.0, 99.0),
                          child: ClipRect(
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 14.0,
                                sigmaY: 14.0,
                              ),
                              child: Opacity(
                                opacity: 0.8,
                                child: Lottie.asset(
                                  'assets/jsons/Main_Scene_(3).json',
                                  width: 787.9,
                                  height: 394.7,
                                  fit: BoxFit.cover,
                                  frameRate: FrameRate(60.0),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
