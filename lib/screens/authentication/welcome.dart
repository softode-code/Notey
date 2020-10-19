import 'package:Notey/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_event.dart';
import 'package:Notey/bloc/welcome_bloc/welcome_bloc.dart';
import 'package:Notey/bloc/welcome_bloc/welcome_event.dart';
import 'package:Notey/bloc/welcome_bloc/welcome_state.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/screens/authentication/authenticate.dart';
import 'package:Notey/services/auth.dart';
import 'package:Notey/shared/widgets/footer.dart';
import 'package:Notey/shared/widgets/google_text_button.dart';
import 'package:Notey/shared/widgets/header.dart';
import 'package:Notey/shared/widgets/sign_in_email_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {

  final AuthService authService;

  const Welcome({Key key, this.authService}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<WelcomeBloc>(
        create: (context) => WelcomeBloc(authService: authService),
        child: BlocListener<WelcomeBloc, WelcomeState>(
          listener: (context, state) {
            if(state is WelcomeLoading){
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
            if (state is WelcomeFailure){
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
            if (state is WelcomeSuccess){
              BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedIn());
            }
          },
          child: BlocBuilder<WelcomeBloc, WelcomeState>(
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40,),
                        Header(
                          title: 'Welcome',
                          subtitle: 'Take notes and sync them across all your devices.',
                        ),
                        SizedBox(height:40),
                        SvgPicture.asset('assets/welcome_illustration.svg',height: size.height*0.4,),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GoogleTextButton(
                                onPressed: () => BlocProvider.of<WelcomeBloc>(context).add(WelcomeSignInWithGooglePressed()),
                              ),
                              SizedBox(height:20),
                              SignInEmailButton(
                                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Authenticate(showSignIn: true,authService: authService,))),
                              ),
                              SizedBox(height:30),
                              Footer(
                                text: 'Not a member?',
                                actionText: 'Sign up',
                                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Authenticate(showSignIn: false,authService: authService,))),
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
          ),
        ),
      ),
    );
  }
}