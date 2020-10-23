import 'package:flutter/material.dart';


class NewNoteState{
  final String title;
  final String note;
  final int colorCode;
  final int onColorCode;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isEmpty => title.isEmpty & note.isEmpty;

  NewNoteState({this.onColorCode, this.note, this.title, this.isSubmitting, this.isSuccess, this.isFailure, this.colorCode});

  factory NewNoteState.initial(){
    return NewNoteState(
      title: '',
      note: '',
      colorCode: Colors.white.value,
      onColorCode: Colors.black.value,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false
    );
  }

  factory NewNoteState.loading(){
    return NewNoteState(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory NewNoteState.success(){
    return NewNoteState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory NewNoteState.failure(){
    return NewNoteState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  NewNoteState update({
    int colorCode,
    String title,
    String note,
    int onColorCode
  }) {
    return copyWith(
      title: title,
      note: note,
      colorCode: colorCode,
      onColorCode: onColorCode,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false
    );
  }
  
  NewNoteState copyWith({
    String title,
    String note,
    int colorCode,
    int onColorCode,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure
  }){
    return NewNoteState(
      title: title ?? this.title,
      note: note ?? this.note,
      colorCode: colorCode ?? this.colorCode,
      onColorCode: onColorCode ?? this.onColorCode,
      isSuccess: isSuccess ?? this.isSuccess,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFailure: isFailure ?? this.isFailure
    );
  }

}