import 'package:Notey/bloc/register_bloc/register_bloc.dart';
import 'package:Notey/bloc/register_bloc/register_state.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/screens/authentication/sign_up_formm.dart';
import 'package:Notey/services/auth.dart';
import 'package:Notey/shared/widgets/footer.dart';
import 'package:Notey/shared/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {


  final AuthService authService;
  final Function toggleView;

  const SignUp({Key key, this.authService, this.toggleView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authService: authService),
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
                  BlocListener<RegisterBloc, RegisterState>(
                    listener: (context, state){
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
                    child: SignUpForm(),
                  ),
                  SizedBox(height:30),
                  Footer(
                    text: 'Already have an account?',
                    actionText: 'Sign in',
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

