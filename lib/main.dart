import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/signup/signup_successful.dart';
import 'package:salon_app/app/pages/startup/startup_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SalonBeau',
      theme: ThemeData(primarySwatch: Colors.pink),
      debugShowCheckedModeBanner: false,
      home: const StartupView(),
    );
  }
}
