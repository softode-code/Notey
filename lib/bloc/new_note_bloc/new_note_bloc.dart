import 'package:Notey/bloc/new_note_bloc/new_note_event.dart';
import 'package:Notey/bloc/new_note_bloc/new_note_state.dart';
import 'package:Notey/models/note_model.dart';
import 'package:Notey/services/note_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewNoteBloc extends Bloc<NewNoteEvent, NewNoteState> {

  final NoteRepository _noteRepository;

  NewNoteBloc({NoteRepository noteRepository}) :
    _noteRepository = noteRepository,
    super(NewNoteState.initial());

  @override
  Stream<NewNoteState> mapEventToState(NewNoteEvent event) async* {
    if(event is NewNoteTitleChanged){
      yield* _mapTitleChangedEventToState(event.title);
    }
    if(event is NewNoteNoteChanged){
      yield* _mapNoteChangedEventToState(event.note);
    }
    if(event is NewNoteColorChanged){
      yield* _mapNoteColorChangedEventToState(event.colorCode, event.onColorCode);
    }
    if(event is NewNoteSavePressed){
      yield* _mapNoteSavedPressedToState(state.title, state.note, state.colorCode, state.onColorCode);
    }
  }

  Stream<NewNoteState> _mapTitleChangedEventToState(String title) async* {
    yield state.update(
      title: title
    );
  }

  Stream<NewNoteState> _mapNoteChangedEventToState(String note) async* {
    yield state.update(
      note: note
    );
  }

  Stream<NewNoteState> _mapNoteColorChangedEventToState(int code, int onColor) async* {
    yield state.update(
      colorCode: code,
      onColorCode: onColor
    );
  }

  Stream<NewNoteState> _mapNoteSavedPressedToState(String title, String noteText, int colorCode, int onColorCode) async* {
    yield NewNoteState.loading(state);
    try{
      Note note = Note(title: title, note: noteText, colorCode: colorCode, onColorCode: onColorCode);
      dynamic result = await _noteRepository.addNote(note);
      if(result != null){
        yield NewNoteState.success(state);
      } else {
        yield NewNoteState.failure(state);
      }
    } catch(e){
      print(e.toString());
      yield NewNoteState.failure(state);
    }
  }
 
}