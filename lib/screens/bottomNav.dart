import 'package:flutter/material.dart';
import 'package:manifest/screens/HomeScreen.dart';
import 'package:manifest/screens/ScanScreen.dart';
import 'package:manifest/screens/SettingScreen.dart';
import 'package:manifest/screens/SupportScreen.dart';
import 'package:provider/provider.dart';

import '../Provider/provider.dart';

class bottomNav extends StatefulWidget {
  final String userName;
  const bottomNav({super.key, required this.userName});

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
   int _currentIndex = 0;
  final List<Widget> _screens = [
    const DashuserScreen(userId: '',),
    const ScanScreen(),
    const SupportScreen(),
    const SettingScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
                bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor:  const Color(0xFFf6fafd),
            selectedItemColor: Colors.black,
            unselectedItemColor: const Color(0xFFa9a8ad),
            unselectedLabelStyle: const TextStyle(fontFamily: 'inter', color:Color(0xFFa9a8ad) ),
            selectedLabelStyle: const TextStyle(fontFamily: 'inter', color:Colors.black ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.support_agent),
                label: 'Support',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
            onTap: (index) {
              setState(() {
               _currentIndex = index;
              });
            },
          ),
        );
      }
    );
  }
}