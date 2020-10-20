import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';


class ChooseColorDialog extends StatelessWidget {
  ChooseColorDialog({
    Key key,
  }) : super(key: key);

  List<Color> colors = [
    Color(0xFFFFFFFF),
    Color(0xFFFAF8F0),
    Color(0xFFFBC7C3),
    Color(0xFFE44652),
    Color(0xFF043353),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a color',
              style: TextStyle(
                fontSize: 18.0
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                return Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(color: black20, width: 1),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2,1),
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10
                    )
                  ]
                ),
              );
              }),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed:() => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: black50
                    ),
                  ),
                ),
                InkWell(
                  onTap:() => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical:10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: primaryBackground,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: primaryColor
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}