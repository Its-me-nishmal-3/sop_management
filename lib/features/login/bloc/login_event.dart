abstract class LoginEvent {}

class SendPhoneNumber extends LoginEvent {
  final String phone;
  SendPhoneNumber(this.phone);
}

class CreatePassword extends LoginEvent {
  final String password;
  CreatePassword(this.password);
}

class VerifyOtp extends LoginEvent {
  final String otp;
  VerifyOtp(this.otp);
}

class ResendOtp extends LoginEvent {}
