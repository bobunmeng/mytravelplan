import 'package:equatable/equatable.dart';

class AuthState extends Equatable {

  @override
  List<Object> get props => [];
}

class AuthInitState extends AuthState {}

class AuthLoginValidationState extends AuthState {
  final String usernameError;
  final String passwordError;

  @override
  List<Object> get props => [usernameError, passwordError];

  AuthLoginValidationState({this.usernameError = '', this.passwordError: ''});
}

class AuthSuccessState extends AuthState {
  final String message;

  @override
  List<Object> get props => [message];

  AuthSuccessState({this.message =  ''});
}