import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.notes_outlined, size: 60, color: primaryColor,),
            Text(
              'Notey',
              style: TextStyle(
                color: accentColor,
                fontSize: 36.0,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      ),
    );
  }
}