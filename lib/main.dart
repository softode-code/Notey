import 'package:Notey/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_event.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_state.dart';
import 'package:Notey/bloc/simple_bloc_observer.dart';
import 'package:Notey/res/colors.dart';
import 'package:Notey/res/theme.dart';
import 'package:Notey/screens/authentication/welcome.dart';
import 'package:Notey/screens/home/home.dart';
import 'package:Notey/screens/splash_screen.dart';
import 'package:Notey/screens/wrapper.dart';
import 'package:Notey/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final AuthService _authService = AuthService();
  runApp(
    BlocProvider(
      create: (context)=> AuthenticationBloc(
        authService: _authService
      ),
      child: MyApp(
        authService: _authService,
      )
    )
  );
}

class MyApp extends StatefulWidget {

  final AuthService _authService;

  MyApp({AuthService authService}) : _authService = authService;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationStarted());
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notey',
      theme: themeData,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if(state is AuthenticationFailure){
            return Welcome();
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