import 'package:Notey/models/note_model.dart';
import 'package:equatable/equatable.dart';

abstract class NotesListState extends Equatable{
  List<Note> notes;

  NotesListState({this.notes,});

   @override
  List<Object> get props => [];
}

class NotesLoadInProgress extends NotesListState{}

class NotesLoaded extends NotesListState{

  NotesLoaded({List<Note> notes, List<String> selectedNotes})
    :super(notes: notes,);

  @override
  List<Object> get props => [this.notes,];
}

class NotesLoadFailure extends NotesListState{}