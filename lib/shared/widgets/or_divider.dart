import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            height:1,
            color: black20,
          ),
        ),
        SizedBox(width:10),
        Text(
          'Or',
          style: TextStyle(
            color: black40,
            fontSize: 14
          ),
        ),
        SizedBox(width:10),
        Flexible(
          flex: 1,
          child: Container(
            height:1,
            color: black20,
          ),
        ),
      ],
    );
  }
}