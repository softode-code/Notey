import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class NoNotesIllustration extends StatelessWidget {
  const NoNotesIllustration({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        constraints: BoxConstraints.tight(size),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height:20),
            SvgPicture.asset('assets/no_notes.svg', height: size.width*0.6, width: size.width*0.6,),
            Text(
              'You haven’t taken any notes yet.',
              style: TextStyle(
                fontSize: 16.0,
                color: black60
              ),
            )
          ],
        ),
      ),
    );
  }
}