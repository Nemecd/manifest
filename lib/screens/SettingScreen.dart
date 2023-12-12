import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manifest/ReportScreen.dart';
import 'package:manifest/screens/AboutUs.dart';
import 'package:manifest/screens/SigninScreen.dart';
import 'package:manifest/screens/SupportScreen.dart';
import 'package:manifest/screens/qrcode/qrGen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  Future<void> clearUserDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('userEmail');
  }

  Widget buildListTile(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 10.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
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
            buildListTile(
              icon: Icons.qr_code,
              label: 'Generate QR code',
              onTap: () {
                var route = MaterialPageRoute(
                  builder: (context) => const CodeGenScreen(),
                );
                Navigator.push(context, route);
              },
            ),
            buildListTile(
              icon: Icons.support_agent,
              label: 'Support',
              onTap: () {
                var route = MaterialPageRoute(
                  builder: (context) => const SupportScreen(),
                );
                Navigator.push(context, route);
              },
            ),
            buildListTile(
              icon: Icons.info_outlined,
              label: 'About us',
              onTap: () {
                var route = MaterialPageRoute(
                  builder: (context) => const AboutusScreen(),
                );
                Navigator.push(context, route);
              },
            ),
            buildListTile(
              icon: Icons.report_problem_outlined,
              label: 'Report',
              onTap: () {
                var route = MaterialPageRoute(
                  builder: (context) => const ReportScreen(),
                );
                Navigator.push(context, route);
              },
            ),
            buildListTile(
              icon: Icons.logout,
              label: 'Log out',
              onTap: () {
                FirebaseAuth.instance.signOut();
                clearUserDataFromSharedPreferences();
                var route = MaterialPageRoute(
                  builder: (context) => const SigninScreen(),
                );
                Navigator.push(context, route);
              },
            ),
            const SizedBox(height: 200),
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
