import 'package:Notey/models/note_model.dart';
import 'package:equatable/equatable.dart';

abstract class NotesListEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoadNotes extends NotesListEvent{}

class NoteLoadSuccess extends NotesListEvent{}

class NoteSelected extends NotesListEvent{
  final String noteId;

  NoteSelected(this.noteId);
  @override
  List<Object> get props => [this.noteId];
}

class NotesDeletePressed extends NotesListEvent{}

class NotesUpdated extends NotesListEvent{
  final List<Note> notes;

  NotesUpdated(this.notes);
  @override
  List<Object> get props => [this.notes];
}