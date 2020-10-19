import 'package:Notey/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_event.dart';
import 'package:Notey/models/user_model.dart';
import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        onPressed:() async => BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedOut()),
      ),
      body: Center(
        child: Text(
          'Hello ${user.email}'
        ),
      ),
    );
  }
}