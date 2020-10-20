import 'package:Notey/shared/widgets/app_bar_action_button.dart';
import 'package:Notey/shared/widgets/back_button.dart';
import 'package:flutter/material.dart';


class NewNoteAppBar extends StatelessWidget {
  const NewNoteAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBackButton(),
        AppBarActionButton(
          text: 'Save',
          onPressed: () => print('save'),
        )
      ],
    );
  }
}