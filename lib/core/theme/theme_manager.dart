import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/storage_keys.dart';
import 'theme_variant.dart';

/// A class that manages theme settings for the app
class ThemeManager {
  // Private constructor for singleton pattern
  ThemeManager._();
  static final ThemeManager _instance = ThemeManager._();

  /// Get the singleton instance
  static ThemeManager get instance => _instance;

  /// Current theme mode
  ThemeMode _themeMode = ThemeMode.system;

  /// Current theme variant
  ThemeVariant _themeVariant = ThemeVariant.rhythm;

  /// Get the current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Get the current theme variant
  ThemeVariant get themeVariant => _themeVariant;

  /// Initialize theme settings from storage
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    // Load theme mode
    final themeModeString = prefs.getString(StorageKeys.themeMode);
    if (themeModeString != null) {
      switch (themeModeString) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        default:
          _themeMode = ThemeMode.system;
      }
    }

    // Load theme variant
    final themeVariantString = prefs.getString(StorageKeys.themeVariant);
    if (themeVariantString != null) {
      _themeVariant = ThemeVariant.fromString(themeVariantString);
    }
  }

  /// Set the theme mode and save to storage
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      StorageKeys.themeMode,
      mode == ThemeMode.light
          ? 'light'
          : mode == ThemeMode.dark
          ? 'dark'
          : 'system',
    );
  }

  /// Set the theme variant and save to storage
  Future<void> setThemeVariant(ThemeVariant variant) async {
    _themeVariant = variant;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.themeVariant, variant.name);
  }

  /// Check if the current theme is dark
  bool isDarkMode(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }
}
