import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_commons/api_requests/api_manager.dart';


export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class PowerXthreshholdCall {
  static Future<ApiCallResponse> call({
    String? computedApiFilter = '',
    String? startTime = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'powerXthreshhold',
      apiUrl:
          'https://eco-track.duckdns.org/api/history/period?filter_entity_id=${computedApiFilter}&start=${startTime}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2NGM4ZTIyZjc4YjM0M2IzYmYzOTcwYmYwNmI3OTFjMiIsImlhdCI6MTc0MjE1Mjg1NiwiZXhwIjoyMDU3NTEyODU2fQ.i25jvKgFyVWiW4Pens4YTgxC7YhV6jlSY3n6nREqmAE',
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSensorDataCall {
  static Future<ApiCallResponse> call({
    String? deviceId = 'ecot2',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetSensorData',
      apiUrl: 'https://eco-track.duckdns.org/api/states',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2NGM4ZTIyZjc4YjM0M2IzYmYzOTcwYmYwNmI3OTFjMiIsImlhdCI6MTc0MjE1Mjg1NiwiZXhwIjoyMDU3NTEyODU2fQ.i25jvKgFyVWiW4Pens4YTgxC7YhV6jlSY3n6nREqmAE',
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? sensorData(dynamic response) => getJsonField(
        response,
        r'''$''',
        true,
      ) as List?;
  static double? temperature(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$[?(@.entity_id=='weather.forecast_home')].attributes.temperature
''',
      ));
  static int? humidity(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[?(@.entity_id=='weather.forecast_home')].attributes.humidity
''',
      ));
  static double? windspeed(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$[?(@.entity_id=='weather.forecast_home')].attributes.wind_speed''',
      ));
  static String? weatherstate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=='weather.forecast_home')].state
''',
      ));
  static String? tips(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=='sensor.energy_saving_tip')].state
''',
      ));
  static String? tenergy(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=='sensor.total_energy')].state''',
      ));
  static String? tcost(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=='sensor.total_cost')].state''',
      ));
  static String? ecotStartTimeTest(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=="sensor.ecot_formatted_start_time")].state
''',
      ));
  static String? ecotStopTimeTest(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=="sensor.ecot_formatted_stop_time")].state
''',
      ));
  static String? selectedEmirate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=="select.ecot_selected_emirate")].state
''',
      ));
}

class ToggleRelayOFFCall {
  static Future<ApiCallResponse> call({
    String? myEntityId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "entity_id": "${escapeStringForJson(myEntityId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ToggleRelayOFF',
      apiUrl: 'https://eco-track.duckdns.org/api/services/switch/turn_off',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2NGM4ZTIyZjc4YjM0M2IzYmYzOTcwYmYwNmI3OTFjMiIsImlhdCI6MTc0MjE1Mjg1NiwiZXhwIjoyMDU3NTEyODU2fQ.i25jvKgFyVWiW4Pens4YTgxC7YhV6jlSY3n6nREqmAE',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ToggleRelayOnCall {
  static Future<ApiCallResponse> call({
    String? myEntityId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "entity_id": "${escapeStringForJson(myEntityId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ToggleRelayOn',
      apiUrl: 'https://eco-track.duckdns.org/api/services/switch/turn_on',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2NGM4ZTIyZjc4YjM0M2IzYmYzOTcwYmYwNmI3OTFjMiIsImlhdCI6MTc0MjE1Mjg1NiwiZXhwIjoyMDU3NTEyODU2fQ.i25jvKgFyVWiW4Pens4YTgxC7YhV6jlSY3n6nREqmAE',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DailyEnergyListCall {
  static Future<ApiCallResponse> call({
    String? deviceId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'dailyEnergyList',
      apiUrl:
          'https://eco-track.duckdns.org/api/states/sensor.daily_energy_list_${deviceId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2NGM4ZTIyZjc4YjM0M2IzYmYzOTcwYmYwNmI3OTFjMiIsImlhdCI6MTc0MjE1Mjg1NiwiZXhwIjoyMDU3NTEyODU2fQ.i25jvKgFyVWiW4Pens4YTgxC7YhV6jlSY3n6nREqmAE',
        'Content-Type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class WorkingScheduleCall {
  static Future<ApiCallResponse> call({
    String? selectedStartTime = '',
    String? selectedStopTime = '',
    String? deviceId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "topic": "${escapeStringForJson(deviceId)}/schedule/set",
  "payload": "${escapeStringForJson(selectedStartTime)}-${escapeStringForJson(selectedStopTime)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'workingSchedule',
      apiUrl: 'https://eco-track.duckdns.org/api/services/mqtt/publish',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2NGM4ZTIyZjc4YjM0M2IzYmYzOTcwYmYwNmI3OTFjMiIsImlhdCI6MTc0MjE1Mjg1NiwiZXhwIjoyMDU3NTEyODU2fQ.i25jvKgFyVWiW4Pens4YTgxC7YhV6jlSY3n6nREqmAE',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
