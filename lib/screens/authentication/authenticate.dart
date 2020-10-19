import 'package:Notey/screens/authentication/signin.dart';
import 'package:Notey/screens/authentication/signup.dart';
import 'package:Notey/services/auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {

  bool showSignIn;
  final AuthService authService;

  Authenticate({this.showSignIn = true, this.authService});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  void toggleSignIn() => setState(()=> widget.showSignIn = !widget.showSignIn);
  

  @override
  Widget build(BuildContext context) {
    if(widget.showSignIn){
      return SignIn(toggleView: toggleSignIn, authService: widget.authService,);
    } else {
      return SignUp(toggleView: toggleSignIn, authService: widget.authService);
    }
  }
}