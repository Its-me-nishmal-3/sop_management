import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozole/features/home/screens/home_screen.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(HomeLoaded(message: "Welcome to Home!"));
      } catch (_) {
        emit(HomeError(message: "Failed to load home."));
      }
    });
  }
}
