import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/src/logic/cubit/permission_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions')),
      body: BlocConsumer<PermissionCubit, PermissionState>(
        listener: (context, state) {
          if (state is PermissionDenied) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is PermissionPermanentlyDenied) {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Permission Required'),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<PermissionCubit>().openAppSettings();
                        },
                        child: const Text('Open Settings'),
                      ),
                    ],
                  ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Required Permissions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildPermissionTile(
                  context,
                  title: 'Storage',
                  subtitle: 'Access to read music files',
                  isGranted: state.hasStoragePermission,
                  onRequest:
                      () =>
                          context
                              .read<PermissionCubit>()
                              .requestStoragePermission(),
                ),
                if (state is PermissionLoaded &&
                    state.permissions.containsKey(Permission.audio))
                  _buildPermissionTile(
                    context,
                    title: 'Audio',
                    subtitle: 'Access to audio files',
                    isGranted: state.hasAudioPermission,
                    onRequest:
                        () =>
                            context
                                .read<PermissionCubit>()
                                .requestAudioPermission(),
                  ),
                if (state is PermissionLoaded &&
                    state.permissions.containsKey(Permission.mediaLibrary))
                  _buildPermissionTile(
                    context,
                    title: 'Media Library',
                    subtitle: 'Access to music library',
                    isGranted: state.hasMediaLibraryPermission,
                    onRequest:
                        () =>
                            context
                                .read<PermissionCubit>()
                                .requestMediaLibraryPermission(),
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        () =>
                            context
                                .read<PermissionCubit>()
                                .requestAllPermissions(),
                    child: const Text('Request All Permissions'),
                  ),
                ),
                if (state is PermissionLoading)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPermissionTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isGranted,
    required VoidCallback onRequest,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing:
          isGranted
              ? const Icon(Icons.check_circle, color: Colors.green)
              : TextButton(onPressed: onRequest, child: const Text('Request')),
    );
  }
}
