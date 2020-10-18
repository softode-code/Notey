import 'package:Notey/bloc/authentication_bloc/authentication_event.dart';
import 'package:Notey/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable{
  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  
  final UserModel user;
  AuthenticationSuccess({this.user});

  @override
  List<Object> get props => [this.user];
}

class AuthenticationFailure extends AuthenticationState{}