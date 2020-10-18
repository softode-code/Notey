import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
   @override
  List<Object> get props => [];
}

class LoginEmailChange extends LoginEvent{

 final String email;  
  LoginEmailChange({this.email});

  @override
  List<Object> get props => [this.email];
}

class LoginPasswordChange extends LoginEvent {
  final String password;
  LoginPasswordChange({this.password});

  @override
  List<Object> get props => [this.password];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({this.email, this.password});

  @override
  List<Object> get props => [this.email, this.password];
}

class LoginWithGooglePressed extends LoginEvent{}