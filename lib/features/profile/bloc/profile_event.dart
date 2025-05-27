abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String name;
  final String email;
  final String mobile;
  final String password;

  UpdateProfile({
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
  });
}
