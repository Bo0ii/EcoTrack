import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _historyData = prefs.getStringList('ff_historyData')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _historyData;
    });
    _safeInit(() {
      _isDeviceSaved = prefs.getBool('ff_isDeviceSaved') ?? _isDeviceSaved;
    });
    _safeInit(() {
      _savedDeviceID = prefs.getString('ff_savedDeviceID') ?? _savedDeviceID;
    });
    _safeInit(() {
      _savedFriendlyName =
          prefs.getString('ff_savedFriendlyName') ?? _savedFriendlyName;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<double> _powerState = [];
  List<double> get powerState => _powerState;
  set powerState(List<double> value) {
    _powerState = value;
  }

  void addToPowerState(double value) {
    powerState.add(value);
  }

  void removeFromPowerState(double value) {
    powerState.remove(value);
  }

  void removeAtIndexFromPowerState(int index) {
    powerState.removeAt(index);
  }

  void updatePowerStateAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    powerState[index] = updateFn(_powerState[index]);
  }

  void insertAtIndexInPowerState(int index, double value) {
    powerState.insert(index, value);
  }

  List<String> _timeState = [];
  List<String> get timeState => _timeState;
  set timeState(List<String> value) {
    _timeState = value;
  }

  void addToTimeState(String value) {
    timeState.add(value);
  }

  void removeFromTimeState(String value) {
    timeState.remove(value);
  }

  void removeAtIndexFromTimeState(int index) {
    timeState.removeAt(index);
  }

  void updateTimeStateAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    timeState[index] = updateFn(_timeState[index]);
  }

  void insertAtIndexInTimeState(int index, String value) {
    timeState.insert(index, value);
  }

  bool _isLooping = true;
  bool get isLooping => _isLooping;
  set isLooping(bool value) {
    _isLooping = value;
  }

  String _voltageData = '';
  String get voltageData => _voltageData;
  set voltageData(String value) {
    _voltageData = value;
  }

  String _currentData = '';
  String get currentData => _currentData;
  set currentData(String value) {
    _currentData = value;
  }

  String _powerData = '';
  String get powerData => _powerData;
  set powerData(String value) {
    _powerData = value;
  }

  String _energyData = '0.0';
  String get energyData => _energyData;
  set energyData(String value) {
    _energyData = value;
  }

  double _currentCost = 0.0;
  double get currentCost => _currentCost;
  set currentCost(double value) {
    _currentCost = value;
  }

  List<dynamic> _sensorData = [];
  List<dynamic> get sensorData => _sensorData;
  set sensorData(List<dynamic> value) {
    _sensorData = value;
  }

  void addToSensorData(dynamic value) {
    sensorData.add(value);
  }

  void removeFromSensorData(dynamic value) {
    sensorData.remove(value);
  }

  void removeAtIndexFromSensorData(int index) {
    sensorData.removeAt(index);
  }

  void updateSensorDataAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    sensorData[index] = updateFn(_sensorData[index]);
  }

  void insertAtIndexInSensorData(int index, dynamic value) {
    sensorData.insert(index, value);
  }

  String _toggleBody = '';
  String get toggleBody => _toggleBody;
  set toggleBody(String value) {
    _toggleBody = value;
  }

  String _relayStatus = '';
  String get relayStatus => _relayStatus;
  set relayStatus(String value) {
    _relayStatus = value;
  }

  List<dynamic> _historyData = [];
  List<dynamic> get historyData => _historyData;
  set historyData(List<dynamic> value) {
    _historyData = value;
    prefs.setStringList(
        'ff_historyData', value.map((x) => jsonEncode(x)).toList());
  }

  void addToHistoryData(dynamic value) {
    historyData.add(value);
    prefs.setStringList(
        'ff_historyData', _historyData.map((x) => jsonEncode(x)).toList());
  }

  void removeFromHistoryData(dynamic value) {
    historyData.remove(value);
    prefs.setStringList(
        'ff_historyData', _historyData.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromHistoryData(int index) {
    historyData.removeAt(index);
    prefs.setStringList(
        'ff_historyData', _historyData.map((x) => jsonEncode(x)).toList());
  }

  void updateHistoryDataAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    historyData[index] = updateFn(_historyData[index]);
    prefs.setStringList(
        'ff_historyData', _historyData.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInHistoryData(int index, dynamic value) {
    historyData.insert(index, value);
    prefs.setStringList(
        'ff_historyData', _historyData.map((x) => jsonEncode(x)).toList());
  }

  String _deviceOnTime = '00:00';
  String get deviceOnTime => _deviceOnTime;
  set deviceOnTime(String value) {
    _deviceOnTime = value;
  }

  String _deviceOffTime = '23:00';
  String get deviceOffTime => _deviceOffTime;
  set deviceOffTime(String value) {
    _deviceOffTime = value;
  }

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;
  set isAdmin(bool value) {
    _isAdmin = value;
  }

  String _userState = '';
  String get userState => _userState;
  set userState(String value) {
    _userState = value;
  }

  String _currentPage = 'home';
  String get currentPage => _currentPage;
  set currentPage(String value) {
    _currentPage = value;
  }

  String _friendlyName = '';
  String get friendlyName => _friendlyName;
  set friendlyName(String value) {
    _friendlyName = value;
  }

  String _deviceID = '';
  String get deviceID => _deviceID;
  set deviceID(String value) {
    _deviceID = value;
  }

  bool _isDeviceSaved = false;
  bool get isDeviceSaved => _isDeviceSaved;
  set isDeviceSaved(bool value) {
    _isDeviceSaved = value;
    prefs.setBool('ff_isDeviceSaved', value);
  }

  String _savedDeviceID = '';
  String get savedDeviceID => _savedDeviceID;
  set savedDeviceID(String value) {
    _savedDeviceID = value;
    prefs.setString('ff_savedDeviceID', value);
  }

  String _savedFriendlyName = '';
  String get savedFriendlyName => _savedFriendlyName;
  set savedFriendlyName(String value) {
    _savedFriendlyName = value;
    prefs.setString('ff_savedFriendlyName', value);
  }

  String _selectedDeviceImagePath = '';
  String get selectedDeviceImagePath => _selectedDeviceImagePath;
  set selectedDeviceImagePath(String value) {
    _selectedDeviceImagePath = value;
  }

  String _displayName = '';
  String get displayName => _displayName;
  set displayName(String value) {
    _displayName = value;
  }

  int _Age = 0;
  int get Age => _Age;
  set Age(int value) {
    _Age = value;
  }

  String _Title = '';
  String get Title => _Title;
  set Title(String value) {
    _Title = value;
  }

  String _houseName = '';
  String get houseName => _houseName;
  set houseName(String value) {
    _houseName = value;
  }

  String _profileImage = '';
  String get profileImage => _profileImage;
  set profileImage(String value) {
    _profileImage = value;
  }

  double _weatherTemp = 0.0;
  double get weatherTemp => _weatherTemp;
  set weatherTemp(double value) {
    _weatherTemp = value;
  }

  int _humidity = 0;
  int get humidity => _humidity;
  set humidity(int value) {
    _humidity = value;
  }

  double _cloudCoverage = 0.0;
  double get cloudCoverage => _cloudCoverage;
  set cloudCoverage(double value) {
    _cloudCoverage = value;
  }

  String _weatherState = '';
  String get weatherState => _weatherState;
  set weatherState(String value) {
    _weatherState = value;
  }

  String _tips = '';
  String get tips => _tips;
  set tips(String value) {
    _tips = value;
  }

  bool _sui = false;
  bool get sui => _sui;
  set sui(bool value) {
    _sui = value;
  }

  int _weatherTempINT = 0;
  int get weatherTempINT => _weatherTempINT;
  set weatherTempINT(int value) {
    _weatherTempINT = value;
  }

  DocumentReference? _adminREFappState;
  DocumentReference? get adminREFappState => _adminREFappState;
  set adminREFappState(DocumentReference? value) {
    _adminREFappState = value;
  }

  String _startTime = '';
  String get startTime => _startTime;
  set startTime(String value) {
    _startTime = value;
  }

  String _computeAPIfilter = '';
  String get computeAPIfilter => _computeAPIfilter;
  set computeAPIfilter(String value) {
    _computeAPIfilter = value;
  }

  String _Tcost = '';
  String get Tcost => _Tcost;
  set Tcost(String value) {
    _Tcost = value;
  }

  String _Tenergy = '';
  String get Tenergy => _Tenergy;
  set Tenergy(String value) {
    _Tenergy = value;
  }

  String _selectedStartTime = '';
  String get selectedStartTime => _selectedStartTime;
  set selectedStartTime(String value) {
    _selectedStartTime = value;
  }

  String _selectedStopTime = '';
  String get selectedStopTime => _selectedStopTime;
  set selectedStopTime(String value) {
    _selectedStopTime = value;
  }

  DateTime? _test;
  DateTime? get test => _test;
  set test(DateTime? value) {
    _test = value;
  }

  String _deviceSelected = '';
  String get deviceSelected => _deviceSelected;
  set deviceSelected(String value) {
    _deviceSelected = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
