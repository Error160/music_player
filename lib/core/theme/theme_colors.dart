import 'package:flutter/material.dart';
import 'theme_variant.dart';

/// A class that defines color schemes for different theme variants
class ThemeColors {
  // Private constructor to prevent instantiation
  ThemeColors._();

  /// Get the primary color for a theme variant
  static Color getPrimaryColor(ThemeVariant variant) {
    switch (variant) {
      case ThemeVariant.rhythm:
        return const Color.fromRGBO(147, 51, 234, 1); // Purple (hue 262.1)
      case ThemeVariant.azure:
        return const Color.fromRGBO(59, 130, 246, 1); // Blue (hue 217)
      case ThemeVariant.emerald:
        return const Color.fromRGBO(16, 185, 129, 1); // Green (hue 160)
      case ThemeVariant.ruby:
        return const Color.fromRGBO(239, 68, 68, 1); // Red (hue 0)
      case ThemeVariant.amber:
        return const Color.fromRGBO(245, 158, 11, 1); // Orange (hue 38)
    }
  }

  /// Generate a complete color scheme for light mode
  static ColorScheme lightColorScheme(ThemeVariant variant) {
    final primaryColor = getPrimaryColor(variant);

    return ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: const Color(0xFFF9FAFB), // Near white with blue tint
      secondary: const Color(0xFFF3F4F6), // Very light gray with blue tint
      onSecondary: const Color(0xFF1F2937), // Very dark gray with blue tint
      error: const Color(0xFFEF4444), // Bright red
      onError: const Color(0xFFFAFAFA), // Near white
      surface: const Color(0xFFFFFFFF), // Pure white
      onSurface: const Color(0xFF111827), // Near black with slight blue tint
    );
  }

  /// Generate a complete color scheme for dark mode
  static ColorScheme darkColorScheme(ThemeVariant variant) {
    final primaryColor = getPrimaryColor(variant);

    return ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: const Color(0xFFFAFAFA), // Near white
      secondary: const Color(0xFF374151), // Dark gray with blue tint
      onSecondary: const Color(0xFFFAFAFA), // Near white
      error: const Color(0xFF991B1B), // Dark red
      onError: const Color(0xFFFAFAFA), // Near white
      surface: const Color(0xFF111827), // Near black with blue tint
      onSurface: const Color(0xFFFAFAFA), // Near white
    );
  }

  /// Generate a gradient for the current theme
  static List<Color> getGradient(ThemeVariant variant, bool isDark) {
    final primaryColor = getPrimaryColor(variant);
    final backgroundColor =
        isDark ? const Color(0xFF111827) : const Color(0xFFFFFFFF);

    return [
      primaryColor.withValues(alpha: isDark ? 0.1 : 0.2),
      backgroundColor,
    ];
  }
}
