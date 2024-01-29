import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fire/reusable_widget/reusbale_widget.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickSignUp;

  const SignUpScreen({Key? key, required this.onClickSignUp}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
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
              padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    reusableTextField(
                      label: "Enter UserName",
                      icon: Icons.person_outline,
                      isPasswordType: false,
                      controller: _userNameTextController,
                    ),
                    const SizedBox(height: 20),
                    reusableTextField(
                      label: "Enter Email Id",
                      icon: Icons.email,
                      isPasswordType: false,
                      controller: _emailTextController,
                    ),
                    const SizedBox(height: 20),
                    reusableTextField(
                      label: "Enter Password",
                      icon: Icons.lock_outlined,
                      isPasswordType: true,
                      controller: _passwordTextController,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: SignUp,
                      icon: const Icon(Icons.android),
                      label: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Already have a Account"),
                          GestureDetector(
                            onTap: widget.onClickSignUp,
                            child: const Text(
                              " Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> SignUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );
    } catch (e) {
      print(e);
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
//}
