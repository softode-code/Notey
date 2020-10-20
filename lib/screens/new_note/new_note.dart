import 'package:Notey/shared/widgets/app_bar_action_button.dart';
import 'package:flutter/material.dart';
import 'package:Notey/shared/widgets/back_button.dart';
class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //top bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(),
                AppBarActionButton(
                  text: 'Save',
                  onPressed: () => print('save'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}