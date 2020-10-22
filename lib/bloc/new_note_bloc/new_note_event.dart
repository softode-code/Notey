import 'package:equatable/equatable.dart';

abstract class NewNoteEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class NewNoteTitleChanged extends NewNoteEvent{
  final String title;
  NewNoteTitleChanged({this.title});

  @override
  List<Object> get props => [this.title];
}

class NewNoteNoteChanged extends NewNoteEvent{
  final String note;
  NewNoteNoteChanged({this.note});

  @override
  List<Object> get props => [this.note];
}

class NewNoteColorChanged extends NewNoteEvent{
  final int colorCode;
  final int onColorCode;
  NewNoteColorChanged({this.colorCode, this.onColorCode});

  @override
  List<Object> get props => [this.colorCode];
}

class NewNoteSavePressed extends NewNoteEvent{
  final String title;
  final String note;
  final String colorCode;
  NewNoteSavePressed({this.title, this.note, this.colorCode});

  @override
  List<Object> get props => [this.title, this.note, this.colorCode];
}