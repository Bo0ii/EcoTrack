import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB-tCULLOT7XDCCNRsI3kaV-qg_KZJYYuE",
            authDomain: "ecotrack-4876b.firebaseapp.com",
            projectId: "ecotrack-4876b",
            storageBucket: "ecotrack-4876b.firebasestorage.app",
            messagingSenderId: "551409659517",
            appId: "1:551409659517:web:5a3b3728efef8940764b14"));
  } else {
    await Firebase.initializeApp();
  }
}
