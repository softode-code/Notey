import 'package:Notey/bloc/note_bloc/note_bloc.dart';
import 'package:Notey/bloc/note_bloc/note_choose_color_dialog.dart';
import 'package:Notey/bloc/note_bloc/note_event.dart';
import 'package:Notey/bloc/note_bloc/note_state.dart';
import 'package:Notey/models/note_model.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/services/note_repository.dart';
import 'package:Notey/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  NoteBloc _noteBloc;

  @override
  void initState() {
    super.initState();
    _noteBloc = NoteBloc(noteRepository: widget.noteRepository, note: widget.note);
    _titleController.text = widget.note.title;
    _noteController.text = widget.note.note;
    _titleController.addListener(_titleChangeLsitener);
    _noteController.addListener(_noteChangeListener);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocProvider(
        create: (context) => _noteBloc,
          child: BlocListener<NoteBloc, NoteState>(
            listener: (context, state){
              if(state.isSaving){
                Scaffold.of(context)..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Updating...'),
                      ],
                    ),
                    backgroundColor: primaryColor,
                  )
                );
              }
              if(state.isDeleting){
                Scaffold.of(context)..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Deleting...'),
                        Icon(Icons.error_outline, color: Colors.white,)
                      ],
                    ),
                    backgroundColor: accentColor,
                  )
                );
              }
              if(state.isFailure){
                Scaffold.of(context)..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('An error occurred!'),
                        Icon(Icons.error_outline, color: Colors.white,)
                      ],
                    ),
                    backgroundColor: accentColor,
                  )
                );
              }
              if(state.isSuccess){
                Navigator.pop(context);
              }
            },
            child: BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state){
                return Scaffold(
                    resizeToAvoidBottomPadding: false,
                    backgroundColor: Color(state.note.colorCode),
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
                                          child: SvgPicture.asset('assets/back_icon.svg', color: Color(state.note.onColorCode),)
                                        ),
                                        InkWell(
                                          onTap: () => _noteBloc.add(NoteSavedPressed()),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                            decoration: BoxDecoration(
                                              color: primaryBackground,
                                              borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: Icon(
                                              Icons.done,
                                              color: primaryColor,
                                            ),
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
                                          color: Color(state.note.onColorCode).withOpacity(0.4),
                                          fontWeight: FontWeight.normal
                                        )
                                      ),
                                      style: TextStyle(
                                        color: Color(state.note.onColorCode),
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
                                            color: Color(state.note.onColorCode).withOpacity(0.4),
                                            fontWeight: FontWeight.normal
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Color(state.note.onColorCode).withOpacity(0.8),
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
                                        onTap: () async => openDialog(),
                                        child: SvgPicture.asset(
                                          'assets/color_pallette.svg',
                                          color: Color(state.note.onColorCode).withOpacity(0.8),
                                        )
                                      ),
                                      Text(
                                        'Last Modified: '+_timeStampToString(state.note.lastModified),
                                        style: TextStyle(
                                          color: Color(state.note.onColorCode).withOpacity(0.5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => _noteBloc.add(NoteDeletePressed()),
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: Color(state.note.onColorCode).withOpacity(0.5),
                                          size: 28,
                                        ),
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

  void openDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<NoteBloc>.value(
          value: _noteBloc,
          child: NoteChooseColorDialog(),
        );
      }
    );
  }


  void _titleChangeLsitener(){
    _noteBloc.add(NoteTitleChangedEvent(title: _titleController.text));
  }

  void _noteChangeListener(){
    _noteBloc.add(NoteBodyChangedEvent(note: _noteController.text));
  }
}