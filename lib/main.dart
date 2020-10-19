import 'package:Notey/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_event.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_state.dart';
import 'package:Notey/bloc/simple_bloc_observer.dart';
import 'package:Notey/res/theme.dart';
import 'package:Notey/screens/authentication/welcome.dart';
import 'package:Notey/screens/home/home.dart';
import 'package:Notey/screens/splash_screen.dart';
import 'package:Notey/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final AuthService authService = AuthService();
  runApp(
    BlocProvider(
      create: (context)=> AuthenticationBloc(
        authService: authService
      )..add(AuthenticationStarted()),
      child: MyApp(
        authService: authService,
      )
    )
  );
}

class MyApp extends StatelessWidget {

  final AuthService _authService;

  MyApp({AuthService authService}) : _authService = authService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notey',
      theme: themeData,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if(state is AuthenticationFailure){
            return Welcome(authService: _authService,);
          } else if (state is AuthenticationSuccess){
            return Home(user: state.user,);
          }
          //Splash Screen
          else if(state is AuthenticationInitial) {
            return SplashScreen();
          }
        },
      ),
    );
  }
}