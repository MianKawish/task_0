import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_0/home_view.dart';
import 'package:task_0/signup_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  routeDecider() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    bool? isLogin;

    isLogin = userPref.getBool("isLogin");

    Timer(
      Duration(seconds: 3),
      () {
        if (isLogin == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupView(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ));
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    routeDecider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/splash_logo.png"))),
      ),
    );
  }
}
