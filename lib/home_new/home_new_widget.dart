import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/loading/loading_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:math' as math;
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'home_new_model.dart';
export 'home_new_model.dart';

class HomeNewWidget extends StatefulWidget {
  const HomeNewWidget({
    super.key,
    String? email,
  }) : this.email = email ?? 'email';

  final String email;

  static String routeName = 'HomeNew';
  static String routePath = '/homeNew';

  @override
  State<HomeNewWidget> createState() => _HomeNewWidgetState();
}

class _HomeNewWidgetState extends State<HomeNewWidget>
    with TickerProviderStateMixin {
  late HomeNewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeNewModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.adminUser = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'email',
          isEqualTo: currentUserEmail,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.adminUser != null) {
        FFAppState().isAdmin = true;
        FFAppState().adminREFappState = _model.adminUser?.reference;
        FFAppState().displayName = _model.adminUser!.displayName;
        FFAppState().houseName = _model.adminUser!.nameOfHouse;
        FFAppState().deviceID = FFAppState().deviceID;
        safeSetState(() {});
        _model.deviceRef = await queryDevicesRecordOnce(
          parent: _model.adminUser?.reference,
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        while (FFAppState().isLooping == true) {
          _model.sensordataAPIpageload = await GetSensorDataCall.call(
            deviceId: _model.deviceRef?.deviceId,
          );

          FFAppState().sensorData = getJsonField(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
            r'''$''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          safeSetState(() {});
          FFAppState().weatherTemp = GetSensorDataCall.temperature(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
          )!;
          FFAppState().cloudCoverage = GetSensorDataCall.windspeed(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
          )!;
          FFAppState().humidity = GetSensorDataCall.humidity(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
          )!;
          FFAppState().weatherState = GetSensorDataCall.weatherstate(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
          )!;
          FFAppState().tips = GetSensorDataCall.tips(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
          )!;
          FFAppState().Tcost = GetSensorDataCall.tcost(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
          )!;
          FFAppState().Tenergy = GetSensorDataCall.tenergy(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
          )!;
          FFAppState().CostChange = GetSensorDataCall.costChange24h(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
          )!;
          FFAppState().energyChange = GetSensorDataCall.energyChnage24h(
            (_model.sensordataAPIpageload?.jsonBody ?? ''),
          )!;
          await Future.delayed(const Duration(milliseconds: 800));
        }
      } else {
        FFAppState().isAdmin = false;
        _model.userDirectoryEntry = await queryUserDirectoryRecordOnce(
          queryBuilder: (userDirectoryRecord) => userDirectoryRecord.where(
            'emai',
            isEqualTo: currentUserEmail,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        _model.userinhouseholdREF = await queryUsersInHouseholdRecordOnce(
          parent: _model.adminUser?.reference,
          queryBuilder: (usersInHouseholdRecord) =>
              usersInHouseholdRecord.where(
            'email',
            isEqualTo: currentUserEmail,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        FFAppState().displayName = _model.userinhouseholdREF!.displayName;
        FFAppState().houseName = _model.adminUser!.nameOfHouse;
        FFAppState().adminREFappState =
            _model.userDirectoryEntry?.parentAdminRef;
        safeSetState(() {});
        _model.deviceRef2 = await queryDevicesRecordOnce(
          parent: _model.userDirectoryEntry?.parentAdminRef,
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        while (FFAppState().isLooping == true) {
          _model.sensordataAPIpageload2 = await GetSensorDataCall.call(
            deviceId: _model.deviceRef2?.deviceId,
          );

          FFAppState().sensorData = getJsonField(
            (_model.sensordataAPIpageload2?.jsonBody ?? ''),
            r'''$''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          safeSetState(() {});
          FFAppState().weatherTemp = GetSensorDataCall.temperature(
            (_model.sensordataAPIpageload2?.jsonBody ?? ''),
          )!;
          FFAppState().cloudCoverage = GetSensorDataCall.windspeed(
            (_model.sensordataAPIpageload2?.jsonBody ?? ''),
          )!;
          FFAppState().humidity = GetSensorDataCall.humidity(
            (_model.sensordataAPIpageload2?.jsonBody ?? ''),
          )!;
          FFAppState().weatherState = GetSensorDataCall.weatherstate(
            (_model.sensordataAPIpageload2?.jsonBody ?? ''),
          )!;
          FFAppState().tips = GetSensorDataCall.tips(
            (_model.sensordataAPIpageload2?.jsonBody ?? ''),
          )!;
          FFAppState().Tcost = GetSensorDataCall.tcost(
            (_model.sensordataAPIpageload2?.jsonBody ?? ''),
          )!;
          FFAppState().Tenergy = GetSensorDataCall.tenergy(
            (_model.sensordataAPIpageload2?.jsonBody ?? ''),
          )!;
          FFAppState().energyChange = valueOrDefault<String>(
            GetSensorDataCall.energyChnage24h(
              (_model.sensordataAPIpageload2?.jsonBody ?? ''),
            ),
            '0.0',
          );
          FFAppState().CostChange = valueOrDefault<String>(
            GetSensorDataCall.costChange24h(
              (_model.sensordataAPIpageload2?.jsonBody ?? ''),
            ),
            '0.0',
          );
          await Future.delayed(const Duration(milliseconds: 800));
        }
      }
    });

    _model.householdIdnoIDTextController ??= TextEditingController();
    _model.householdIdnoIDFocusNode ??= FocusNode();

    animationsMap.addAll({
      'rowOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 1140.0.ms,
            begin: Offset(0.0, 17.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 1040.0.ms,
            begin: Offset(0.0, 16.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'rowOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 990.0.ms,
            begin: Offset(0.0, 14.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 960.0.ms,
            begin: Offset(0.0, 11.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 70.0.ms,
            duration: 1790.0.ms,
            color: Color(0x90FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      FFAppState().currentPage = 'home';
      safeSetState(() {});
    }();

    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 593.4,
                  height: 269.68,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Transform.scale(
                      scaleX: 2.1,
                      scaleY: 1.0,
                      alignment: AlignmentDirectional(0.0, 1.0),
                      origin: Offset(40.0, 100.0),
                      child: ClipRect(
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: 12.0,
                            sigmaY: 12.0,
                          ),
                          child: Opacity(
                            opacity: 0.8,
                            child: Lottie.asset(
                              'assets/jsons/Main_Scene_(2)-T62Fr.json',
                              width: 787.9,
                              height: 658.3,
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
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 500.0,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Column(
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
                                      Color(0x005BA6A6),
                                      Color(0x08FFFFFF)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                ),
                                child: RefreshIndicator(
                                  color: FlutterFlowTheme.of(context).primary,
                                  backgroundColor: Colors.white,
                                  strokeWidth: 3.0,
                                  onRefresh: () async {
                                    FFAppState().sui =
                                        !(FFAppState().sui ?? true);
                                    safeSetState(() {});
                                  },
                                  child: SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 90.0, 16.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(11.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            '9au8deaz' /* Welcome */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                color: Color(
                                                                    0xFF384E58),
                                                                fontSize: 13.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Plus Jakarta Sans'),
                                                              ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            FFAppState()
                                                                .displayName,
                                                            'Your name',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Lexend',
                                                                color: Color(
                                                                    0xFF0B191E),
                                                                fontSize: 23.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Lexend'),
                                                              ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        FFAppState()
                                                                            .houseName,
                                                                        'Your home',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                            fontSize:
                                                                                19.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineSmallFamily),
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          12.0)),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 16.0)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        if (FFAppState()
                                                                .isAdmin ==
                                                            true)
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                ConnectWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'adminREF':
                                                                      serializeParam(
                                                                    _model
                                                                        .adminUser
                                                                        ?.reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );

                                                              HapticFeedback
                                                                  .lightImpact();
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .add_link_sharp,
                                                              color:
                                                                  Colors.black,
                                                              size: 32.0,
                                                            ),
                                                          ),
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            context.pushNamed(
                                                                NotificationsWidget
                                                                    .routeName);

                                                            HapticFeedback
                                                                .lightImpact();
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .notifications_none_rounded,
                                                            color: Colors.black,
                                                            size: 30.0,
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 18.0)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ).animateOnPageLoad(animationsMap[
                                              'rowOnPageLoadAnimation1']!),
                                        ),
                                        Stack(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 13.0, 16.0, 16.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 1.0,
                                                            shape:
                                                                const CircleBorder(),
                                                            child: Container(
                                                              width: 56.0,
                                                              height: 56.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        3.0,
                                                                    color: Color(
                                                                        0x11000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0x113E3E3E),
                                                                  width: 0.0,
                                                                ),
                                                              ),
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .wind,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 18.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                '${valueOrDefault<String>(
                                                                  FFAppState()
                                                                      .cloudCoverage
                                                                      .toString(),
                                                                  '5',
                                                                )}',
                                                                'Wind',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        17.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                  ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1.0,
                                                                      1.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'ksjukim8' /*  km/h */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      fontSize:
                                                                          9.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            formatNumber(
                                                                              FFAppState().weatherTemp,
                                                                              formatType: FormatType.custom,
                                                                              format: '#,##0',
                                                                              locale: '',
                                                                            ),
                                                                            '30',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .displayLarge
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 70.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey('Poppins'),
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            13.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'igqb1lr7' /* ° */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                color: Colors.black,
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Text(
                                                              FFAppState()
                                                                  .weatherState,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                  ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 0.0)),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 1.0,
                                                          shape:
                                                              const CircleBorder(),
                                                          child: Container(
                                                            width: 56.0,
                                                            height: 56.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      3.0,
                                                                  color: Color(
                                                                      0x11000000),
                                                                  offset:
                                                                      Offset(
                                                                    0.0,
                                                                    2.0,
                                                                  ),
                                                                )
                                                              ],
                                                              shape: BoxShape
                                                                  .circle,
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0x113E3E3E),
                                                                width: 0.0,
                                                              ),
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Icon(
                                                                Icons
                                                                    .water_drop_rounded,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1.0,
                                                                      0.0),
                                                              child: Text(
                                                                '${valueOrDefault<String>(
                                                                  FFAppState()
                                                                      .humidity
                                                                      .toString(),
                                                                  '10',
                                                                )}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .headlineMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          17.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                    ),
                                                              ),
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'fruq26hn' /*  % */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    fontSize:
                                                                        9.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 31.0)),
                                                ).animateOnPageLoad(animationsMap[
                                                    'rowOnPageLoadAnimation2']!),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 11.0, 16.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Material(
                                                color: Colors.transparent,
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Container(
                                                  width: 171.1,
                                                  height: 77.4,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 3.0,
                                                        color:
                                                            Color(0x13000000),
                                                        offset: Offset(
                                                          0.0,
                                                          2.0,
                                                        ),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 0.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'qpjmrwry' /* Total Cost     */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                  ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    FFAppState()
                                                                        .CostChange,
                                                                    '0.0',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodySmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .errorRed,
                                                                        fontSize:
                                                                            11.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                      ),
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '0o0gi6ar' /* % */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodySmallFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .errorRed,
                                                                        fontSize:
                                                                            11.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                      ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 1.0)),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                FFAppState()
                                                                    .Tcost,
                                                                'Total Cost',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineMediumFamily,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '74rfgz26' /* AED */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 4.0)),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 8.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  elevation: 0.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: Container(
                                                    width: 171.1,
                                                    height: 77.4,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 3.0,
                                                          color:
                                                              Color(0x13000000),
                                                          offset: Offset(
                                                            0.0,
                                                            2.0,
                                                          ),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 0.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'i31t5q9c' /* Energy Usage  */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          13.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    ),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      FFAppState()
                                                                          .energyChange,
                                                                      '0.0',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodySmallFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).errorRed,
                                                                          fontSize:
                                                                              11.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'z6roqs91' /* % */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodySmallFamily,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).errorRed,
                                                                          fontSize:
                                                                              11.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                        ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        1.0)),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  FFAppState()
                                                                      .Tenergy,
                                                                  'Total Energy',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .headlineMediumFamily,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                    ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'p66nlew2' /* kWh */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                      ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 4.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 8.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 14.0)),
                                          ).animateOnPageLoad(animationsMap[
                                              'rowOnPageLoadAnimation3']!),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (FFAppState()
                                                        .adminREFappState
                                                        ?.id !=
                                                    null &&
                                                FFAppState()
                                                        .adminREFappState
                                                        ?.id !=
                                                    '')
                                              StreamBuilder<
                                                  List<DevicesRecord>>(
                                                stream: queryDevicesRecord(
                                                  queryBuilder:
                                                      (devicesRecord) =>
                                                          devicesRecord.where(
                                                    'userView',
                                                    arrayContains:
                                                        currentUserEmail,
                                                  ),
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: LoadingWidget(),
                                                    );
                                                  }
                                                  List<DevicesRecord>
                                                      listViewDevicesRecordList =
                                                      snapshot.data!;

                                                  return ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        listViewDevicesRecordList
                                                            .length,
                                                    itemBuilder: (context,
                                                        listViewIndex) {
                                                      final listViewDevicesRecord =
                                                          listViewDevicesRecordList[
                                                              listViewIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    18.0,
                                                                    0.0,
                                                                    18.0,
                                                                    19.0),
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 0.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: Container(
                                                            width: 189.8,
                                                            height: 274.23,
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      3.0,
                                                                  color: Color(
                                                                      0x13000000),
                                                                  offset:
                                                                      Offset(
                                                                    0.0,
                                                                    2.0,
                                                                  ),
                                                                )
                                                              ],
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  valueOrDefault<
                                                                      Color>(
                                                                    () {
                                                                      if (valueOrDefault<
                                                                              String>(
                                                                            functions.getSensorState(
                                                                                FFAppState().sensorData.toList(),
                                                                                listViewDevicesRecord.deviceId,
                                                                                'anomaly_status_numeric'),
                                                                            'voltage',
                                                                          ) ==
                                                                          '0') {
                                                                        return Color(
                                                                            0xFFDBE4E4);
                                                                      } else if (valueOrDefault<
                                                                              String>(
                                                                            functions.getSensorState(
                                                                                FFAppState().sensorData.toList(),
                                                                                listViewDevicesRecord.deviceId,
                                                                                'anomaly_status_numeric'),
                                                                            'voltage',
                                                                          ) ==
                                                                          '1') {
                                                                        return Color(
                                                                            0xFFE4D2CB);
                                                                      } else if (valueOrDefault<
                                                                              String>(
                                                                            functions.getSensorState(
                                                                                FFAppState().sensorData.toList(),
                                                                                listViewDevicesRecord.deviceId,
                                                                                'anomaly_status_numeric'),
                                                                            'voltage',
                                                                          ) ==
                                                                          '2') {
                                                                        return Color(
                                                                            0xFFF6DDDD);
                                                                      } else {
                                                                        return Color(
                                                                            0xFFA1A0A0);
                                                                      }
                                                                    }(),
                                                                    Color(
                                                                        0xFF737373),
                                                                  ),
                                                                  Colors.white,
                                                                  Colors.white,
                                                                  Colors.white,
                                                                  Colors.white,
                                                                  Colors.white
                                                                ],
                                                                stops: [
                                                                  0.0,
                                                                  0.2,
                                                                  0.3,
                                                                  0.4,
                                                                  0.5,
                                                                  1.0
                                                                ],
                                                                begin:
                                                                    AlignmentDirectional(
                                                                        0.87,
                                                                        1.0),
                                                                end:
                                                                    AlignmentDirectional(
                                                                        -0.87,
                                                                        -1.0),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFEFEFEF),
                                                                width: 0.0,
                                                              ),
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 5.0),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          listViewDevicesRecord.friendlyName,
                                                                                          'Plug',
                                                                                        ),
                                                                                        textAlign: TextAlign.start,
                                                                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                              fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                                                                              color: Colors.black,
                                                                                              fontSize: 21.0,
                                                                                              letterSpacing: 0.0,
                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          valueOrDefault<String>(
                                                                                            FFAppState().deviceLocation,
                                                                                            'Room',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                                color: Color(0xFF464646),
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'yoov8sfe' /*  |  */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: Color(0xFF464646),
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'se6ti893' /* Power :  */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: Color(0xFF464646),
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          valueOrDefault<String>(
                                                                                            functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'pzem_power'),
                                                                                            'power',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: Color(0xFF464646),
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'v5q6tb8d' /*  W */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: Color(0xFF464646),
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'xgpwvs20' /*  |  */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: Color(0xFF464646),
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          valueOrDefault<String>(
                                                                                            valueOrDefault<String>(
                                                                                                      functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'relay_state_numeric'),
                                                                                                      'voltage',
                                                                                                    ) ==
                                                                                                    '0'
                                                                                                ? 'OFF'
                                                                                                : 'ON',
                                                                                            'Off',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: Color(0xFF464646),
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 16.0, 0.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  FFAppState().relayStatus = functions.getRelayState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId);
                                                                                  safeSetState(() {});
                                                                                  HapticFeedback.mediumImpact();
                                                                                  if (listViewDevicesRecord.userControl.contains(currentUserEmail) == true) {
                                                                                    if (FFAppState().relayStatus == 'off') {
                                                                                      FFAppState().toggleBody = functions.buildToggleBody(listViewDevicesRecord.deviceId);
                                                                                      safeSetState(() {});
                                                                                      _model.apiResultxizCopy = await ToggleRelayOnCall.call(
                                                                                        myEntityId: FFAppState().toggleBody,
                                                                                      );
                                                                                    } else {
                                                                                      FFAppState().toggleBody = functions.buildToggleBody(listViewDevicesRecord.deviceId);
                                                                                      safeSetState(() {});
                                                                                      _model.apiResultghqCopy = await ToggleRelayOFFCall.call(
                                                                                        myEntityId: FFAppState().toggleBody,
                                                                                      );
                                                                                    }
                                                                                  } else {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text(
                                                                                          'You can\'t control the device',
                                                                                          style: FlutterFlowTheme.of(context).headlineMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                        duration: Duration(milliseconds: 4000),
                                                                                        backgroundColor: Color(0xEECD0E32),
                                                                                      ),
                                                                                    );
                                                                                  }

                                                                                  safeSetState(() {});
                                                                                },
                                                                                child: Container(
                                                                                  width: 56.2,
                                                                                  height: 46.93,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  ),
                                                                                  alignment: AlignmentDirectional(0.0, 0.6),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Icon(
                                                                                      Icons.power_settings_new,
                                                                                      color: valueOrDefault<Color>(
                                                                                        valueOrDefault<String>(
                                                                                                  functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'relay_state_numeric'),
                                                                                                  'voltage',
                                                                                                ) ==
                                                                                                '0'
                                                                                            ? Color(0xFF979797)
                                                                                            : Color(0xFF00BEC8),
                                                                                        Color(0xFF737373),
                                                                                      ),
                                                                                      size: 28.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        _model.computeApiFilter =
                                                                            await actions.computeApiFilter(
                                                                          listViewDevicesRecord
                                                                              .deviceId,
                                                                        );
                                                                        _model.getPowerThresholdStartTime =
                                                                            await actions.getPowerThresholdStartTime();
                                                                        FFAppState().computeAPIfilter =
                                                                            _model.computeApiFilter!;
                                                                        FFAppState().startTime =
                                                                            _model.getPowerThresholdStartTime!;

                                                                        context
                                                                            .pushNamed(
                                                                          DetailedDeviceInfoWidget
                                                                              .routeName,
                                                                          queryParameters:
                                                                              {
                                                                            'deviceId':
                                                                                serializeParam(
                                                                              listViewDevicesRecord.deviceId,
                                                                              ParamType.String,
                                                                            ),
                                                                            'deviceName':
                                                                                serializeParam(
                                                                              listViewDevicesRecord.friendlyName,
                                                                              ParamType.String,
                                                                            ),
                                                                            'deviceReference':
                                                                                serializeParam(
                                                                              listViewDevicesRecord.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                          }.withoutNulls,
                                                                          extra: <String,
                                                                              dynamic>{
                                                                            kTransitionInfoKey:
                                                                                TransitionInfo(
                                                                              hasTransition: true,
                                                                              transitionType: PageTransitionType.bottomToTop,
                                                                              duration: Duration(milliseconds: 320),
                                                                            ),
                                                                          },
                                                                        );

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 16.0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                                            children: [
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'l8einlq7' /* Voltage           */,
                                                                                                  ),
                                                                                                  textAlign: TextAlign.start,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Plus Jakarta Sans',
                                                                                                        color: Color(0xFF384E58),
                                                                                                        fontSize: 14.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                                                                                        lineHeight: 0.0,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                valueOrDefault<String>(
                                                                                                  functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'pzem_voltage'),
                                                                                                  'voltage',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Plus Jakarta Sans',
                                                                                                      color: Color(0xFF0B191E),
                                                                                                      fontSize: 13.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                                                                                      lineHeight: 0.0,
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'ynv8e713' /*  V */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Lexend',
                                                                                                      fontSize: 13.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Lexend'),
                                                                                                      lineHeight: 0.0,
                                                                                                    ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                                            children: [
                                                                                              Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'pba69bju' /* Current            */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Plus Jakarta Sans',
                                                                                                      color: Color(0xFF384E58),
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                                                                                      lineHeight: 0.0,
                                                                                                    ),
                                                                                              ),
                                                                                              AnimatedDefaultTextStyle(
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Plus Jakarta Sans',
                                                                                                      color: Color(0xFF0B191E),
                                                                                                      fontSize: 13.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                                                                                      lineHeight: 0.0,
                                                                                                    ),
                                                                                                duration: Duration(milliseconds: 600),
                                                                                                curve: Curves.easeIn,
                                                                                                child: Text(
                                                                                                  valueOrDefault<String>(
                                                                                                    functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'pzem_current'),
                                                                                                    'current',
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(0.0, 1.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'fj08ebdc' /*  A  */,
                                                                                                  ),
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                        fontSize: 13.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                        lineHeight: 0.0,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                                            children: [
                                                                                              Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'd0ssd8fl' /* Cost                   */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Plus Jakarta Sans',
                                                                                                      color: Color(0xFF384E58),
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                                                                                      lineHeight: 0.0,
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                valueOrDefault<String>(
                                                                                                  functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'current_cost'),
                                                                                                  'cost',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Plus Jakarta Sans',
                                                                                                      color: Color(0xFF0B191E),
                                                                                                      fontSize: 13.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                                                                                      lineHeight: 0.0,
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'b497fyjw' /*  AED */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                      fontSize: 13.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                      lineHeight: 0.0,
                                                                                                    ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'xmyybe6m' /* Status    */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Plus Jakarta Sans',
                                                                                                      color: Color(0xFF384E58),
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                                                                                      lineHeight: 0.0,
                                                                                                    ),
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 2.0, 0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 112.33,
                                                                                                    height: 25.8,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: valueOrDefault<Color>(
                                                                                                        () {
                                                                                                          if (valueOrDefault<String>(
                                                                                                                functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'anomaly_status_numeric'),
                                                                                                                'voltage',
                                                                                                              ) ==
                                                                                                              '0') {
                                                                                                            return FlutterFlowTheme.of(context).tertiary;
                                                                                                          } else if (valueOrDefault<String>(
                                                                                                                functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'anomaly_status_numeric'),
                                                                                                                'voltage',
                                                                                                              ) ==
                                                                                                              '1') {
                                                                                                            return Color(0xFFEF804F);
                                                                                                          } else if (valueOrDefault<String>(
                                                                                                                functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'anomaly_status_numeric'),
                                                                                                                'voltage',
                                                                                                              ) ==
                                                                                                              '2') {
                                                                                                            return Color(0xFFF44747);
                                                                                                          } else {
                                                                                                            return Color(0xFFA1A0A0);
                                                                                                          }
                                                                                                        }(),
                                                                                                        Color(0xFF737373),
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(12.0),
                                                                                                    ),
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: Align(
                                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<String>(
                                                                                                            functions.getSensorState(FFAppState().sensorData.toList(), listViewDevicesRecord.deviceId, 'power_error'),
                                                                                                            'Needs Maintenance',
                                                                                                          ),
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                fontFamily: 'Plus Jakarta Sans',
                                                                                                                color: Colors.white,
                                                                                                                fontSize: 10.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey('Plus Jakarta Sans'),
                                                                                                                lineHeight: 0.0,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ].divide(SizedBox(height: 8.0)),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                10.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              width: 144.5,
                                                                              height: 171.5,
                                                                              decoration: BoxDecoration(),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(1.0, 0.0),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(0.0),
                                                                                  child: Image.asset(
                                                                                    'assets/images/11.png',
                                                                                    width: 181.1,
                                                                                    height: 189.0,
                                                                                    fit: BoxFit.cover,
                                                                                    alignment: Alignment(-1.0, 0.0),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        _model.computeApiFilterCopy =
                                                                            await actions.computeApiFilter(
                                                                          listViewDevicesRecord
                                                                              .deviceId,
                                                                        );
                                                                        _model.getPowerThresholdStartTimeCopy =
                                                                            await actions.getPowerThresholdStartTime();
                                                                        FFAppState().computeAPIfilter =
                                                                            _model.computeApiFilterCopy!;
                                                                        FFAppState().startTime =
                                                                            _model.getPowerThresholdStartTimeCopy!;

                                                                        context
                                                                            .pushNamed(
                                                                          DetailedDeviceInfoWidget
                                                                              .routeName,
                                                                          queryParameters:
                                                                              {
                                                                            'deviceId':
                                                                                serializeParam(
                                                                              listViewDevicesRecord.deviceId,
                                                                              ParamType.String,
                                                                            ),
                                                                            'deviceName':
                                                                                serializeParam(
                                                                              listViewDevicesRecord.friendlyName,
                                                                              ParamType.String,
                                                                            ),
                                                                            'deviceReference':
                                                                                serializeParam(
                                                                              listViewDevicesRecord.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                          }.withoutNulls,
                                                                          extra: <String,
                                                                              dynamic>{
                                                                            kTransitionInfoKey:
                                                                                TransitionInfo(
                                                                              hasTransition: true,
                                                                              transitionType: PageTransitionType.bottomToTop,
                                                                              duration: Duration(milliseconds: 320),
                                                                            ),
                                                                          },
                                                                        );

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'vezv3vay' /* Show Details */,
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                          color: Color(0xF476999B),
                                                                                          fontSize: 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                Transform.rotate(
                                                                                  angle: 180.0 * (math.pi / 180),
                                                                                  child: Lottie.asset(
                                                                                    'assets/jsons/KHsdfTNZ4M.json',
                                                                                    width: 32.0,
                                                                                    height: 32.5,
                                                                                    fit: BoxFit.contain,
                                                                                    frameRate: FrameRate(30.0),
                                                                                    animate: true,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).animateOnPageLoad(animationsMap[
                                                      'listViewOnPageLoadAnimation']!);
                                                },
                                              ),
                                          ],
                                        ),
                                        if (FFAppState().adminREFappState ==
                                            null)
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 16.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.835,
                                                height: 194.71,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          0.0),
                                                              child:
                                                                  TextFormField(
                                                                controller: _model
                                                                    .householdIdnoIDTextController,
                                                                focusNode: _model
                                                                    .householdIdnoIDFocusNode,
                                                                autofocus:
                                                                    false,
                                                                obscureText:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  isDense:
                                                                      false,
                                                                  labelText: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'ebk0ft5k' /* Household ID */,
                                                                  ),
                                                                  labelStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodySmallFamily,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                      ),
                                                                  hintText: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'p6o5a02q' /* Enter your Admin's Household I... */,
                                                                  ),
                                                                  hintStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodySmallFamily,
                                                                        fontSize:
                                                                            11.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                      ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0xFFF3F3F3),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0x6887B9BA),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  errorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0xFF744C4C),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  focusedErrorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0xFF744C4C),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  filled: true,
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  contentPadding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                          20.0,
                                                                          24.0,
                                                                          20.0,
                                                                          24.0),
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    ),
                                                                validator: _model
                                                                    .householdIdnoIDTextControllerValidator
                                                                    .asValidator(
                                                                        context),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -0.25,
                                                                    -0.71),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'v0s23ri5' /* Please add your new household ... */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: Color(
                                                                        0xFF757677),
                                                                    fontSize:
                                                                        13.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                  ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, -1.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '6daj4eln' /* You're not connected to any ho... */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 1.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          if (_model.householdIdnoIDTextController
                                                                      .text !=
                                                                  '') {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Please enter a household ID',
                                                                  style: GoogleFonts
                                                                      .getFont(
                                                                    'Lexend',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                            _model.foundHousehold =
                                                                await queryUsersRecordOnce(
                                                              queryBuilder:
                                                                  (usersRecord) =>
                                                                      usersRecord
                                                                          .where(
                                                                'householdId',
                                                                isEqualTo: _model
                                                                    .householdIdnoIDTextController
                                                                    .text,
                                                              ),
                                                              singleRecord:
                                                                  true,
                                                            ).then((s) => s
                                                                    .firstOrNull);
                                                            if (_model
                                                                    .foundHousehold !=
                                                                null) {
                                                              await UsersInHouseholdRecord
                                                                      .createDoc(_model
                                                                          .foundHousehold!
                                                                          .reference)
                                                                  .set(
                                                                      createUsersInHouseholdRecordData(
                                                                email: widget
                                                                    .email,
                                                                displayName:
                                                                    FFAppState()
                                                                        .displayName,
                                                                nameOfHouse: _model
                                                                    .foundHousehold
                                                                    ?.nameOfHouse,
                                                                title: 'user',
                                                              ));
                                                              FFAppState()
                                                                      .adminREFappState =
                                                                  _model
                                                                      .foundHousehold
                                                                      ?.reference;
                                                              FFAppState()
                                                                      .houseName =
                                                                  _model
                                                                      .foundHousehold!
                                                                      .nameOfHouse;
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'house hold id doesnt exist',
                                                                    style: GoogleFonts
                                                                        .getFont(
                                                                      'Lexend',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                ),
                                                              );
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'no id was entered',
                                                                  style: GoogleFonts
                                                                      .getFont(
                                                                    'Lexend',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                          }

                                                          safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'kzzw2gq1' /* Connect */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 300.65,
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily,
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).titleSmallFamily),
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 16.0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 1.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height: 119.5,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 3.0,
                                                      color: Color(0x11000000),
                                                      offset: Offset(
                                                        0.0,
                                                        2.0,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(11.0, 16.0,
                                                          11.0, 16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'tgqtv76v' /* Eco-Energy Tip  */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmallFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      19.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .headlineSmallFamily),
                                                                ),
                                                          ),
                                                          Icon(
                                                            Icons.eco_rounded,
                                                            color: Color(
                                                                0xFF6DBA6D),
                                                            size: 24.0,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Opacity(
                                                            opacity: 0.7,
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'v7weflxu' /* Powered by AI */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineSmallFamily,
                                                                    color: Color(
                                                                        0xFF909090),
                                                                    fontSize:
                                                                        11.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).headlineSmallFamily),
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    6.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            FFAppState().tips,
                                                            'Unplug chargers when not in use.',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: Color(
                                                                    0xFF76808A),
                                                                fontSize: 13.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 0.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 16.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              height: 68.5,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 24.0)),
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
                            width: double.infinity,
                            height: 93.67,
                            decoration: BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.navBarModel,
                              updateCallback: () => safeSetState(() {}),
                              child: NavBarWidget(
                                currentpage: '0',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 90.9,
                          decoration: BoxDecoration(),
                          child: ClipRect(
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 5.0,
                                sigmaY: 5.0,
                              ),
                              child: Opacity(
                                opacity: 0.95,
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: Container(
                                    width: 393.0,
                                    height: 60.53,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFF0FEFF),
                                          Color(0xDFF0FEFF),
                                          Color(0x40F0FEFF),
                                          Color(0x00FFFFFF),
                                          Color(0x00EBFEFF)
                                        ],
                                        stops: [0.0, 0.5, 0.85, 0.9, 1.0],
                                        begin: AlignmentDirectional(0.0, -1.0),
                                        end: AlignmentDirectional(0, 1.0),
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
