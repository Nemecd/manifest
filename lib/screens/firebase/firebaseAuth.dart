import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manifest/screens/toastMsg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthSevice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupwithemailAndPassword( String name,String email,String phonenumber, String password) async {
    try{
      UserCredential data = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User? user = data.user;

       if (user != null) {
      // Create a new Firestore document for the user
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'phone_number': phonenumber,
        // 'password': password,
        // Other user data
      });
      await saveUserDataToSharedPreferences(user.uid, name, phonenumber, email, true);
      return user;
    } else {
      showToast(message: 'User registration failed.');
      return null;
    }
      // return data.user;
    }on FirebaseAuthException catch(e){
      if (e.code == 'email-already-in-use'){
        showToast(message: 'The email is already in use.');
      }else{
        showToast(message:'An error occured: ${e.code}');
      }
    }
    return null;
}

Future<User?> signinwithemailAndPassword(String email, String password) async {
    try{
      UserCredential data = await _auth.signInWithEmailAndPassword(email: email, password: password);
     
      return data.user;
    } on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found' || e.code =='wrong-password'){
        showToast(message: 'Invalid credentials provided. Please check your email and password.');
      print('Error occured Couldnt Sign in user: $e');
      }else{
        showToast(message:'An error occured: ${e.code}');
      }
    }
    return null;
}
}
Future<void> saveUserDataToSharedPreferences(
  String userId,
  String name,
  String phoneNumber,
  String email,
  bool isLoggedIn,
) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', userId);
  prefs.setString('userName', name);
  prefs.setString('userEmail', email);
  prefs.setString('userPhoneNumber', phoneNumber);
  prefs.setBool('isLoggedIn', isLoggedIn);
}