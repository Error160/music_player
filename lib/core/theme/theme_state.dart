import 'package:flutter/material.dart';
import 'theme_variant.dart';

abstract class ThemeState {
  final ThemeMode themeMode;
  final ThemeVariant themeVariant;

  const ThemeState({required this.themeMode, required this.themeVariant});
}

class ThemeInitial extends ThemeState {
  const ThemeInitial()
    : super(themeMode: ThemeMode.system, themeVariant: ThemeVariant.rhythm);
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded({required super.themeMode, required super.themeVariant});

  ThemeLoaded copyWith({ThemeMode? themeMode, ThemeVariant? themeVariant}) {
    return ThemeLoaded(
      themeMode: themeMode ?? this.themeMode,
      themeVariant: themeVariant ?? this.themeVariant,
    );
  }
}
