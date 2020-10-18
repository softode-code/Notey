import 'package:Notey/bloc/authentication_bloc/authentication_event.dart';
import 'package:Notey/bloc/authentication_bloc/authentication_state.dart';
import 'package:Notey/models/user_model.dart';
import 'package:Notey/services/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{

  final AuthService _authService;

  AuthenticationBloc({AuthService authService}) 
    : _authService = authService,
    super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStarted){
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn){
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut){
      yield* _mapAuthenticationLoggedOutToState();
    }
  }


  //Authentication Logged Out
  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async*{
    yield AuthenticationFailure();
    _authService.signout();
  }

  
  //Authentication Logged In
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async*{
    yield AuthenticationSuccess(user: _authService.getUser());
  }


  //Authentication Started
  Stream<AuthenticationState> _mapAuthenticationStartedToState() async*{
    final isSignedIn = _authService.isSignedIn();
    if(isSignedIn){
      final UserModel user = _authService.getUser();
      yield AuthenticationSuccess(user: user);
    } else {
      yield AuthenticationFailure();
    }
  }

}