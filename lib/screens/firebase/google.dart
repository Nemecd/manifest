// // ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:manifest/Models/user.dart';
// import 'package:manifest/screens/bottomNav.dart';
// import 'package:manifest/screens/toastMsg.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../Provider/provider.dart';

// final GoogleSignIn _googleSignIn = GoogleSignIn();
// String userName = ''; 

// Future<void> signInWithGoogle(BuildContext context) async {
//   try {
//     final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//     final GoogleSignInAuthentication googleAuth = await googleSignInAccount!.authentication;

//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Sign in to Firebase with Google credentials
//     final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//     // Access the user information if needed
//     final User? user = userCredential.user;
//     if (user != null) {
//       String userId = user.uid;
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();
//       print('User Name: $userName');
//       if (userDoc.exists) {
//         UserModel user = UserModel(
//           // userId: user.uid,
//           name: userDoc['name'],
//           phoneNumber: userDoc['phone_number'], email: '',
//         );

//         // Update the user provider with the user's data
//         Provider.of<UserProvider>(context, listen: false).updateUser(user);
//          await saveUserDataToSharedPreferences(userId, userDoc['name'], userDoc['phone_number'], userDoc['email']);
//         showToast(message: 'User is successfully created');

//         print('User is successfully created');
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => bottomNav(userName: userName),
//           ),
//         );
//       } else {
//         showToast(message: 'Error occured');
//         print('Error occured');
//       }
//     }

//   } catch (error) {
//     print('Error signing in with Google: $error');
//     // Handle sign-in error
//   }
// }
//   Future<void> saveUserDataToSharedPreferences(String name, String phoneNumber, String email, String userId) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString('userId', userId);
//   prefs.setString('userName', name);
//   prefs.setString('email', email);
//   prefs.setString('userPhoneNumber', phoneNumber);
// }