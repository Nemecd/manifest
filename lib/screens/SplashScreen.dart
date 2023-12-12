import 'package:flutter/material.dart';
import 'package:manifest/screens/SigninScreen.dart';
import 'package:manifest/screens/bottomNav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward().whenComplete(() {
      checkUserLoginStatus();
    });
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<Map<String, dynamic>> getUserDataFromSharedPreferences() async {
    final userId = prefs.getString('userId') ?? '';
    final userName = prefs.getString('userName') ?? '';
    final userEmail = prefs.getString('userEmail') ?? '';
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'isLoggedIn': isLoggedIn.toString(),
    };
  }

  void checkUserLoginStatus() async {
    final userData = await getUserDataFromSharedPreferences();
    final isLoggedIn = userData['isLoggedIn'] == 'true';

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => bottomNav(userId: userData['userName'])),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SigninScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2062ff),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 300.0),
              child: Image.asset('assets/img/mainLogo.png', height: 70, width: 70),
            ),
            const SizedBox(height: 20,),
            AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2062ff)),
                    value: _animation.value,
                  ),
                );
              },
            ),
            const SizedBox(height: 300), // Adjust this spacing as needed
          Align(
            alignment: Alignment.center,
            child: Text(
              'Licensed by the FRSC. \u00a9 2023',
              style: TextStyle(
                color: Colors.grey[400], // Ash color
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
