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
  NotesListState get initialState => NotesLoadInProgress();
  
  @override
  Stream<NotesListState> mapEventToState(NotesListEvent event) async *{
    if(event is LoadNotes){
      yield* _mapLoadNotesToState();
    }
    if(event is NoteSelected){
      yield* _mapNoteSelectedToState(event.noteId);
    }
    if(event is NotesDeletePressed) {
      yield* _mapNotesDeletePressed();
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

  Stream<NotesListState> _mapNoteSelectedToState(String noteId) async*{
    if(state is NotesLoaded){
      if(state.selectedNotes == null){
        state.selectedNotes = [];
      }
      state.selectedNotes.add(noteId);
      yield state;
    }
  }

  Stream<NotesListState> _mapNotesDeletePressed() async* {
    _noteRepository.deleteNotes(state.selectedNotes);
    state.selectedNotes = null;
  }

  Stream<NotesListState> _mapNotesUpdatedToState(NotesUpdated event) async* {
    yield NotesLoaded(notes: event.notes, selectedNotes: null);
  }

  

}