import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionInitial()) {
    _initializePermissions();
  }

  /// Initialize and check current permission status
  Future<void> _initializePermissions() async {
    emit(PermissionLoading(permissions: state.permissions));

    final Map<Permission, PermissionStatus> permissions = {};

    // Check platform-specific permissions
    if (Platform.isAndroid) {
      permissions[Permission.storage] = await Permission.storage.status;
      permissions[Permission.audio] = await Permission.audio.status;
    } else if (Platform.isIOS) {
      permissions[Permission.mediaLibrary] =
          await Permission.mediaLibrary.status;
    }

    emit(PermissionLoaded(permissions: permissions));
  }

  /// Request storage permission
  Future<void> requestStoragePermission() async {
    if (state is PermissionLoaded) {
      final currentState = state as PermissionLoaded;

      emit(PermissionLoading(permissions: currentState.permissions));

      final status = await Permission.storage.request();
      final updatedPermissions = Map<Permission, PermissionStatus>.from(
        currentState.permissions,
      );
      updatedPermissions[Permission.storage] = status;

      if (status.isGranted) {
        emit(PermissionLoaded(permissions: updatedPermissions));
      } else if (status.isPermanentlyDenied) {
        emit(
          PermissionPermanentlyDenied(
            permissions: updatedPermissions,
            message:
                'Storage permission is permanently denied. Please enable it in app settings.',
          ),
        );
      } else {
        emit(
          PermissionDenied(
            permissions: updatedPermissions,
            message:
                'Storage permission is required to access your music files.',
          ),
        );
      }
    }
  }

  /// Request audio permission (Android)
  Future<void> requestAudioPermission() async {
    if (!Platform.isAndroid) return;

    if (state is PermissionLoaded) {
      final currentState = state as PermissionLoaded;

      emit(PermissionLoading(permissions: currentState.permissions));

      final status = await Permission.audio.request();
      final updatedPermissions = Map<Permission, PermissionStatus>.from(
        currentState.permissions,
      );
      updatedPermissions[Permission.audio] = status;

      if (status.isGranted) {
        emit(PermissionLoaded(permissions: updatedPermissions));
      } else if (status.isPermanentlyDenied) {
        emit(
          PermissionPermanentlyDenied(
            permissions: updatedPermissions,
            message:
                'Audio permission is permanently denied. Please enable it in app settings.',
          ),
        );
      } else {
        emit(
          PermissionDenied(
            permissions: updatedPermissions,
            message: 'Audio permission is required to access your music files.',
          ),
        );
      }
    }
  }

  /// Request media library permission (iOS)
  Future<void> requestMediaLibraryPermission() async {
    if (!Platform.isIOS) return;

    if (state is PermissionLoaded) {
      final currentState = state as PermissionLoaded;

      emit(PermissionLoading(permissions: currentState.permissions));

      final status = await Permission.mediaLibrary.request();
      final updatedPermissions = Map<Permission, PermissionStatus>.from(
        currentState.permissions,
      );
      updatedPermissions[Permission.mediaLibrary] = status;

      if (status.isGranted) {
        emit(PermissionLoaded(permissions: updatedPermissions));
      } else if (status.isPermanentlyDenied) {
        emit(
          PermissionPermanentlyDenied(
            permissions: updatedPermissions,
            message:
                'Media library permission is permanently denied. Please enable it in app settings.',
          ),
        );
      } else {
        emit(
          PermissionDenied(
            permissions: updatedPermissions,
            message:
                'Media library permission is required to access your music files.',
          ),
        );
      }
    }
  }

  /// Request all required permissions based on platform
  Future<void> requestAllPermissions() async {
    if (Platform.isAndroid) {
      await requestStoragePermission();
      await requestAudioPermission();
    } else if (Platform.isIOS) {
      await requestMediaLibraryPermission();
    }
  }

  /// Open app settings
  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Check if all required permissions are granted
  bool get hasRequiredPermissions => state.hasAllRequiredPermissions;
}
