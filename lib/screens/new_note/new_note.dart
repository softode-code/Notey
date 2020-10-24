import 'package:Notey/bloc/new_note_bloc/new_note_bloc.dart';
import 'package:Notey/bloc/new_note_bloc/new_note_event.dart';
import 'package:Notey/bloc/new_note_bloc/new_note_state.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/screens/new_note/choose_color_dialog.dart';
import 'package:Notey/services/note_repository.dart';
import 'package:Notey/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_bar.dart';
class NewNote extends StatefulWidget {
  final String uid;

  const NewNote({Key key, this.uid}) : super(key: key);

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  NewNoteBloc _newNoteBloc;
  NoteRepository _noteRepository;

  @override
  void initState() {
    super.initState();
    _noteRepository = NoteRepository(uid: widget.uid);
    _newNoteBloc = NewNoteBloc(noteRepository: _noteRepository);
    _titleController.addListener(_titleChangeListener);
    _noteController.addListener(_noteChangeListener);
  }

  void openDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<NewNoteBloc>.value(
          value: _newNoteBloc,
          child: ChooseColorDialog(),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocProvider(
        create: (context) => _newNoteBloc,
        child: BlocListener<NewNoteBloc, NewNoteState>(
          listener: (context, state) {
            if(state.isFailure){
                Scaffold.of(context)..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Couldn\'t save note!'),
                        Icon(Icons.error_outline, color: Colors.white,)
                      ],
                    ),
                    backgroundColor: accentColor,
                  )
                );
              } 

              if (state.isSuccess) {
                Navigator.pop(context);
              }

              if (state.isSubmitting) {
                Scaffold.of(context)..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Saving...'),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      ],
                    ),
                    backgroundColor: accentColor,
                  )
                );
              }
          },
          child: BlocBuilder<NewNoteBloc, NewNoteState>(
            builder: (context, state){
              return Scaffold(
                resizeToAvoidBottomPadding: false,
                backgroundColor: Color(state.colorCode),
                body: Padding(
                  padding:EdgeInsets.fromLTRB(20, 40, 20, 10),
                  child: Form(
                    key: _formkey,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //top bar
                            NewNoteAppBar(),
                            //form
                            TextFormField(
                              controller: _titleController,
                              maxLines: 1,
                              decoration: inputDecoration.copyWith(
                                hintText: 'Title',
                                hintStyle: TextStyle(
                                  fontSize: 28.0,
                                  color: Color(state.onColorCode).withOpacity(0.4),
                                  fontWeight: FontWeight.normal
                                ),
                              ),
                              style: TextStyle(
                                color: Color(state.onColorCode),
                                fontSize: 28.0
                              )
                            ),
                            //BODY
                            Container(
                              padding: EdgeInsets.only(bottom: 30),
                              constraints: BoxConstraints(maxHeight: size.height*0.8),
                              child: TextFormField(
                                  maxLines: null,
                                  controller: _noteController,
                                  decoration: inputDecoration.copyWith(
                                    hintText: 'Your note...',
                                    hintStyle: TextStyle(
                                      fontSize: 20.0,
                                      color: Color(state.onColorCode).withOpacity(0.4),
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Color(state.onColorCode).withOpacity(0.8),
                                    fontSize: 20.0
                                  )
                                ),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () async => openDialog(),
                            child: SvgPicture.asset(
                              'assets/color_pallette.svg',
                              color: Color(state.onColorCode).withOpacity(0.8),
                            )
                          ),
                        )
                      ],
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

  void _titleChangeListener(){
    _newNoteBloc.add(NewNoteTitleChanged(title: _titleController.text));
  }

  void _noteChangeListener(){
    _newNoteBloc.add(NewNoteNoteChanged(note: _noteController.text));
  }

}

