part of 'app_cubit.dart';

@immutable
sealed class AppState {
  final Locale locale;
  final String appName;
  final String appVersion;

  const AppState({
    required this.locale,
    required this.appName,
    required this.appVersion,
  });
}

final class AppInitial extends AppState {
  const AppInitial()
    : super(
        locale: const Locale('en', 'US'),
        appName: 'Harmony',
        appVersion: '1.0.0',
      );
}

final class AppLoaded extends AppState {
  const AppLoaded({
    required super.locale,
    required super.appName,
    required super.appVersion,
  });

  AppLoaded copyWith({Locale? locale, String? appName, String? appVersion}) {
    return AppLoaded(
      locale: locale ?? this.locale,
      appName: appName ?? this.appName,
      appVersion: appVersion ?? this.appVersion,
    );
  }
}
