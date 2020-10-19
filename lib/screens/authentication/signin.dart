import 'package:Notey/bloc/login_bloc/login_bloc.dart';
import 'package:Notey/bloc/login_bloc/login_state.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/screens/authentication/sign_in_form.dart';
import 'package:Notey/services/auth.dart';
import 'package:Notey/shared/widgets/footer.dart';
import 'package:Notey/shared/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  final AuthService authService;

  const SignIn({Key key, this.toggleView, this.authService}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authService: widget.authService),
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
                        print('success');
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
                    onPressed: widget.toggleView,
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