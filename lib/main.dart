import 'package:animation_app/data/constants.dart';
import 'package:animation_app/views/auth/auth_wrapper.dart';
import 'package:animation_app/views/intro/intro_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';

import 'bindings/intial_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(defaultOverlay);
  Future.delayed(Duration(seconds: 4));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _checkFirstRun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Future Learning',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
      defaultTransition: Transition.fadeIn,
      theme: ThemeData(
          primarySwatch: Colors.purple, scaffoldBackgroundColor: Colors.white),
      initialBinding: HomeBinding(),
      home: _isFirstRun ? const IntroductionPageView() :  AuthWrapper(),
    );
  }

  bool _isFirstRun = true;

  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      _isFirstRun = ifr;
      print(_isFirstRun);
    });
  }
}
