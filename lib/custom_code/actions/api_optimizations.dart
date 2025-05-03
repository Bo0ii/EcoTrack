import '/backend/api_requests/api_calls.dart';
import '/backend/api_requests/api_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../classes/api_cache_manager.dart';

Future<ApiCallResponse> getOptimizedSensorData({
  required String deviceId,
}) async {
  // Use the API cache manager to get optimized sensor data
  return await ApiCacheManager().getSensorData(deviceId);
}

void startOptimizedBackgroundFetching({
  required String deviceId,
}) {
  // Start background fetching with the optimized manager
  ApiCacheManager().startBackgroundFetching(deviceId);
}

void updateAppState(ApiCallResponse response) {
  // Update app state from API response
  FFAppState().sensorData = getJsonField(
    (response.jsonBody),
    r'''$''',
    true,
  )!
      .toList()
      .cast<dynamic>();
      
  FFAppState().weatherTemp = GetSensorDataCall.temperature(
    (response.jsonBody),
  ) ?? 0.0;
  
  FFAppState().cloudCoverage = GetSensorDataCall.windspeed(
    (response.jsonBody),
  ) ?? 0.0;
  
  FFAppState().humidity = GetSensorDataCall.humidity(
    (response.jsonBody),
  ) ?? 0;
  
  FFAppState().weatherState = GetSensorDataCall.weatherstate(
    (response.jsonBody),
  ) ?? '';
  
  FFAppState().tips = GetSensorDataCall.tips(
    (response.jsonBody),
  ) ?? '';
  
  FFAppState().Tcost = GetSensorDataCall.tcost(
    (response.jsonBody),
  ) ?? '0.0';
  
  FFAppState().Tenergy = GetSensorDataCall.tenergy(
    (response.jsonBody),
  ) ?? '0.0';
  
  FFAppState().CostChange = GetSensorDataCall.costChange24h(
    (response.jsonBody),
  ) ?? '0.0';
  
  FFAppState().energyChange = GetSensorDataCall.energyChnage24h(
    (response.jsonBody),
  ) ?? '0.0';
} 