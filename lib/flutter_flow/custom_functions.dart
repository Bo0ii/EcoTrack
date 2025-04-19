import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
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
  // Check if deviceId ends with one or more digits.
  RegExp regex = RegExp(r'(\d+)$');
  Match? match = regex.firstMatch(deviceId);

  if (match != null) {
    // If there is a numeric part, extract it.
    String numericPart = match.group(0)!;
    return "switch." + deviceId + "_relay_control_" + numericPart;
  }

  // If deviceId has no trailing number, return the default toggle control.
  return "switch." + deviceId + "_relay_control";
}

String getRelayState(
  List<dynamic> stateList,
  String deviceId,
) {
  // We build a prefix like "switch.ecot2_relay_control"
  final String prefix = "switch.$deviceId" + "_relay_control";

  // Loop through the list to find the first matching entity_id
  for (var item in stateList) {
    if (item is Map<String, dynamic>) {
      final entityId = item["entity_id"] ?? "";
      // If the entity_id starts with "switch.ecot2_relay_control",
      // we have found "switch.ecot2_relay_control_2" or similar.
      if (entityId.startsWith(prefix)) {
        return item["state"].toString();
      }
    }
  }

  // If none is found, we return "unknown"
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

double? calculateTotalCost(
  List<dynamic> firebaseDevices,
  List<dynamic> haCostData,
) {
  double totalCost = 0.0;

  final Set<String> validDevices =
      firebaseDevices.map((e) => e.toString().toLowerCase()).toSet();

  final RegExp costRegex = RegExp(r"^sensor\.(.*?)_current_cost(?:_\d+)?$");

  for (final item in haCostData) {
    if (item is Map<String, dynamic> &&
        item.containsKey("entity_id") &&
        item.containsKey("cost")) {
      final String entityId = item["entity_id"].toString().toLowerCase();
      final match = costRegex.firstMatch(entityId);
      if (match != null) {
        final String deviceId = match.group(1)!;
        if (validDevices.contains(deviceId)) {
          double costValue = 0.0;
          if (item["cost"] is num) {
            costValue = (item["cost"] as num).toDouble();
          } else {
            costValue = double.tryParse(item["cost"].toString()) ?? 0.0;
          }
          totalCost += costValue;
        }
      }
    }
  }

  return totalCost;
}

List<dynamic> getDeviceTypes() {
  return [
    {"name": "Light bulbs", "imageIdentifier": "10"},
    {"name": "Home lighting", "imageIdentifier": "11"},
    {"name": "LED strips", "imageIdentifier": "12"},
    {"name": "Sensors", "imageIdentifier": "13"},
    {"name": "Sockets", "imageIdentifier": "15"},
    {"name": "Switches", "imageIdentifier": "16"},
    {"name": "Hubs and remotes", "imageIdentifier": "17"},
    {"name": "Security cameras", "imageIdentifier": "19"},
    {"name": "Televisions", "imageIdentifier": "BN_(3)"}
  ];
}
