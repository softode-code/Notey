import 'package:Notey/models/user_model.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final UserModel user;

  const Home({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.logout,
          color: onPrimary,
        ),
        onPressed:() async => AuthService().signout(),
      ),
      body: Center(
        child: Text(
          'Hello ${user.email}'
        ),
      ),
    );
  }
}