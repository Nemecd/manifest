import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:manifest/screens/SignupScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState (){
    super.initState();
    Timer(const Duration(seconds: 5), (){
      var route = MaterialPageRoute(builder: (context) => const SignupScreen());
      Navigator.push(context, route);
    });
  }
    @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xFF2062ff),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/logo_white.png', height: 130, width: 130,),
            const SizedBox(height: 20,),
            const SpinKitFadingCircle(
              color: Colors.white,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}