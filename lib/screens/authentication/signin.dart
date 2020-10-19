import 'package:Notey/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_event.dart';
import 'package:Notey/bloc/login_bloc/login_bloc.dart';
import 'package:Notey/bloc/login_bloc/login_state.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/screens/authentication/sign_in_form.dart';
import 'package:Notey/services/auth.dart';
import 'package:Notey/shared/widgets/footer.dart';
import 'package:Notey/shared/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatelessWidget {
  
  final Function toggleView;
  final AuthService _authService;

  const SignIn({Key key, this.toggleView, AuthService authService}) : _authService = authService, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authService: _authService),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:50),
                  Header(
                    title: 'Sign in',
                    subtitle: 'Get started right where you left off.'
                  ),
                  SizedBox(height: 70),
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if(state.isFailure){
                        Scaffold.of(context)..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sign-in failed!'),
                                Icon(Icons.error_outline, color: Colors.white,)
                              ],
                            ),
                            backgroundColor: accentColor,
                          )
                        );
                      } 

                      if (state.isSuccess) {
                        BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedIn());
                        Navigator.pop(context);
                      }

                      if (state.isSubmitting) {
                        Scaffold.of(context)..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Signing in...'),
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
                    child: SignInForm(),
                  ),
                  SizedBox(height:30),
                  Footer(
                    text: 'Not a member?',
                    actionText: 'Sign up',
                    onPressed: toggleView,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}