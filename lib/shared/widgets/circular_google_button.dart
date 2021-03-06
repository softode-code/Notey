import 'package:Notey/res/colors.dart';
import 'package:Notey/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class CircluarGoogleButton extends StatelessWidget {
  const CircluarGoogleButton({
    Key key, this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [BoxShadow(
            offset: Offset(0,4),
            color: black10,
            blurRadius: 17
          )]
        ),
        child: SvgPicture.asset('assets/google_icon.svg', height:44, width:44),
      ),
    );
  }
}