import 'package:Notey/models/note_model.dart';
import 'package:Notey/screens/home/no_notes_illustration.dart';
import 'package:flutter/material.dart';
import 'note_tile.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final List<String> selectedNotes;

  const NoteList({Key key, @required this.notes, this.selectedNotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(notes.length > 0){
       return Expanded(
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) => NoteTile(note: notes[index],)
        )
      );
    } else {
      return NoNotesIllustration();
    }
  }
}