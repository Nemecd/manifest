// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manifest/Models/user.dart';
import 'package:manifest/Provider/provider.dart';
import 'package:manifest/screens/HomeScreen.dart';
import 'package:manifest/screens/SigninScreen.dart';
import 'package:manifest/screens/bottomNav.dart';
import 'package:manifest/screens/firebase/google.dart';
import 'package:manifest/screens/toastMsg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase/firebaseAuth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuthSevice _auth = FirebaseAuthSevice();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String userName = "";
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool loading = false;
  
  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          );
        }),
        backgroundColor: const Color(0xFFf6fafd),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            color: Color(
                0xFFf6fafd), // Set the background color using a BoxDecoration
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('Create your',
                        style: TextStyle(fontSize: 40, fontFamily: 'Inter')),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, bottom: 20.0),
                    child: Text('Account',
                        style: TextStyle(fontSize: 40, fontFamily: 'Inter')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 7.0),
                    child: TextFormField(
                        controller: nameCtrl,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Name', filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Inter',
                              fontSize: 15),
                          border: outlineInputBorder,
                          enabledBorder:
                              outlineInputBorder, // Border when unfocused
                          focusedBorder: outlineInputBorder.copyWith(
                            borderSide: const BorderSide(
                                color: Colors.black), // Border when focused
                          ),
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Name";
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFormField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Email', filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Inter',
                              fontSize: 15),
                          border: outlineInputBorder,
                          enabledBorder:
                              outlineInputBorder, // Border when unfocused
                          focusedBorder: outlineInputBorder.copyWith(
                            borderSide: const BorderSide(
                                color: Colors.black), // Border when focused
                          ),
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Email Address";
                          }
                          if (!RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(value)) {
                            return 'Invalid Email';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 7.0),
                    child: TextFormField(
                      controller: phoneCtrl,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Phone Number', filled: true,
                        fillColor: Colors.white,
                        labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Inter',
                            fontSize: 15),
                        border: outlineInputBorder,
                        enabledBorder:
                            outlineInputBorder, // Border when unfocused
                        focusedBorder: outlineInputBorder.copyWith(
                          borderSide: const BorderSide(
                              color: Colors.black), // Border when focused
                        ),
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your phone number';
                        }
                        if (value!.length > 15) {
                          return 'Invaild number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 7.0),
                    child: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Password', filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Inter',
                              fontSize: 15),
                          border: outlineInputBorder,
                          enabledBorder:
                              outlineInputBorder, // Border when unfocused
                          focusedBorder: outlineInputBorder.copyWith(
                            borderSide: const BorderSide(
                                color: Colors.black), // Border when focused
                          ),
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.black),
                          suffixIcon: IconButton(
                            icon: _obscurePassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.length < 8 || value.length > 20) {
                            return 'Password value must be up to 8 characters';
                          }
                          return null;
                        },
                        obscureText: _obscurePassword),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 20.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _signUp();
                            }
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, 48.0),
                            ),
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Color(0XFF1e65ff)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Reduce the border radius
                              ),
                            ),
                          ),
                          child: loading
                              ? Container(
                                  width: 24,
                                  height: 24,
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors
                                            .white), // Set the color of the stroke
                                  ),
                                )
                              : const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ))),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            // Horizontal line
                            color: Colors.black,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('or continue with',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                              )),
                        ),
                        Expanded(
                          child: Container(
                            height: 1, // Another horizontal line
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors
                                  .white, // Set the background color using a BoxDecoration
                            ),
                            child: Image.asset('assets/img/facebook.png',
                                width: 24, height: 24)),
                        const SizedBox(width: 16),
                        Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors
                                  .white, // Set the background color using a BoxDecoration
                            ),
                            child: GestureDetector(
                              onTap: ((){
                                signInWithGoogle();
                              }),
                              child: Image.asset('assets/img/google.png',
                                  width: 24, height: 24),
                            )),
                        const SizedBox(width: 16),
                        Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors
                                  .white, // Set the background color using a BoxDecoration
                            ),
                            child: Image.asset('assets/img/apple.png',
                                width: 24, height: 24)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0, top: 16.0),
                    child: Row(
                      children: [
                        const Text('Already have an account ?',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                            )),
                        GestureDetector(
                          onTap: (() {
                            var route = MaterialPageRoute(
                                builder: (context) => const SigninScreen());
                            Navigator.push(context, route);
                          }),
                          child: const Text(
                            ' Log In',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0XFF1e65ff),
                              fontFamily: 'Inter',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
  setState(() {
    loading = true;
  });

  String name = nameCtrl.text;
  String email = emailCtrl.text;
  String phoneNumber = phoneCtrl.text;
  String password = _passwordController.text;

  try {
    User? user = await _auth.signupwithemailAndPassword(
      name,
      email,
      phoneNumber,
      password,
    );

    setState(() {
      loading = false;
    });

    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        String userName = userDoc['name'] ?? '';
        String userPhoneNumber = userDoc['phone_number'] ?? '';
        String userEmail = userDoc['email'] ?? '';

        if (userName.isNotEmpty && userPhoneNumber.isNotEmpty) {
          UserModel newUser = UserModel(
            name: userName,
            phoneNumber: userPhoneNumber,
            email: userEmail,
          );

          Provider.of<UserProvider>(context, listen: false).updateUser(newUser);
          await saveUserDataToSharedPreferences(
            userId,
            userName,
            userPhoneNumber,
            userEmail,
            true,
          );

          showToast(message: 'User is successfully created');
          print('User is successfully created');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => bottomNav(userName: userName),
            ),
          );
        } else {
          showToast(message: 'Failed to fetch user data');
          print('Failed to fetch user data');
        }
      } else {
        showToast(message: 'Error occurred while creating user');
        print('Error occurred while creating user');
      }
    }
  } catch (e) {
    setState(() {
      loading = false;
    });
    showToast(message: 'Error occurred: $e');
    print('Error occurred: $e');
  }
}
Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with Google credentials
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    // Access the user information if needed
    final User? user = userCredential.user;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      print('User Name: $userName');
      if (userDoc.exists) {
        UserModel user = UserModel(
          // userId: user.uid,
          name: userDoc['name'],
          phoneNumber: userDoc['phone_number'], email: '',
        );

        // Update the user provider with the user's data
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        showToast(message: 'User is successfully created');

        print('User is successfully created');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => bottomNav(userName: userName),
          ),
        );
      } else {
        showToast(message: 'Error occured');
        print('Error occured');
      }
    }

  } catch (error) {
    print('Error signing in with Google: $error');
    // Handle sign-in error
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


}
