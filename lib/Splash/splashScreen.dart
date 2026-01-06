import 'dart:async';

import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 190,
              height: 190,
              child: Lottie.asset('assest/blooddonneranime.json'),
            ),
          ),
          Center(
            child: Text(
              "Welcome to PashuRaktKosh",
              style: TextStyle(
                color: AppColors.darkRed,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Image.asset("assest/bblogo.png", scale: 2),
        ],
      ),
    );
  }
}
