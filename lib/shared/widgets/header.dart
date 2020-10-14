import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: accentColor,
            fontSize: 32,
            fontWeight: FontWeight.w600
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: black60
          ),
        ),
      ],
    );
  }
}
