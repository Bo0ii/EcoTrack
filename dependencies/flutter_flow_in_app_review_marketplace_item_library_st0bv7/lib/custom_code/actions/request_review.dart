// Automatic FlutterFlow imports
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';

import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'index.dart'; // Imports other custom actions

Future requestReview(
  String? androidBundelName,
  String? appStoreId,
) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final InAppReview inAppReview = InAppReview.instance;
  String appStoreUrl =
      "https://apps.apple.com/app/id${appStoreId ?? ''}"; // Replace with your App Store link
  final String playStoreUrl =
      "https://play.google.com/store/apps/details?id=${androidBundelName ?? ''}";
  Uri storeUri = Uri.parse(
    Platform.isIOS ? appStoreUrl : playStoreUrl,
  );
  final bool hasReviewed = prefs.getBool('hasReviewed') ?? false;
  if (!hasReviewed) {
    try {
      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
        prefs.setBool('hasReviewed', true);
      } else {
        throw Exception("In-App Review not available.");
      }
    } catch (e) {
      if (await canLaunchUrl(storeUri)) {
        print('Launching ${storeUri.toString()}');
        await launchUrl(storeUri, mode: LaunchMode.externalApplication);
      }
    }
  } else {}
}
