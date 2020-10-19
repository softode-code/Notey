import 'package:Notey/res/colors.dart';
import 'package:Notey/shared/widgets/primary_button_background.dart';
import 'package:flutter/material.dart';

class SignInEmailButton extends StatelessWidget {
  const SignInEmailButton({
    Key key, this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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

