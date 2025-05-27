import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozole/core/themes/app_theme.dart';
import 'package:ozole/core/themes/theme_cubit.dart';
import 'package:ozole/config/routes.dart';
import 'package:ozole/features/splash/screens/splash_screen.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}

/// Custom [BlocObserver] to monitor all bloc/cubit changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp(
          title: 'SOP App',
          theme: theme,
          routes: appRoutes, // comes from routes.dart
          initialRoute: SplashScreen.routeName,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
