import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manifest/screens/SigninScreen.dart';
import 'package:manifest/screens/qrcode/qrGen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
   Future<void> clearUserDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('userEmail');
   }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text('Settings',
              style: TextStyle(fontSize: 24, fontFamily: 'Inter', fontWeight:FontWeight.bold)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:6.0),
            child: IconButton(icon: const Icon(Icons.settings),
             onPressed: (){}),
          )
         ],
        backgroundColor: const Color(0xFFf6fafd),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          color: Color(0xFFf6fafd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Padding(
              padding: const EdgeInsets.only(left:16.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.qr_code),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: (() {
                        var route = MaterialPageRoute(
                            builder: (context) => const CodeGenScreen());
                        Navigator.push(context, route);
                      }),
                      child: const Text(
                        'QR Code',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                       Padding(
              padding: const EdgeInsets.only(left:16.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.language),
                  SizedBox(width: 16.0,),
                  //Padding(
                   // padding: const EdgeInsets.all(16.0),
                    //child:
                     GestureDetector(
                      onTap: (() {
                        // var route = MaterialPageRoute(
                        //     builder: (context) => const SigninScreen());
                        // Navigator.push(context, route);
                      }),
                      child: const Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  //),
                ],
              ),
            ),
                                    Padding(
              padding: const EdgeInsets.only(left:16.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.logout),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: (() {
                        FirebaseAuth.instance.signOut();
                        clearUserDataFromSharedPreferences();
                        var route = MaterialPageRoute(
                              builder: (context) => const SigninScreen());
                          Navigator.push(context, route);
                      }),
                      child: const Text(
                        'Log out',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
