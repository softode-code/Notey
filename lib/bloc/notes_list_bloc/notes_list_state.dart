import 'package:Notey/models/note_model.dart';
import 'package:equatable/equatable.dart';

abstract class NotesListState extends Equatable{
  List<Note> notes;
  List<String> selectedNotes;

  NotesListState({this.notes, this.selectedNotes});

   @override
  List<Object> get props => [];
}

class NotesLoadInProgress extends NotesListState{}

class NotesLoaded extends NotesListState{

  NotesLoaded({List<Note> notes, List<String> selectedNotes})
    :super(notes: notes, selectedNotes: selectedNotes);

  bool get haveSelected => selectedNotes != null;

  @override
  List<Object> get props => [this.notes, this.selectedNotes];
}

class NotesLoadFailure extends NotesListState{}