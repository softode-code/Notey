import 'package:cloud_firestore/cloud_firestore.dart';

class Note{
  String title;
  String note;
  int colorCode;
  int onColorCode;
  String id;
  Timestamp lastModified;

  Note({this.title, this.note, this.colorCode, this.onColorCode, this.lastModified, this.id});

  Note.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.note = map['note'];
    this.colorCode = map['colorCode'];
    this.onColorCode = map['onColorCode'];
    this.id = map['id'];
    this.lastModified = map['lastModified'];
  }

  Map<String, dynamic> toMap(){
    return {
      'title': this.title,
      'note': this.note,
      'colorCode': this.colorCode,
      'onColorCode': this.onColorCode,
      'id': this.id,
      'lastModified': this.lastModified
    };
  }

}