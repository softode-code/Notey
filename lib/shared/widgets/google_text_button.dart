import 'package:Notey/res/colors.dart';
import 'package:Notey/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleTextButton extends StatelessWidget {
  const GoogleTextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await AuthService().googleSignIn();
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: black10, width: 1),
          borderRadius: BorderRadius.circular(12.0)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/google_icon.svg', height:44, width:44),
            SizedBox(width:10),
            Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}