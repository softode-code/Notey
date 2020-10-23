import 'package:Notey/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_event.dart';
import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top:40, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedOut());
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15,),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black.withOpacity(0.15))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: accentColor, size: 24,),
                    SizedBox(width: 5),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: accentColor
                      ),
                    )
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}