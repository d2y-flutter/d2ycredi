// ignore_for_file: use_build_context_synchronously

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  // Request single permission
  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  // Request multiple permissions
  Future<Map<Permission, PermissionStatus>> requestPermissions(
      List<Permission> permissions) async {
    return await permissions.request();
  }

  // Check single permission
  Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  // Check multiple permissions
  Future<bool> checkPermissions(List<Permission> permissions) async {
    for (var permission in permissions) {
      final status = await permission.status;
      if (!status.isGranted) return false;
    }
    return true;
  }

  // Camera permission
  Future<bool> requestCameraPermission() async {
    return await requestPermission(Permission.camera);
  }

  // Gallery/Photos permission
  Future<bool> requestPhotosPermission() async {
    return await requestPermission(Permission.photos);
  }

  // Storage permission
  Future<bool> requestStoragePermission() async {
    if (await Permission.storage.isGranted) return true;
    return await requestPermission(Permission.storage);
  }

  // Location permission
  Future<bool> requestLocationPermission() async {
    return await requestPermission(Permission.location);
  }

  // Microphone permission
  Future<bool> requestMicrophonePermission() async {
    return await requestPermission(Permission.microphone);
  }

  // Notification permission
  Future<bool> requestNotificationPermission() async {
    return await requestPermission(Permission.notification);
  }

  // Contacts permission
  Future<bool> requestContactsPermission() async {
    return await requestPermission(Permission.contacts);
  }

  // Calendar permission
  Future<bool> requestCalendarPermission() async {
    // ignore: deprecated_member_use
    return await requestPermission(Permission.calendar);
  }

  // Open app settings
  Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  // Show permission dialog
  Future<bool?> showPermissionDialog(
    BuildContext context, {
    required String title,
    required String message,
    required Permission permission,
  }) async {
    final status = await permission.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context, true);
                await requestPermission(permission);
              },
              child: const Text('Allow'),
            ),
          ],
        ),
      );
    }

    if (status.isPermanentlyDenied) {
      return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text('$message\n\nPlease enable it in app settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context, true);
                await openAppSettings();
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      );
    }

    return false;
  }

  // Request camera with rationale
  Future<bool> requestCameraWithRationale(BuildContext context) async {
    final status = await Permission.camera.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      final result = await showPermissionDialog(
        context,
        title: 'Camera Permission',
        message: 'This app needs camera access to take photos.',
        permission: Permission.camera,
      );
      return result ?? false;
    }

    if (status.isPermanentlyDenied) {
      await showPermissionDialog(
        context,
        title: 'Camera Permission',
        message: 'Camera permission is permanently denied.',
        permission: Permission.camera,
      );
      return false;
    }

    return await requestCameraPermission();
  }

  // Request storage with rationale
  Future<bool> requestStorageWithRationale(BuildContext context) async {
    final status = await Permission.storage.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      final result = await showPermissionDialog(
        context,
        title: 'Storage Permission',
        message: 'This app needs storage access to save files.',
        permission: Permission.storage,
      );
      return result ?? false;
    }

    if (status.isPermanentlyDenied) {
      await showPermissionDialog(
        context,
        title: 'Storage Permission',
        message: 'Storage permission is permanently denied.',
        permission: Permission.storage,
      );
      return false;
    }

    return await requestStoragePermission();
  }

  // Request location with rationale
  Future<bool> requestLocationWithRationale(BuildContext context) async {
    final status = await Permission.location.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      final result = await showPermissionDialog(
        context,
        title: 'Location Permission',
        message: 'This app needs location access.',
        permission: Permission.location,
      );
      return result ?? false;
    }

    if (status.isPermanentlyDenied) {
      await showPermissionDialog(
        context,
        title: 'Location Permission',
        message: 'Location permission is permanently denied.',
        permission: Permission.location,
      );
      return false;
    }

    return await requestLocationPermission();
  }
}