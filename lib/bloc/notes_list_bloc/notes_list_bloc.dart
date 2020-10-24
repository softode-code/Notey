import 'dart:async';
import 'package:Notey/bloc/notes_list_bloc/notes_list_event.dart';
import 'package:Notey/bloc/notes_list_bloc/notes_list_state.dart';
import 'package:Notey/services/note_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState>{

  final NoteRepository _noteRepository;
  StreamSubscription _notesSubscription;

  
  NotesListBloc({NoteRepository noteRepository})
    : assert(noteRepository != null),
      _noteRepository = noteRepository, super(NotesLoadInProgress());
  
  @override
  Stream<NotesListState> mapEventToState(NotesListEvent event) async *{
    if(event is LoadNotes){
      yield* _mapLoadNotesToState();
    }
    if(event is NotesUpdated){
      yield* _mapNotesUpdatedToState(event);
    }
  }

  Stream<NotesListState> _mapLoadNotesToState() async* {
    _notesSubscription?.cancel();
    _notesSubscription = _noteRepository.notes().listen(
      (notes) {
        add(
          NotesUpdated(notes)
        );
      },
    );
  }

  Stream<NotesListState> _mapNotesUpdatedToState(NotesUpdated event) async* {
    yield NotesLoaded(notes: event.notes,);
  }

  

}