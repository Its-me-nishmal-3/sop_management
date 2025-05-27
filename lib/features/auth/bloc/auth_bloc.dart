import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozole/features/auth/bloc/auth_event.dart';
import 'package:ozole/features/auth/bloc/auth_state.dart';
import 'package:ozole/features/auth/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final isSignedIn = await authRepository.isSignedIn();

        if (isSignedIn) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        // Handle errors (network, storage issues etc.)
        emit(AuthFailure(errorMessage: e.toString()));
      }
    });
  }
}
