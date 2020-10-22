import 'package:Notey/bloc/new_note_bloc/new_note_bloc.dart';
import 'package:Notey/shared/widgets/app_bar_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


class NewNoteAppBar extends StatelessWidget {
  const NewNoteAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset('assets/back_icon.svg'
          ,color: Color(BlocProvider.of<NewNoteBloc>(context).state.onColorCode),)
        ),
        AppBarActionButton(
          text: 'Save',
          onPressed: () => print('save'),
        )
      ],
    );
  }
}