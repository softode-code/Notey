import 'package:Notey/res/colors.dart';
import 'package:Notey/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_bar.dart';
class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
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
                        color: black40,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
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
                            color: black40,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                        style: TextStyle(
                          color: black80,
                          fontSize: 20.0
                        )
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
                      onTap: () => print('Open Pallette'),
                      child: SvgPicture.asset('assets/color_pallette.svg')
                    ),
                    Text(
                      '14 Oct, 2020 4:50 pm',
                      style: TextStyle(
                        color: black50,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}