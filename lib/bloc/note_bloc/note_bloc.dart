import 'package:Notey/bloc/note_bloc/note_event.dart';
import 'package:Notey/bloc/note_bloc/note_state.dart';
import 'package:Notey/models/note_model.dart';
import 'package:Notey/services/note_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState>{

  NoteRepository _noteRepository;

  NoteBloc({NoteRepository noteRepository, Note note}) 
    : _noteRepository = noteRepository,
      super(NoteState.initial(note));

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if(event is NoteTitleChangedEvent){
      yield* _mapNoteTitleChangedToState(event.title);
    }
    if(event is NoteBodyChangedEvent){
      yield* _mapNoteBodyChangedToState(event.note);
    }
    if(event is NoteColorChangedEvent){
      yield* _mapNoteColorChangedToState(event.colorCode, event.onColorCode);
    }
    if(event is NoteSavedPressed){
      yield* _mapNoteSavedPressed();
    }
    if(event is NoteDeletePressed){
      yield* _mapNoteDeletePressed();
    }
  }

  Stream<NoteState> _mapNoteTitleChangedToState(String title) async* {
    yield state.update(
      title: title
    );
  }

  Stream<NoteState> _mapNoteBodyChangedToState(String note) async* {
    yield state.update(
      note: note
    );
  }

  Stream<NoteState> _mapNoteColorChangedToState(int colorCode, int onColorCode) async* {
    yield state.update(
      colorCode: colorCode,
      onColorCode: onColorCode
    );
  }

  Stream<NoteState> _mapNoteSavedPressed() async* {
    yield NoteState.saving(state.note);
    try {
      await _noteRepository.updateNote(state.note);
      yield NoteState.success(state.note);
    } catch(e){
      print(e.toString());
      yield NoteState.failure(state.note);
    }
  }

  Stream<NoteState> _mapNoteDeletePressed() async* {
    yield NoteState.deleting(state.note);
    try{
      await _noteRepository.deleteNote(state.note);
      yield NoteState.success(state.note);
    } catch(e){
      print(e.toString());
      yield NoteState.failure(state.note);
    }

    
  }
  
}