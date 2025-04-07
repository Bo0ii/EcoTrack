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
  // The entity_id format is: sensor.{deviceId}_pzem_{sensorType}
  String targetId = "sensor." + deviceId + "_pzem_" + sensorType;

  // Loop through each sensor object in the list
  for (var sensor in sensorList) {
    // If entity_id matches targetId, return its state
    if (sensor["entity_id"] == targetId) {
      return sensor["state"].toString();
    }
  }

  // If not found, return "0" or some fallback
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
