import 'package:Notey/bloc/welcome_bloc/welcome_event.dart';
import 'package:Notey/bloc/welcome_bloc/welcome_state.dart';
import 'package:Notey/services/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState>{

  final AuthService _authService;

  WelcomeBloc({AuthService authService}) :
  _authService = authService,
   super(WelcomeInitial());


  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
   if(event is WelcomeSignInWithGooglePressed){
     yield WelcomeLoading();
     try {
       final result =  await _authService.googleSignIn();
       if(result != null ){
         yield WelcomeSuccess();
       } else {
         yield WelcomeFailure();
       }
     } catch (e){
       yield WelcomeFailure();
     }
   }
  }

}