import 'package:ozole/features/profile/bloc/profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;

  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
