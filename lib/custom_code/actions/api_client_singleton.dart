// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:async';

/// A singleton HTTP client that can be reused across the app.
/// This prevents creating a new client for each request, which improves performance.
class ApiClientSingleton {
  // Private constructor
  ApiClientSingleton._();

  // Singleton instance
  static final ApiClientSingleton _instance = ApiClientSingleton._();

  // Getter for the instance
  static ApiClientSingleton get instance => _instance;

  // HTTP client instance
  final http.Client _client = http.Client();

  // Get the HTTP client
  http.Client get client => _client;

  // Close the client when the app is done with it
  void dispose() {
    _client.close();
  }
}

// This function returns the shared HTTP client
http.Client getSharedHttpClient() {
  return ApiClientSingleton.instance.client;
} 