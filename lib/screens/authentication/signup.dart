import 'package:Notey/res/colors.dart';
import 'package:Notey/shared/constants.dart';
import 'package:Notey/shared/widgets/circular_google_button.dart';
import 'package:Notey/shared/widgets/footer.dart';
import 'package:Notey/shared/widgets/form_primary_button.dart';
import 'package:Notey/shared/widgets/header.dart';
import 'package:Notey/shared/widgets/or_divider.dart';
import 'package:Notey/shared/widgets/text_form_field_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;

  const SignUp({Key key, this.toggleView}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  final _formkey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:50),
                Header(
                  title: 'Sign up',
                  subtitle: 'Start taking notes and access them anywhere.'
                ),
                SizedBox(height: 70),
                Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormFieldBackground(
                        child: TextFormField(
                          decoration: inputDecoration.copyWith(
                            hintText: 'Email',
                            icon: Icon(
                              Icons.email_outlined,
                            )
                          ),
                          validator: (val) => val.isNotEmpty ? null : 'Please enter your email.',
                          onChanged: (val) => setState(()=> _email = val),
                        ),
                      ),
                      SizedBox(height:20.0),
                      TextFormFieldBackground(
                        child: Stack(
                          children: [
                            TextFormField(
                              decoration: inputDecoration.copyWith(
                                hintText: 'Password',
                                icon: Icon(
                                  Icons.lock
                                )
                              ),
                              obscureText: !showPassword,
                              validator: (val) => val.length < 6 ? 'Password should be at least 6 characters long.' : null,
                              onChanged: (val) => setState(()=> _password = val),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => setState(()=> showPassword = !showPassword),
                                child: SvgPicture.asset(
                                  showPassword ? 'assets/disabled_eye.svg' : 'assets/eye.svg',
                                  color: black40,
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height:20.0),
                      Center(
                        child: FormPrimaryButton(
                          text: 'Sign up',
                          onPressed: () {
                            if(_formkey.currentState.validate()){
                              print('Sign in');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:35.0),
                OrDivider(),
                SizedBox(height:50.0),
                Center(
                  child: CircluarGoogleButton(),
                ),
                SizedBox(height:30),
                Footer(
                  text: 'Already have an account?',
                  actionText: 'Sign in',
                  onPressed: widget.toggleView,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}