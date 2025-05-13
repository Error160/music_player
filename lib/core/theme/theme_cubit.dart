import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_config.dart';
import 'theme_manager.dart';
import 'theme_state.dart';
import 'theme_variant.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeManager _themeManager = ThemeManager.instance;

  ThemeCubit() : super(const ThemeInitial()) {
    _initializeTheme();
  }

  /// Initialize theme settings
  Future<void> _initializeTheme() async {
    await _themeManager.initialize();
    emit(
      ThemeLoaded(
        themeMode: _themeManager.themeMode,
        themeVariant: _themeManager.themeVariant,
      ),
    );
  }

  /// Get the light theme data
  ThemeData get lightTheme => ThemeConfig.lightTheme(state.themeVariant);

  /// Get the dark theme data
  ThemeData get darkTheme => ThemeConfig.darkTheme(state.themeVariant);

  /// Check if the current theme is dark
  bool isDarkMode(BuildContext context) {
    if (state.themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return state.themeMode == ThemeMode.dark;
  }

  /// Set the theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    await _themeManager.setThemeMode(mode);

    if (state is ThemeLoaded) {
      emit((state as ThemeLoaded).copyWith(themeMode: mode));
    }
  }

  /// Set the theme variant
  Future<void> setThemeVariant(ThemeVariant variant) async {
    await _themeManager.setThemeVariant(variant);

    if (state is ThemeLoaded) {
      emit((state as ThemeLoaded).copyWith(themeVariant: variant));
    }
  }

  /// Toggle between light and dark mode
  Future<void> toggleThemeMode() async {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }
}
