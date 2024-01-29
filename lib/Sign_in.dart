import 'package:fire/Services/firebase_service.dart';
import 'package:fire/reusable_widget/HomeScreen.dart';
import 'package:fire/reusable_widget/reusbale_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onClickSignIn;

  const SignInScreen({Key? key, required this.onClickSignIn}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final navigatorKey = GlobalKey<NavigatorState>();
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff314755),
                Color(0xff26a0da),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  10, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    logoWidget("assets/images/download.png"),
                    const SizedBox(height: 30),
                    reusableTextField(
                      label: "email",
                      icon: Icons.email,
                      isPasswordType: false,
                      controller: _emailTextController,
                    ),
                    const SizedBox(height: 20),
                    reusableTextField(
                      label: "password",
                      icon: Icons.lock,
                      isPasswordType: true,
                      controller: _passwordTextController,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: signIn,
                      icon: const Icon(Icons.lock_open),
                      label:
                          const Text("Sign In", style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    signUpOption(),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () async {
                          await FirebaseServices().signInWithGoogle();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.android),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Sign up with Google"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  } 

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: widget.onClickSignIn,
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Future<void> signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );
    } catch (e) {
      print("Sign-in error: $e");
      // Handle sign-in error
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
