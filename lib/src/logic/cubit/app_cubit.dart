import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:harmony/core/config/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:harmony/core/config/app_config.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppInitial()) {
    _initializeApp();
  }

  /// Initialize the app with saved preferences and package info
  Future<void> _initializeApp() async {
    // Initialize app config
    await AppConfig.initialize();

    // Get saved preferences
    final prefs = await SharedPreferences.getInstance();

    // Get locale preference
    final String? languageCode = prefs.getString(
      StorageKeys.localeLanguageCode,
    );
    final String? countryCode = prefs.getString(StorageKeys.localeCountryCode);

    Locale locale = AppConfig.defaultLocale; // Default
    if (languageCode != null) {
      locale = Locale(languageCode, countryCode);
    }

    // Emit loaded state
    emit(
      AppLoaded(
        locale: locale,
        appName: AppConfig.appName,
        appVersion: AppConfig.appVersion,
      ),
    );
  }

  /// Change the app language
  Future<void> changeLanguage(Locale locale) async {
    if (state is AppLoaded) {
      final currentState = state as AppLoaded;

      // Save preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        StorageKeys.localeLanguageCode,
        locale.languageCode,
      );
      if (locale.countryCode != null) {
        await prefs.setString(
          StorageKeys.localeCountryCode,
          locale.countryCode!,
        );
      }

      // Update state
      emit(currentState.copyWith(locale: locale));
    }
  }

  /// Get app information
  Map<String, String> getAppInfo() {
    return {
      'name': AppConfig.appName,
      'version': AppConfig.appVersion,
      'packageName': AppConfig.packageName,
      'buildNumber': AppConfig.buildNumber,
      'language': '${state.locale.languageCode}_${state.locale.countryCode}',
    };
  }
}
