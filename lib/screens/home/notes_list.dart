import 'package:Notey/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NoteList extends StatelessWidget {

  List<Note> notes= [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SvgPicture.asset('assets/no_notes.svg', height: size.width*0.6, width: size.width*0.6,);
  }
}