import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Define the AuthCheckRequested event
class AuthCheckRequested extends AuthEvent {}
