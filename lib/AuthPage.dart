import 'package:fire/Sign-up.dart';
import 'package:fire/Sign_in.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? SignInScreen(onClickSignIn: toggle)
      : SignUpScreen(onClickSignUp: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
