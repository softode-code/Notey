import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';

class DiscardBottomSheet extends StatelessWidget {
  const DiscardBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discard Changes?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height:10),
          Text(
            'Do you want to discard this note?',
            style: TextStyle(
              fontSize: 16.0,
              color: black60
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: ()=> Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Discard', style: TextStyle(color: primaryColor),),
                color: primaryBackground,
              ),
            ],
          )
        ],
      ),
    );
  }
}