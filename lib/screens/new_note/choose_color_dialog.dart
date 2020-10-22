import 'package:Notey/bloc/new_note_bloc/new_note_bloc.dart';
import 'package:Notey/bloc/new_note_bloc/new_note_event.dart';
import 'package:Notey/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChooseColorDialog extends StatelessWidget {
  ChooseColorDialog({
    Key key,
  }) : super(key: key);

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
              'Pick a color',
              style: TextStyle(
                fontSize: 18.0
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => BlocProvider.of<NewNoteBloc>(context).add(NewNoteColorChanged(colorCode: noteColors[index].value, onColorCode: onNoteColors[index].value)),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: noteColors[index],
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
                  ),
                );
              }),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                color: primaryBackground,
                onPressed: () => Navigator.pop(context),
                child: Text('Done', style: TextStyle(color: primaryColor),),
              ),
            )
          ],
        ),
      ),
    );
  }
}