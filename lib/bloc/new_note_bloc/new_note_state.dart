import 'package:flutter/material.dart';


class NewNoteState{
  final bool isTitleEmpty;
  final bool isNoteEmpty;
  final int colorCode;
  final int onColorCode;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isEmpty => isTitleEmpty && isNoteEmpty;

  NewNoteState({this.onColorCode, this.isTitleEmpty, this.isNoteEmpty, this.isSubmitting, this.isSuccess, this.isFailure, this.colorCode});

  factory NewNoteState.initial(){
    return NewNoteState(
      isTitleEmpty: true,
      isNoteEmpty: true,
      colorCode: Colors.white.value,
      onColorCode: Colors.black.value,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false
    );
  }

  NewNoteState update({
    int colorCode,
    bool isTitleEmpty,
    bool isNoteEmpty,
    int onColorCode
  }) {
    return copyWith(
      isTitleEmpty: isTitleEmpty,
      isNoteEmpty: isNoteEmpty,
      colorCode: colorCode,
      onColorCode: onColorCode,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false
    );
  }
  
  NewNoteState copyWith({
    bool isTitleEmpty,
    bool isNoteEmpty,
    int colorCode,
    int onColorCode,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure
  }){
    return NewNoteState(
      isTitleEmpty: isTitleEmpty ?? this.isTitleEmpty,
      isNoteEmpty: isNoteEmpty ?? this.isNoteEmpty,
      colorCode: colorCode ?? this.colorCode,
      onColorCode: onColorCode ?? this.onColorCode,
      isSuccess: isSuccess ?? this.isSuccess,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFailure: isFailure ?? this.isFailure
    );
  }

}