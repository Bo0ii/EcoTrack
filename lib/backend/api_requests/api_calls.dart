import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetHomeAssistantDataCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetHomeAssistantData',
      apiUrl: 'https://eco-track.duckdns.org/api/states',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2NGM4ZTIyZjc4YjM0M2IzYmYzOTcwYmYwNmI3OTFjMiIsImlhdCI6MTc0MjE1Mjg1NiwiZXhwIjoyMDU3NTEyODU2fQ.i25jvKgFyVWiW4Pens4YTgxC7YhV6jlSY3n6nREqmAE',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? voltage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=="sensor.ecot_pzem_voltage")].state
''',
      ));
  static String? current(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=="sensor.ecot_pzem_current")].state
''',
      ));
  static String? power(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=="sensor.ecot_pzem_power")].state
''',
      ));
  static String? energy(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id=="sensor.ecot_pzem_energy_kwh")].state
''',
      ));
  static String? powerError(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id == "sensor.ecot_power_error")].state
''',
      ));
  static String? currentCost(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[?(@.entity_id == "sensor.ecot_current_cost")].state
''',
      ));
}

class HomeAssistantRelayONCall {
  static Future<ApiCallResponse> call() async {
    final ffApiRequestBody = '''
{
  "entity_id": "switch.ecot_relay_control"
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'HomeAssistantRelayON',
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
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class HomeAssistantRelayOFFCall {
  static Future<ApiCallResponse> call() async {
    final ffApiRequestBody = '''
{
  "entity_id": "switch.ecot_relay_control"
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'HomeAssistantRelayOFF',
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
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class HomeAssistantEnergyHistoryCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'HomeAssistantEnergyHistory',
      apiUrl:
          'https://eco-track.duckdns.org/api/history/period?filter_entity_id=sensor.ecot_pzem_energy_kwh',
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
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'powerXthreshhold',
      apiUrl:
          'https://eco-track.duckdns.org/api/history/period?filter_entity_id=sensor.ecot_pzem_power,sensor.ecot_threshold&start=2023-04-03T00:00:00',
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
