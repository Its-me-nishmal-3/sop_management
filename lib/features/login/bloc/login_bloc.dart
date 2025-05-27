import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozole/features/login/repositories/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;
  String? _phoneNumber; // Store phone number for OTP verification

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<SendPhoneNumber>(_onSendPhoneNumber);
    on<CreatePassword>(_onCreatePassword);
    on<VerifyOtp>(_onVerifyOtp);
    on<ResendOtp>(_onResendOtp);
  }

  Future<void> _onSendPhoneNumber(
      SendPhoneNumber event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      if (event.phone.length != 10 || !RegExp(r'^\d+$').hasMatch(event.phone)) {
        emit(LoginFailure(error: "Please enter a valid 10-digit phone number"));
        return;
      }

      await repository.sendPhone(event.phone);
      _phoneNumber = event.phone; // Store phone number
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> _onCreatePassword(
      CreatePassword event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      if (event.password.length < 8) {
        emit(
            LoginFailure(error: "Password must be at least 8 characters long"));
        return;
      }

      await repository.createPassword(event.password);
      emit(PasswordSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtp event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      if (event.otp.length != 4 || !RegExp(r'^\d+$').hasMatch(event.otp)) {
        emit(LoginFailure(error: "Please enter a valid 4-digit OTP"));
        return;
      }

      await repository.verifyOtp(event.otp);
      emit(OtpSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> _onResendOtp(ResendOtp event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      if (_phoneNumber == null) {
        emit(LoginFailure(error: "Phone number not found. Please try again."));
        return;
      }

      await repository.sendPhone(_phoneNumber!);
      emit(OtpResent());
    } catch (e) {
      emit(LoginFailure(error: "Failed to resend OTP: ${e.toString()}"));
    }
  }
}
