import 'package:Notey/bloc/login_bloc/login_bloc.dart';
import 'package:Notey/bloc/login_bloc/login_event.dart';
import 'package:Notey/bloc/login_bloc/login_state.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/shared/constants.dart';
import 'package:Notey/shared/widgets/circular_google_button.dart';
import 'package:Notey/shared/widgets/form_primary_button.dart';
import 'package:Notey/shared/widgets/or_divider.dart';
import 'package:Notey/shared/widgets/text_form_field_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);



  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  bool showPassword = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
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
                      validator: (val) => state.isEmailValid ? null : 'Please enter your email.',
                      controller: _emailController,
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
                          validator: (val) => state.isPasswordValid ? 'Password should be at least 6 characters long.' : null,
                          controller: _passwordController,
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
                      text: 'Sign in',
                      onPressed: _onSignInWithCredentialPressed,
                    ),
                  ),
                  SizedBox(height:35.0),
                  OrDivider(),
                  SizedBox(height:50.0),
                  Center(
                    child: CircluarGoogleButton(
                      onPressed: _onSignInWithGooglePressed,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }

  void _onEmailChanged(){
    _loginBloc.add(LoginEmailChange(email: _emailController.text));
  }

  void _onPasswordChanged(){
    _loginBloc.add(LoginPasswordChange(password: _passwordController.text));
  }

  void _onSignInWithCredentialPressed(){
    _loginBloc.add(LoginWithCredentialsPressed(email: _emailController.text, password: _passwordController.text));
  }

  void _onSignInWithGooglePressed() {
    _loginBloc.add(LoginWithGooglePressed());
  }
}