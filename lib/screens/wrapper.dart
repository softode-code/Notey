import 'package:Notey/models/user_model.dart';
import 'package:Notey/screens/authentication/welcome.dart';
import 'package:Notey/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    if(user == null) {
      return Welcome();
    } else {
      return Home();
    }
  }
}