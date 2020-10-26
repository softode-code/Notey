import 'package:equatable/equatable.dart';

abstract class NoteEvent extends Equatable{
   @override
  List<Object> get props => [];
}

class NoteTitleChangedEvent extends NoteEvent{
  final String title;
  NoteTitleChangedEvent({this.title});
  @override
  List<Object> get props => [this.title];
}

class NoteBodyChangedEvent extends NoteEvent{
  final String note;
  NoteBodyChangedEvent({this.note});
   @override
  List<Object> get props => [this.note];
}

class NoteColorChangedEvent extends NoteEvent{
  final int colorCode;
  final int onColorCode;
  NoteColorChangedEvent({this.colorCode, this.onColorCode});

   @override
  List<Object> get props => [this.colorCode, this.onColorCode];
}

class NoteSavedPressed extends NoteEvent{}

class NoteDeletePressed extends NoteEvent{}