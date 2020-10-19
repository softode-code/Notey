import 'package:Notey/bloc/register_bloc/register_event.dart';
import 'package:Notey/bloc/register_bloc/register_state.dart';
import 'package:Notey/services/auth.dart';
import 'package:Notey/shared/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final AuthService _authService;

  RegisterBloc({AuthService authService}) :
    _authService = authService,
    super(RegisterState.initial()
    );

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChange){
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterPasswordChange){
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if(event is RegisterWithCredentialsPressed){
      yield* _mapRegisterWithCredentialsPressedToState(event.email, event.password);
    } else if(event is RegisterWithGooglePressed){
      yield* _mapRegisterWithGooglePressedToState();
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email)
    );
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password)
    );
  }

  Stream<RegisterState> _mapRegisterWithCredentialsPressedToState(String email, String password) async* {
    yield RegisterState.loading();
    try{
      final result = await _authService.registerUser(email, password);
      if(result != null){
        yield RegisterState.success();
      } else {
        yield RegisterState.failure();
      }
    } catch(e){
      yield RegisterState.failure();
    }
  }

  Stream<RegisterState> _mapRegisterWithGooglePressedToState() async*{
    yield RegisterState.loading();
    try {
      final result = await _authService.googleSignIn();
      if(result != null){
        yield RegisterState.success();
      } else {
        RegisterState.failure();
      }
    } catch(e){
      RegisterState.failure();
    }
  }
 
}