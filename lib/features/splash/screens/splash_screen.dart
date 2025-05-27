import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozole/features/auth/bloc/auth_bloc.dart';
import 'package:ozole/features/auth/bloc/auth_state.dart';
import 'package:ozole/features/auth/bloc/auth_event.dart';
import 'package:ozole/features/auth/repositories/auth_repository.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authRepository = AuthRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (_) => SplashBloc()..add(SplashStarted()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          // Listen to SplashBloc
          BlocListener<SplashBloc, SplashState>(
            listener: (context, splashState) {
              if (splashState is SplashCompleted) {
                // Once splash is done, trigger auth check
                context.read<AuthBloc>().add(AuthCheckRequested());
              }
            },
          ),
          // Listen to AuthBloc
          BlocListener<AuthBloc, AuthState>(
            listener: (context, authState) {
              if (authState is AuthAuthenticated) {
                Navigator.pushReplacementNamed(context, '/home');
              } else if (authState is AuthUnauthenticated) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
        child: _buildSplashUI(theme),
      ),
    );
  }

  Widget _buildSplashUI(ThemeData theme) {
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 20),
            Text(
              "SOP App",
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
