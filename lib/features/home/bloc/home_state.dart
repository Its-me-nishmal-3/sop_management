part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

class HomeLoaded extends HomeState {
  final String message;

  HomeLoaded({required this.message});

  @override
  List<Object> get props => [message];
}
