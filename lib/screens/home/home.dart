import 'package:Notey/models/user_model.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/screens/new_note/new_note.dart';
import 'package:Notey/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => NewNote(uid: user.uid,))),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Settings())),
                  child: SvgPicture.asset('assets/settings_icon.svg')
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}