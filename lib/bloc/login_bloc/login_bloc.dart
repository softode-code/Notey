import 'package:Notey/bloc/login_bloc/login_event.dart';
import 'package:Notey/bloc/login_bloc/login_state.dart';
import 'package:Notey/services/auth.dart';
import 'package:Notey/shared/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthService _authService;

  LoginBloc({AuthService authService}) :
    _authService = authService,
    super(LoginState.initial()
    );

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChange){
      yield* _mapLoginEmailChangeToState(event.email);
    } else if (event is LoginPasswordChange){
      yield* _mapLoginPasswordChangeToState(event.password);
    } else if(event is LoginWithCredentialsPressed){
      yield* _mapLoginWithCredentialsPressedToState(event.email, event.password);
    } else if(event is LoginWithGooglePressed){
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email)
    );
  }

  Stream<LoginState> _mapLoginPasswordChangeToState(String password) async* {
    yield state.update(
      isPasswordValid: password.length < 6 ? false : true
    );
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(String email, String password) async* {
    yield LoginState.loading();
    try{
      final result = await _authService.signIn(email, password);
      if(result != null){
        yield LoginState.success();
      } else {
        yield LoginState.failure();
      }
    } catch(e){
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async*{
    yield LoginState.loading();
    try {
      final result = await _authService.googleSignIn();
      if(result != null){
        yield LoginState.success();
      } else {
        LoginState.failure();
      }
    } catch(e){
      LoginState.failure();
    }
  }
 
}