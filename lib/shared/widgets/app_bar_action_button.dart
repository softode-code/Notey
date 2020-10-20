import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';


class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          color: primaryBackground,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Text(
          text,
          style: TextStyle(
            color: primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}