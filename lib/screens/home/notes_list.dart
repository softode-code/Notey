import 'package:Notey/models/note_model.dart';
import 'package:Notey/screens/home/no_notes_illustration.dart';
import 'package:Notey/screens/note/note_screen.dart';
import 'package:Notey/services/note_repository.dart';
import 'package:flutter/material.dart';
import 'note_tile.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final NoteRepository noteRepository;

  const NoteList({Key key, @required this.notes, this.noteRepository,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(notes.length > 0){
       return Expanded(
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) => 
            InkWell(
              onTap: () => print(notes),
              child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NoteScreen(note: notes[index], noteRepository: noteRepository,))),
                child: NoteTile(note: notes[index],)
              )
            )
        )
      );
    } else {
      return NoNotesIllustration();
    }
  }
}