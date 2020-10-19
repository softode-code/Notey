import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable{
   @override
  List<Object> get props => [];
}

class RegisterEmailChange extends RegisterEvent{

 final String email;  
  RegisterEmailChange({this.email});

  @override
  List<Object> get props => [this.email];
}

class RegisterPasswordChange extends RegisterEvent {
  final String password;
  RegisterPasswordChange({this.password});

  @override
  List<Object> get props => [this.password];
}

class RegisterWithCredentialsPressed extends RegisterEvent {
  final String email;
  final String password;

  RegisterWithCredentialsPressed({this.email, this.password});

  @override
  List<Object> get props => [this.email, this.password];
}

class RegisterWithGooglePressed extends RegisterEvent{}