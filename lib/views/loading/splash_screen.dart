import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop_my/router/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Map<dynamic, dynamic>? params;

  @override
  void initState() {
    userCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.amber,
    ));
  }

  void redirect() {
    Timer(const Duration(seconds: 0), () {
      Navigator.pushNamedAndRemoveUntil(context, appRootRoute, (r) => false);
    });
  }

  void userCheck() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(context, loginRoute, (r) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, homeRoute, (r) => false);
      }
    });
  }
}
