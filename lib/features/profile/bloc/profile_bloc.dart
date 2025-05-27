import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

// Mock user data model (in a real app, this would come from a repository)
class UserProfile {
  final String name;
  final String email;
  final String mobile;
  final String password;

  UserProfile({
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
  });
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    // Mock initial profile data
    UserProfile _profile = UserProfile(
      name: "Alvart Ainstain",
      email: "albart.ainstain@gmail.com",
      mobile: "9526866705",
      password: "********",
    );

    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        // Simulate fetching data (e.g., from an API or database)
        await Future.delayed(Duration(seconds: 1));
        emit(ProfileLoaded(_profile));
      } catch (e) {
        emit(ProfileError("Failed to load profile"));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        // Simulate updating data
        await Future.delayed(Duration(seconds: 1));
        _profile = UserProfile(
          name: event.name,
          email: event.email,
          mobile: event.mobile,
          password: event.password,
        );
        emit(ProfileLoaded(_profile));
      } catch (e) {
        emit(ProfileError("Failed to update profile"));
      }
    });
  }
}
