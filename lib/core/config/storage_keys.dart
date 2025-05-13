/// A static class that holds all storage keys used in the app
class StorageKeys {
  // Private constructor to prevent instantiation
  StorageKeys._();

  // App settings
  static const String themeMode = 'app_theme_mode';
  static const String themeVariant = 'app_theme_variant';
  static const String locale = 'app_locale';
  static const String localeLanguageCode = 'app_locale_language_code';
  static const String localeCountryCode = 'app_locale_country_code';

  // User preferences
  static const String lastPlayedTrack = 'last_played_track';
  static const String volume = 'player_volume';
  static const String equalizer = 'equalizer_settings';
  static const String playbackSpeed = 'playback_speed';

  // Playlist related
  static const String recentPlaylists = 'recent_playlists';
  static const String favoriteTracksKey = 'favorite_tracks';

  // Cache related
  static const String cacheDuration = 'cache_duration';
  static const String maxCacheSize = 'max_cache_size';
}
