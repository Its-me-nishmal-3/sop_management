class LoginRepository {
  Future<void> sendPhone(String phone) async {
    // TODO: connect to your backend API
    await Future.delayed(const Duration(seconds: 2));
    if (phone != '7994107442') {
      throw Exception('Phone number not found');
    }
  }

  Future<void> createPassword(String phone) async {
    // TODO: connect to your backend API
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> verifyOtp(String otp) async {
    // Implement OTP verification logic (e.g., API call)
    await Future.delayed(const Duration(seconds: 1)); // Mock delay
    if (otp != "1234") {
      // Mock validation
      throw Exception("Invalid OTP");
    }
  }
}
