import 'package:Notey/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;

  const NoteList({Key key, @required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) => NoteTile(note: notes[index],)
      )
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key key,
    @required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Color(note.colorCode),
          borderRadius: BorderRadius.circular(12.0),
          border:
              Border.all(color: Colors.black.withOpacity(0.15), width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          note.title == null || note.title == ''
              ? SizedBox.shrink()
              : Text(
                  note.title,
                  style: TextStyle(
                      color: Color(note.onColorCode),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
          SizedBox(
            height: 5.0,
          ),
          note.note == null || note.note == ''
              ? SizedBox.shrink()
              : Text(
                  note.note,
                  style: TextStyle(
                    color: Color(note.onColorCode).withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
        ],
      ),
    );
  }
}
