import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class EnergyHistoryCall {
  static Future<ApiCallResponse> call({
    String? computeEnergySensorId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'EnergyHistory',
      apiUrl:
          'https://eco-track.duckdns.org/api/history/period?filter_entity_id=${computeEnergySensorId}&start=2025-03-23T00:00:00',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2NGM4ZTIyZjc4YjM0M2IzYmYzOTcwYmYwNmI3OTFjMiIsImlhdCI6MTc0MjE1Mjg1NiwiZXhwIjoyMDU3NTEyODU2fQ.i25jvKgFyVWiW4Pens4YTgxC7YhV6jlSY3n6nREqmAE',
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

  static List<String>? time(dynamic response) => (getJsonField(
        response,
        r'''$[0][*].last_updated
''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? energyConsumption(dynamic response) => (getJsonField(
        response,
        r'''$[0][*].state''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class PowerXthreshholdCall {
  static Future<ApiCallResponse> call({
    String? computedApiFilter = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'powerXthreshhold',
      apiUrl:
          'https://eco-track.duckdns.org/api/history/period?filter_entity_id=${computedApiFilter}&start=2023-04-10T00:00:00',
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

  static List? thresholdHistory(dynamic response) => getJsonField(
        response,
        r'''$..[?(@.entity_id=='sensor.ecot_threshold')]
''',
        true,
      ) as List?;
  static List? powerHistory(dynamic response) => getJsonField(
        response,
        r'''$..[?(@.entity_id=='sensor.ecot_pzem_power')]
''',
        true,
      ) as List?;
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
      cache: true,
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
  static String? state(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=='weather.forecast_home')].state
''',
      ));
  static String? tips(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=='sensor.energy_saving_tip')].state
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

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
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
