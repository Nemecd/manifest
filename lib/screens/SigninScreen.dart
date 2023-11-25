import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manifest/Models/user.dart';
import 'package:manifest/screens/ForgetPassword.dart';
import 'package:manifest/screens/HomeScreen.dart';
import 'package:manifest/screens/SignupScreen.dart';
import 'package:manifest/screens/bottomNav.dart';
import 'package:manifest/screens/toastMsg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/provider.dart';
import 'firebase/firebaseAuth.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final FirebaseAuthSevice _auth = FirebaseAuthSevice();
  String userName = '';
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('Login to your',
                      style: TextStyle(fontSize: 40, fontFamily: 'Inter')),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 20.0),
                  child: Text('Account',
                      style: TextStyle(fontSize: 40, fontFamily: 'Inter')),
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
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 7.0),
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
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
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
                            _signIn();
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 48.0),
                          ),
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Color(0XFF1e65ff)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                'Sign In',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ))),
                Padding(
                    padding: const EdgeInsets.only(left: 110.0, top: 16.0),
                    child: GestureDetector(
                      onTap: (() {
                        var route = MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen());
                        Navigator.push(context, route);
                      }),
                      child: const Text(
                        ' Forgot Password',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF1e65ff),
                          fontFamily: 'Inter',
                        ),
                      ),
                    )),
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
                          child: Image.asset('assets/img/google.png',
                              width: 24, height: 24)),
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
                  padding: const EdgeInsets.only(left: 50, top: 16.0),
                  child: Center(
                    child: Row(
                      children: [
                        const Text("Dont have an account ?",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                            )),
                        GestureDetector(
                          onTap: (() {
                            var route = MaterialPageRoute(
                                builder: (context) => const SignupScreen());
                            Navigator.push(context, route);
                          }),
                          child: const Text(
                            ' Create account',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
  setState(() {
    loading = true;
  });

  String email = emailCtrl.text;
  String password = _passwordController.text;

  User? user = await _auth.signinwithemailAndPassword(email, password);
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
      String userName = userDoc['name'];
      String userPhoneNumber = userDoc['phone_number'];
      String userEmail = userDoc['email'];

      UserModel user = UserModel(
        name: userName,
        phoneNumber: userPhoneNumber,
        email: userEmail,
      );

      Provider.of<UserProvider>(context, listen: false).updateUser(user);
      setState(() {
        userName = userDoc['name'];
      });

      showToast(message: 'User is successfully signed in');
      print('User is successfully signed in');

      Map<String, String> userData = await getUserDataFromSharedPreferences();
      print('Retrieved data: $userData');

      if (userData['userId'] != null && userData['userId']!.isNotEmpty) {
        var route = MaterialPageRoute(
          builder: (context) => bottomNav(userName: userName),
        );
        Navigator.push(context, route);
      } else {
        await saveUserDataToSharedPreferences(
          userId,
          userName,
          userEmail,
          userPhoneNumber,
          true,
        );
        print('Saved data: userId: $userId, userName: $userName, userPhoneNumber: $userPhoneNumber, userEmail: $userEmail,isLoggedIn: true');

        var route = MaterialPageRoute(
          builder: (context) => bottomNav(userName: userName),
        );
        Navigator.push(context, route);
      }
    } else {
      showToast(message: 'Error occurred');
      print('Error occurred');
    }
  }
}

  Future<Map<String, String>> getUserDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? '';
    final userName = prefs.getString('userName') ?? '';
    final userEmail = prefs.getString('email') ?? '';
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'isLoggedIn':
          isLoggedIn.toString(), // Return the flag along with user data
    };
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
