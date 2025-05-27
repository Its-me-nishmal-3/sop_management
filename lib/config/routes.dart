import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozole/features/home/screens/home_screen.dart';
import 'package:ozole/features/login/bloc/login_bloc.dart';
import 'package:ozole/features/login/repositories/login_repository.dart';
import 'package:ozole/features/login/screens/login_screen.dart';
import 'package:ozole/features/login/screens/otp_screen.dart';
import 'package:ozole/features/login/screens/password_screen.dart';
import 'package:ozole/features/profile/screens/edit_profile_screen.dart';
import 'package:ozole/features/splash/screens/splash_screen.dart';

final loginRepository = LoginRepository();
final loginBloc = LoginBloc(loginRepository);

final Map<String, WidgetBuilder> appRoutes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  PasswordScreen.routeName: (context) => BlocProvider.value(
        value: loginBloc,
        child: const PasswordScreen(),
      ),
  LoginScreen.routeName: (context) => BlocProvider.value(
        value: loginBloc,
        child: const LoginScreen(),
      ),
  OtpScreen.routeName: (context) => BlocProvider.value(
        value: loginBloc,
        child: OtpScreen(
          phoneNumber: ModalRoute.of(context)?.settings.arguments as String? ??
              '9526866705', // Fallback phone number if arguments are missing
        ),
      ),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
};
