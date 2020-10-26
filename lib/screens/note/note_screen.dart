import 'package:Notey/models/note_model.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/services/note_repository.dart';
import 'package:Notey/shared/constants.dart';
import 'package:Notey/shared/widgets/app_bar_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NoteScreen extends StatefulWidget {
  final Note note;
  final NoteRepository noteRepository;

  const NoteScreen({Key key, this.note, this.noteRepository}) : super(key: key);
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _noteController.text = widget.note.note;
  }

  @override
  Widget build(BuildContext context) {
    Note note = widget.note;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(note.colorCode),
      body: SafeArea(
        child: Padding(
          padding:EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Form(
            key: _formkey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset('assets/back_icon.svg', color: Color(note.onColorCode),)
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                            color: primaryBackground,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Icon(
                            Icons.done,
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),

                    TextFormField(
                      controller: _titleController,
                      maxLines: 1,
                      decoration: inputDecoration.copyWith(
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          fontSize: 28.0,
                          color: Color(note.onColorCode).withOpacity(0.4),
                          fontWeight: FontWeight.normal
                        )
                      ),
                      style: TextStyle(
                        color: Color(note.onColorCode),
                        fontSize: 28.0
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 30,),
                      constraints: BoxConstraints(maxHeight: size.height*0.8),
                      child: TextFormField(
                        maxLines: null,
                        controller: _noteController,
                        decoration: inputDecoration.copyWith(
                          hintText: 'Your note...',
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Color(note.onColorCode).withOpacity(0.4),
                            fontWeight: FontWeight.normal
                          ),
                        ),
                        style: TextStyle(
                          color: Color(note.onColorCode).withOpacity(0.8),
                          fontSize: 20.0
                        ),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        //onTap: () async => openDialog(),
                        child: SvgPicture.asset(
                          'assets/color_pallette.svg',
                          color: Color(note.onColorCode).withOpacity(0.8),
                        )
                      ),
                      Text(
                        'Last Modified: '+_timeStampToString(note.lastModified),
                        style: TextStyle(
                          color: Color(note.onColorCode).withOpacity(0.5),
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Icon(
                        Icons.delete_outline,
                        color: Color(note.onColorCode).withOpacity(0.5),
                        size: 28,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _timeStampToString(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul',
      'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return "${dateTime.day.toString().padLeft(2,'0')} ${months[dateTime.month-1]}, ${dateTime.year.toString()} ${dateTime.hour.toString()}:${dateTime.minute.toString()}";
  }

}