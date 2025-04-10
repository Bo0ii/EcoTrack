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
