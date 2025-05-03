import 'dart:async';
import '/backend/api_requests/api_calls.dart';
import '/backend/api_requests/api_manager.dart';

class ApiCacheManager {
  static final ApiCacheManager _instance = ApiCacheManager._internal();
  factory ApiCacheManager() => _instance;
  ApiCacheManager._internal();

  // Cache for sensor data
  ApiCallResponse? _sensorDataCache;
  DateTime? _lastFetchTime;
  
  // Refresh interval - 3 seconds instead of 800ms
  static const Duration refreshInterval = Duration(seconds: 3);
  
  // Stream controller for sensor data updates
  final _sensorDataController = StreamController<ApiCallResponse>.broadcast();
  Stream<ApiCallResponse> get sensorDataStream => _sensorDataController.stream;
  
  // Flag to check if fetch is actively running
  bool _isFetching = false;
  
  // Fetch sensor data with optimized caching
  Future<ApiCallResponse> getSensorData(String deviceId) async {
    final now = DateTime.now();
    
    // If cache exists and is fresh, return cached data
    if (_sensorDataCache != null && 
        _lastFetchTime != null && 
        now.difference(_lastFetchTime!) < refreshInterval) {
      return _sensorDataCache!;
    }
    
    // If already fetching, wait for current fetch to complete
    if (_isFetching) {
      // Return cached data if available, otherwise fetch new data
      return _sensorDataCache ?? await _fetchAndCache(deviceId);
    }
    
    return await _fetchAndCache(deviceId);
  }
  
  Future<ApiCallResponse> _fetchAndCache(String deviceId) async {
    try {
      _isFetching = true;
      final response = await GetSensorDataCall.call(deviceId: deviceId);
      
      if (response.succeeded) {
        _sensorDataCache = response;
        _lastFetchTime = DateTime.now();
        _sensorDataController.add(response);
      }
      
      return response;
    } finally {
      _isFetching = false;
    }
  }
  
  // Start continuous background fetching with reduced frequency
  void startBackgroundFetching(String deviceId) {
    // Stop any existing timer
    stopBackgroundFetching();
    
    // Create a periodic timer that fetches data at the refresh interval
    Timer.periodic(refreshInterval, (timer) async {
      if (!_isFetching) {
        await _fetchAndCache(deviceId);
      }
    });
  }
  
  // Stop background fetching
  void stopBackgroundFetching() {
    // Nothing to implement - handled by the Widget's dispose method
  }
  
  void dispose() {
    _sensorDataController.close();
  }
} 