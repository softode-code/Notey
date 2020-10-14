import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';


class TextFormFieldBackground extends StatelessWidget {
  const TextFormFieldBackground({
    Key key,
    @required this.child,
  }) : super(key: key);
  
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:10.0, horizontal:15.0),
      decoration: BoxDecoration(
        color: textFormFieldColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: child
    );
  }
}