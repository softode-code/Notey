import 'package:Notey/bloc/register_bloc/register_bloc.dart';
import 'package:Notey/bloc/register_bloc/register_event.dart';
import 'package:Notey/bloc/register_bloc/register_state.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/shared/constants.dart';
import 'package:Notey/shared/widgets/circular_google_button.dart';
import 'package:Notey/shared/widgets/form_primary_button.dart';
import 'package:Notey/shared/widgets/or_divider.dart';
import 'package:Notey/shared/widgets/text_form_field_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignUpForm extends StatefulWidget {

  const SignUpForm({
    Key key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final _formkey = GlobalKey<FormState>();
  bool showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegisterBloc _registerBloc;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }


  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Form(
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
                      validator: (val) =>state.isPasswordValid ? 'Password should be at least 6 characters long.' : null,
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
                  text: 'Sign up',
                  onPressed: (){
                    if(isButtonEnabled(state)){
                      _onSignUpWithCredentialPressed();
                    }
                  },
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
        );
      }
    );
  }
    
  void _onEmailChanged(){
    _registerBloc.add(RegisterEmailChange(email: _emailController.text));
  }

  void _onPasswordChanged(){
    _registerBloc.add(RegisterPasswordChange(password: _passwordController.text));
  }

  void _onSignUpWithCredentialPressed(){
    _registerBloc.add(RegisterWithCredentialsPressed(email: _emailController.text, password: _passwordController.text));
  }

  void _onSignInWithGooglePressed() {
    _registerBloc.add(RegisterWithGooglePressed());
  }
}