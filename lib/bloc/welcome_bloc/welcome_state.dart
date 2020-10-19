import 'package:equatable/equatable.dart';

abstract class WelcomeState extends Equatable{
  @override
  List<Object> get props => [];
}

class WelcomeInitial extends WelcomeState{}

class WelcomeLoading extends WelcomeState{}

class WelcomeSuccess extends WelcomeState{}

class WelcomeFailure extends WelcomeState{}