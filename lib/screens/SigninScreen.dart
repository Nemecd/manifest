import 'package:flutter/material.dart';
import 'package:manifest/screens/SignupScreen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
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
                    decoration: InputDecoration(
                      labelText: 'Email', filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Inter',
                          fontSize: 15),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder, // Border when unfocused
                      focusedBorder: outlineInputBorder.copyWith(
                        borderSide: const BorderSide(
                            color: Colors.black), // Border when focused
                      ),
                      prefixIcon: const Icon(Icons.email, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 7.0),
                  child: TextFormField(
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
                      obscureText: _obscurePassword),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 48.0),
                          ),
                          backgroundColor: const MaterialStatePropertyAll<Color>(
                              Color(0XFF1e65ff)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Reduce the border radius
                            ),
                          ),
                        ),
                        child: const Text(
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
                                builder: (context) => const SignupScreen());
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
                        )
                        ),
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
                  padding: const EdgeInsets. only(left:70, top: 16.0),
                  child: Center(
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
                                builder: (context) => const SignupScreen());
                            Navigator.push(context, route);
                          }),
                          child: const Text(
                            ' Sign In',
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
}
