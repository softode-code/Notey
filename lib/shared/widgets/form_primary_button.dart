import 'package:Notey/res/colors.dart';
import 'package:Notey/shared/widgets/primary_button_background.dart';
import 'package:flutter/material.dart';

class FormPrimaryButton extends StatelessWidget {
  const FormPrimaryButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  });

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: PrimaryButtonBackground(
        child: Padding(
          padding: const EdgeInsets.only(left:30.0, right:30.0),
          child: Text(
            text,
            style: TextStyle(
              color: onPrimary,
              fontSize: 18
            ),
          ),
        )
      ),
    );
  }
}