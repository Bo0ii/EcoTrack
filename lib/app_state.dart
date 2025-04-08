import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  }

  void addToHistoryData(dynamic value) {
    historyData.add(value);
  }

  void removeFromHistoryData(dynamic value) {
    historyData.remove(value);
  }

  void removeAtIndexFromHistoryData(int index) {
    historyData.removeAt(index);
  }

  void updateHistoryDataAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    historyData[index] = updateFn(_historyData[index]);
  }

  void insertAtIndexInHistoryData(int index, dynamic value) {
    historyData.insert(index, value);
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
