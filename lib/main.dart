import 'package:flutter/material.dart';
import 'package:sub_app/core/utils/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sub_app/sub_app.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const SubApp());
}
