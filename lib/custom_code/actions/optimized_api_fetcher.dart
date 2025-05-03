// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ff_commons/api_requests/api_manager.dart';
import '/backend/api_requests/api_calls.dart';

class OptimizedApiFetcher {
  // Private constructor
  OptimizedApiFetcher._();

  // Singleton instance
  static final OptimizedApiFetcher _instance = OptimizedApiFetcher._();

  // Getter for the instance
  static OptimizedApiFetcher get instance => _instance;

  // Cached data
  Map<String, dynamic> _cachedData = {};
  
  // Polling timer
  Timer? _pollingTimer;
  
  // Default polling interval (2 seconds instead of 800ms)
  int _pollingIntervalMs = 2000;
  
  // Flag to check if we're actively fetching data
  bool _isFetching = false;
  
  // Background mode flag
  bool _isInBackground = false;
  
  // Set a different polling interval when app is in background
  void setBackgroundMode(bool isBackground) {
    _isInBackground = isBackground;
    
    // If we're moving to background, stop the current timer and restart with longer interval
    if (isBackground && _pollingTimer != null) {
      _stopPolling();
      _pollingIntervalMs = 5000; // 5 seconds in background
      _startPolling();
    } else if (!isBackground && _pollingTimer != null) {
      _stopPolling();
      _pollingIntervalMs = 2000; // 2 seconds in foreground
      _startPolling();
    }
  }
  
  // Start polling for data
  void startPolling({String? deviceId, required Function(Map<String, dynamic>) onDataReceived}) {
    _pollingIntervalMs = _isInBackground ? 5000 : 2000;
    _stopPolling(); // Stop any existing polling
    
    // Initial fetch
    _fetchData(deviceId, onDataReceived);
    
    // Start periodic fetching
    _startPolling(deviceId: deviceId, onDataReceived: onDataReceived);
  }
  
  void _startPolling({String? deviceId, Function(Map<String, dynamic>)? onDataReceived}) {
    _pollingTimer = Timer.periodic(Duration(milliseconds: _pollingIntervalMs), (timer) {
      if (onDataReceived != null) {
        _fetchData(deviceId, onDataReceived);
      }
    });
  }
  
  // Stop polling
  void stopPolling() {
    _stopPolling();
  }
  
  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }
  
  // Check connectivity before making API calls
  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
  
  // Fetch data with optimizations
  Future<void> _fetchData(String? deviceId, Function(Map<String, dynamic>) onDataReceived) async {
    // Skip if we're already fetching to prevent multiple simultaneous requests
    if (_isFetching) return;
    
    // Skip if we don't have connectivity
    if (!await _checkConnectivity()) return;
    
    _isFetching = true;
    
    try {
      // Use the shared HTTP client for better performance
      final client = getSharedHttpClient();
      
      final apiResult = await GetSensorDataCall.call(
        deviceId: deviceId,
      );
      
      if (apiResult.succeeded) {
        // Create a map of data to return
        final Map<String, dynamic> data = {};
        
        // Extract all the data we need from the API response
        data['sensorData'] = getJsonField(
          (apiResult.jsonBody),
          r'''$''',
          true,
        )?.toList().cast<dynamic>();
        
        data['weatherTemp'] = GetSensorDataCall.temperature(
          (apiResult.jsonBody),
        );
        
        data['cloudCoverage'] = GetSensorDataCall.windspeed(
          (apiResult.jsonBody),
        );
        
        data['humidity'] = GetSensorDataCall.humidity(
          (apiResult.jsonBody),
        );
        
        data['weatherState'] = GetSensorDataCall.weatherstate(
          (apiResult.jsonBody),
        );
        
        data['tips'] = GetSensorDataCall.tips(
          (apiResult.jsonBody),
        );
        
        data['Tcost'] = GetSensorDataCall.tcost(
          (apiResult.jsonBody),
        );
        
        data['Tenergy'] = GetSensorDataCall.tenergy(
          (apiResult.jsonBody),
        );
        
        data['energyChange'] = GetSensorDataCall.energyChnage24h(
          (apiResult.jsonBody),
        );
        
        data['CostChange'] = GetSensorDataCall.costChange24h(
          (apiResult.jsonBody),
        );
        
        // Update cache
        _cachedData = data;
        
        // Notify listener
        onDataReceived(data);
      } else if (_cachedData.isNotEmpty) {
        // If the API call fails but we have cached data, use that
        onDataReceived(_cachedData);
      }
    } catch (e) {
      // If there's an error but we have cached data, use it
      if (_cachedData.isNotEmpty) {
        onDataReceived(_cachedData);
      }
    } finally {
      _isFetching = false;
    }
  }
  
  // Get cached data immediately without making an API call
  Map<String, dynamic> getCachedData() {
    return _cachedData;
  }
}

// Functions to expose for FlutterFlow use
Future<void> startOptimizedDataPolling({
  required String deviceId, 
  required Function(Map<String, dynamic>) onDataReceived
}) async {
  OptimizedApiFetcher.instance.startPolling(
    deviceId: deviceId,
    onDataReceived: onDataReceived,
  );
}

void stopOptimizedDataPolling() {
  OptimizedApiFetcher.instance.stopPolling();
}

void setApiBackgroundMode(bool isBackground) {
  OptimizedApiFetcher.instance.setBackgroundMode(isBackground);
} 