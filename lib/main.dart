import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/theme/theme_state.dart';
import 'package:harmony/src/logic/cubit/permission_cubit.dart';
import 'core/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize theme cubit
  final themeCubit = ThemeCubit();
  await Future.delayed(
    const Duration(milliseconds: 100),
  ); // Allow time for theme to load

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => themeCubit),
        BlocProvider(create: (_) => PermissionCubit()),
        // Add other providers here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeCubit = context.read<ThemeCubit>();

        return MaterialApp(
          title: 'Rhythm Music Player',
          theme: themeCubit.lightTheme,
          darkTheme: themeCubit.darkTheme,
          themeMode: state.themeMode,
          // Add your app routes and home screen here
        );
      },
    );
  }
}
