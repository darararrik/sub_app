import 'package:flutter/material.dart';
import 'package:sub_app/core/utils/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sub_app/sub_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  runApp(const SubApp());
}
