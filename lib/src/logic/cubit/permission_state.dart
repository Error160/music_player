part of 'permission_cubit.dart';

@immutable
sealed class PermissionState {
  final Map<Permission, PermissionStatus> permissions;

  const PermissionState({required this.permissions});

  bool get hasStoragePermission =>
      permissions[Permission.storage]?.isGranted ?? false;

  bool get hasAudioPermission =>
      permissions[Permission.audio]?.isGranted ?? false;

  bool get hasMediaLibraryPermission =>
      permissions[Permission.mediaLibrary]?.isGranted ?? false;

  bool get hasAllRequiredPermissions =>
      hasStoragePermission &&
      (Platform.isIOS ? hasMediaLibraryPermission : hasAudioPermission);
}

class PermissionInitial extends PermissionState {
  PermissionInitial() : super(permissions: {});
}

class PermissionLoading extends PermissionState {
  const PermissionLoading({required super.permissions});
}

class PermissionLoaded extends PermissionState {
  const PermissionLoaded({required super.permissions});

  PermissionLoaded copyWith({Map<Permission, PermissionStatus>? permissions}) {
    return PermissionLoaded(permissions: permissions ?? this.permissions);
  }
}

class PermissionDenied extends PermissionState {
  final String message;

  const PermissionDenied({required super.permissions, required this.message});
}

class PermissionPermanentlyDenied extends PermissionState {
  final String message;

  const PermissionPermanentlyDenied({
    required super.permissions,
    required this.message,
  });
}
