import 'package:Notey/res/colors.dart';
import 'package:Notey/screens/authentication/authenticate.dart';
import 'package:Notey/shared/widgets/primary_button_background.dart';
import 'package:flutter/material.dart';

class SignInEmailButton extends StatelessWidget {
  const SignInEmailButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Authenticate(showSignIn: true,))),
      child: PrimaryButtonBackground(
        child: Text(
          'Sign in with Email',
          style: TextStyle(
            color: onPrimary,
            fontSize: 18.0
          ),
        ),
      ),
    );
  }
}

