import 'package:Notey/bloc/new_note_bloc/new_note_event.dart';
import 'package:Notey/bloc/new_note_bloc/new_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewNoteBloc extends Bloc<NewNoteEvent, NewNoteState> {


  NewNoteBloc() : super(NewNoteState.initial());

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

    }
  }

  Stream<NewNoteState> _mapTitleChangedEventToState(String title) async* {
    yield state.update(
      isTitleEmpty: title.isEmpty
    );
  }

  Stream<NewNoteState> _mapNoteChangedEventToState(String note) async* {
    yield state.update(
      isNoteEmpty: note.isEmpty
    );
  }

  Stream<NewNoteState> _mapNoteColorChangedEventToState(int code, int onColor) async* {
    yield state.update(
      colorCode: code,
      onColorCode: onColor
    );
  }

  Stream<NewNoteState> _mapNoteSavedPressedToState(String title, String note, int colorCode) async* {
    //TODO: add note to firestore
  }
 
}