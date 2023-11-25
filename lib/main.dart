

import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:manifest/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Provider/provider.dart';

 void main() async  {
   WidgetsFlutterBinding.ensureInitialized();
  // if(kIsWeb){
  //   await Firebase.initializeApp(options: const FirebaseOptions(apiKey: 'AIzaSyAyt7ko7Q2mRL6FUaOrQHPo9nuaFyBYh4M', appId: '1:199831599048:web:e905b208879fb16878b2fd', messagingSenderId: '199831599048', projectId: 'manifest-5c039'));
  //  }
   await Firebase.initializeApp (
    options: const FirebaseOptions(
      apiKey: "AIzaSyAAp19q8clmT2j2L0sv3lBAyW2pUhEDmd0",
      appId: "1:199831599048:android:19437a21c651d27c78b2fd",
      messagingSenderId: "199831599048",
      projectId: "manifest-5c039",
    ),
   );
  runApp(
    ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MyApp()
    )
    );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

