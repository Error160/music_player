/// Defines the available theme variants in the app
enum ThemeVariant {
  /// Default purple theme
  rhythm,

  /// Blue theme variant
  azure,

  /// Green theme variant
  emerald,

  /// Red theme variant
  ruby,

  /// Orange theme variant
  amber;

  /// Get the display name of the theme variant
  String get displayName {
    switch (this) {
      case ThemeVariant.rhythm:
        return 'Rhythm';
      case ThemeVariant.azure:
        return 'Azure';
      case ThemeVariant.emerald:
        return 'Emerald';
      case ThemeVariant.ruby:
        return 'Ruby';
      case ThemeVariant.amber:
        return 'Amber';
    }
  }

  /// Get a theme variant from its string representation
  static ThemeVariant fromString(String value) {
    return ThemeVariant.values.firstWhere(
      (variant) => variant.name == value,
      orElse: () => ThemeVariant.rhythm,
    );
  }
}
