import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// A static class that holds all app configuration
class AppConfig {
  // Private constructor to prevent instantiation
  AppConfig._();

  // App information
  static late String appName;
  static late String appVersion;
  static late String packageName;
  static late String buildNumber;

  // Default configurations
  static ThemeMode defaultThemeMode = ThemeMode.system;
  static Locale defaultLocale = const Locale('en', 'US');

  // Supported languages
  static final List<Locale> supportedLocales = [
    const Locale('en', 'US'), // English
    const Locale('es', 'ES'), // Spanish
    const Locale('fr', 'FR'), // French
    const Locale('ar', 'SA'), // Arabic
  ];

  // Theme configurations
  static final Map<String, ThemeData> lightThemes = {
    'default': ThemeData.light(useMaterial3: true),
    'blue': ThemeData.light(useMaterial3: true).copyWith(
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    ),
    // Add more theme variants
  };

  static final Map<String, ThemeData> darkThemes = {
    'default': ThemeData.dark(useMaterial3: true),
    'blue': ThemeData.dark(useMaterial3: true).copyWith(
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
    ),
    // Add more theme variants
  };

  // Storage keys
  static const String themeKey = 'app_theme';
  static const String themeVariantKey = 'app_theme_variant';
  static const String localeKey = 'app_locale';

  // Initialize the config
  static Future<void> initialize() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    appVersion = packageInfo.version;
    packageName = packageInfo.packageName;
    buildNumber = packageInfo.buildNumber;
  }
}
