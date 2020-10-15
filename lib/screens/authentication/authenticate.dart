import 'package:Notey/screens/authentication/signin.dart';
import 'package:Notey/screens/authentication/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {

  bool showSignIn;

  Authenticate({this.showSignIn = true});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  void toggleSignIn() => setState(()=> widget.showSignIn = !widget.showSignIn);
  

  @override
  Widget build(BuildContext context) {
    return SignUp(toggleView: toggleSignIn);
  }
}