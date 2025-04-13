import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

bool checkEmailRegex(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email);
}

String getSensorState(
  List<dynamic> sensorList,
  String deviceId,
  String sensorType,
) {
  // Construct the prefix for the entity_id (e.g., "sensor.ecot2_pzem_voltage")
  String prefix = "sensor." + deviceId + "_" + sensorType;

  // Find the first sensor whose entity_id starts with the prefix
  for (var sensor in sensorList) {
    if (sensor["entity_id"].startsWith(prefix)) {
      return sensor["state"].toString();
    }
  }
  // Return "0" if no match is found
  return "0";
}

String buildToggleBody(String deviceId) {
  return "switch." + deviceId + "_relay_control";
}

String getRelayState(
  List<dynamic> stateList,
  String deviceId,
) {
  String targetId = "switch." + deviceId + "_relay_control";

  for (var item in stateList) {
    if (item is Map<String, dynamic> && item["entity_id"] == targetId) {
      return item["state"].toString();
    }
  }

  return "unknown";
}

String getFormattedSensorId(
  String deviceId,
  String sensorType,
) {
// This regular expression separates the alphabetic part from the trailing digits.
  // For example, if deviceId is "ecot2", then:
  //    match.group(1) will be "ecot"
  //    match.group(2) will be "2"
  final regex = RegExp(r'^(.*?)(\d+)$');
  final match = regex.firstMatch(deviceId);

  if (match != null) {
    // The full sensor ID will be built using the complete deviceId,
    // then the sensorType, and then appending an underscore plus the trailing digits.
    // For example, for deviceId "ecot2" and sensorType "pzem_power", it produces:
    //   "sensor.ecot2_pzem_power_2"
    return 'sensor.' + deviceId + '_' + sensorType + '_' + match.group(2)!;
  } else {
    // If no trailing digits exist, simply return the combination.
    return 'sensor.' + deviceId + '_' + sensorType;
  }
}

String? totalCost(
  List<dynamic> sensorList,
  String sensorType,
) {
  String totalCost(
    List<dynamic> sensorList,
    String sensorType,
  ) {
    double sum = 0.0;
    bool foundAny = false;

    // The suffix we’ll look for in the entity_id
    String targetSuffix = "_" + sensorType;

    // Loop over all sensors and check if their entity_id ends with our target suffix
    for (var sensor in sensorList) {
      final entityId = sensor["entity_id"];

      if (entityId is String && entityId.endsWith(targetSuffix)) {
        // Try to parse the sensor state as a number
        double? currentValue = double.tryParse(sensor["state"].toString());
        if (currentValue != null) {
          sum += currentValue;
          foundAny = true;
        }
      }
    }

    // If no matching sensors were found, return "0"
    if (!foundAny) {
      return "0";
    }

    // Return the final sum as a string
    // If sum is an integer (e.g., 12.0), convert to 12
    if (sum == sum.toInt()) {
      return sum.toInt().toString();
    } else {
      return sum.toString();
    }
  }
}

String? getUserTotalSensorValue(
  List<dynamic> sensorList,
  List<String> userDeviceIds,
  String sensorType,
) {
  String getUserTotalSensorValue(
    List<dynamic> sensorList,
    List<String> userDeviceIds,
    String sensorType,
  ) {
    double total = 0.0;

    // DEBUG: Print inputs
    print('✅ sensorList length: ${sensorList.length}');
    print('✅ userDeviceIds: $userDeviceIds');
    print('✅ sensorType: $sensorType');

    final normalizedDevices =
        userDeviceIds.map((d) => d.toLowerCase()).toList();

    for (final sensor in sensorList) {
      final entityId = sensor['entity_id']?.toString();
      final stateRaw = sensor['state']?.toString();

      if (entityId == null || !entityId.contains(sensorType)) continue;

      print('➡️ Matching sensor found: $entityId');

      // Get deviceId from entity_id (e.g., sensor.ecot2_current_cost_2)
      final cleanedId = entityId.replaceFirst('sensor.', '');
      final parts = cleanedId.split('_');
      if (parts.isEmpty) {
        print('⚠️ Could not parse deviceId from: $entityId');
        continue;
      }

      final deviceId = parts[0].toLowerCase();
      print('🔍 Extracted deviceId: $deviceId');

      if (!normalizedDevices.contains(deviceId)) {
        print('❌ Skipped: $deviceId not in userDeviceIds');
        continue;
      }

      final value = double.tryParse(stateRaw ?? '') ?? 0.0;
      print('✅ Adding $value to total');
      total += value;
    }

    print('🧮 Final Total: $total');
    return total.toStringAsFixed(3);
  }
}

List<String>? cleanDeviceList(List<String> inputList) {
  List<String> cleanDeviceList(List<String> inputList) {
    return inputList.where((item) => item.trim().isNotEmpty).toSet().toList();
  }
}
