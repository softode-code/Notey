import 'package:Notey/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_event.dart';
import 'package:Notey/models/user_model.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/screens/new_note/new_note.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final UserModel user;

  const Home({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Icon(
          Icons.add,
          color: onPrimary,
        ),
        onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => NewNote())),
      ),
      body: Center(
        child: Text(
          'Hello ${user.email}'
        ),
      ),
    );
  }
}