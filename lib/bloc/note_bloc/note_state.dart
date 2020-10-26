import 'package:Notey/models/note_model.dart';

class NoteState{
  final Note note;
  final bool isSaving;
  final bool isDeleting;
  final bool isSuccess;
  final bool isFailure;

  NoteState({this.note, this.isSaving, this.isDeleting, this.isFailure, this.isSuccess});

  factory NoteState.initial(Note note) {
    return NoteState(
      note: note,
      isSaving: false,
      isDeleting: false,
      isFailure: false,
      isSuccess: false
    );
  }

  factory NoteState.saving(Note note){
    return NoteState(
      isSaving: true,
      isDeleting: false,
      isSuccess: false,
      isFailure: false,
      note: note
    );
  }

  factory NoteState.deleting(Note note) {
    return NoteState(
      isFailure: false,
      isSuccess: false,
      isDeleting: true,
      isSaving: false,
      note: note
    );
  }

  factory NoteState.success(Note note){
    return NoteState(
      isFailure: false,
      isSaving: false,
      isDeleting: false,
      isSuccess: true,
      note: note
    );
  }

  factory NoteState.failure(Note note){
    return NoteState(
      isSuccess: false,
      isDeleting: false,
      isSaving: false,
      isFailure: true,
      note: note
    );
  }

  NoteState update({
    int colorCode,
    int onColorCode,
    String note,
    String title
  }) {
    return copyWith(
      title: title,
      note: note,
      colorCode: colorCode,
      onColorCode: onColorCode
    );
  }

  NoteState copyWith({
    String title,
    String note,
    int colorCode,
    int onColorCode,
    bool isSuccess,
    bool isDeleting,
    bool isSaving,
    bool isFailure
  }){
    this.note.title = title ?? this.note.title;
    this.note.note = note ?? this.note.note;
    this.note.colorCode = colorCode ?? this.note.colorCode;
    this.note.onColorCode = onColorCode ?? this.note.onColorCode;
    return NoteState(
      note: this.note,
      isDeleting: isDeleting ?? this.isDeleting,
      isFailure: isFailure ?? this.isFailure,
      isSaving: isSaving ?? this.isSaving,
      isSuccess: isSuccess ?? this.isSuccess
    );
  }

}