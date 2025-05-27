import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozole/core/constants/app_colors.dart';
import 'package:ozole/core/themes/app_theme.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widgets/phone_input_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();

    return Theme(
      data: AppTheme.lightTheme, // Applying the light theme
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushNamed(context, '/password');
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Center(
                      child: Text(
                    "User Mobile Number",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge, // Using bodyMedium for secondary text
                  )),
                  const SizedBox(height: 40),
                  Text(
                    "Enter Registered\nMobile number?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors
                          .primary, // Using primary color from AppColors
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PhoneInputField(controller: phoneController),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final phone = phoneController.text.trim();
                      context.read<LoginBloc>().add(SendPhoneNumber(phone));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ).merge(Theme.of(context)
                        .elevatedButtonTheme
                        .style), // Merging with theme style
                    child: state is LoginLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Next",
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
