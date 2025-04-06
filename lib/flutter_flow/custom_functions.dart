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

String? getDeviceID(String? input) {
  String? getDeviceID(String input) {
    // Check if input is null or empty
    if (input == null || input.isEmpty) {
      return null;
    }
    // Split the string by comma
    List<String> parts = input.split(',');
    // Return the first part, trimmed, if it exists
    if (parts.isNotEmpty) {
      return parts[0].trim();
    } else {
      return null;
    }
  }
}

String? getFriendlyName(String? input) {
  String? getFriendlyName(String input) {
    // Check if input is null or empty
    if (input == null || input.isEmpty) {
      return null;
    }
    // Split the string by comma
    List<String> parts = input.split(',');
    // Return the second part, trimmed, if it exists
    if (parts.length > 1) {
      return parts[1].trim();
    } else {
      return null;
    }
  }
}
