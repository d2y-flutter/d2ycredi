import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../config/app_color.dart';
import '../config/app_config.dart';
import '../services/permission_service.dart';
import 'd2y_bottom_sheet.dart';

class D2YImagePicker {
  static final D2YImagePicker _instance = D2YImagePicker._internal();
  factory D2YImagePicker() => _instance;
  D2YImagePicker._internal();

  final ImagePicker _picker = ImagePicker();
  final PermissionService _permissionService = PermissionService();

  // Pick single image
  Future<File?> pickImage({
    required BuildContext context,
    ImageSource? source,
    bool enableCrop = true,
    CropAspectRatio? aspectRatio,
    bool compress = true,
    int quality = AppConfig.maxImageQuality,
    int? maxWidth = AppConfig.maxImageWidth,
    int? maxHeight = AppConfig.maxImageHeight,
  }) async {
    try {
      // Show source selection if not specified
      final ImageSource? selectedSource = source ?? await _showSourceSelection(context);
      if (selectedSource == null) return null;

      // Check permissions
      final hasPermission = await _checkPermission(selectedSource);
      if (!hasPermission) {
        if (context.mounted) {
          await _showPermissionDenied(context, selectedSource);
        }
        return null;
      }

      // Pick image
      final XFile? pickedFile = await _picker.pickImage(
        source: selectedSource,
        maxWidth: maxWidth?.toDouble(),
        maxHeight: maxHeight?.toDouble(),
        imageQuality: quality,
      );

      if (pickedFile == null) return null;

      File imageFile = File(pickedFile.path);

      // Crop image
      if (enableCrop) {
        final croppedFile = await _cropImage(
          imageFile.path,
          aspectRatio: aspectRatio,
        );
        if (croppedFile != null) {
          imageFile = File(croppedFile.path);
        }
      }

      // Compress image
      if (compress) {
        final compressedFile = await _compressImage(
          imageFile,
          quality: quality,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        );
        if (compressedFile != null) {
          imageFile = compressedFile;
        }
      }

      return imageFile;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  // Pick multiple images
  Future<List<File>> pickMultipleImages({
    required BuildContext context,
    int maxImages = 10,
    bool compress = true,
    int quality = AppConfig.maxImageQuality,
  }) async {
    try {
      // Check permission
      final hasPermission = await _checkPermission(ImageSource.gallery);
      if (!hasPermission) {
        if (context.mounted) {
          await _showPermissionDenied(context, ImageSource.gallery);
        }
        return [];
      }

      // Pick images
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        maxWidth: AppConfig.maxImageWidth.toDouble(),
        maxHeight: AppConfig.maxImageHeight.toDouble(),
        imageQuality: quality,
      );

      if (pickedFiles.isEmpty) return [];

      // Limit number of images
      final limitedFiles = pickedFiles.take(maxImages).toList();

      List<File> imageFiles = [];
      for (var file in limitedFiles) {
        File imageFile = File(file.path);

        // Compress each image
        if (compress) {
          final compressedFile = await _compressImage(
            imageFile,
            quality: quality,
          );
          if (compressedFile != null) {
            imageFile = compressedFile;
          }
        }

        imageFiles.add(imageFile);
      }

      return imageFiles;
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
      return [];
    }
  }

  // Take photo
  Future<File?> takePhoto({
    required BuildContext context,
    bool enableCrop = true,
    CropAspectRatio? aspectRatio,
    bool compress = true,
    int quality = AppConfig.maxImageQuality,
  }) async {
    return await pickImage(
      context: context,
      source: ImageSource.camera,
      enableCrop: enableCrop,
      aspectRatio: aspectRatio,
      compress: compress,
      quality: quality,
    );
  }

  // Pick from gallery
  Future<File?> pickFromGallery({
    required BuildContext context,
    bool enableCrop = true,
    CropAspectRatio? aspectRatio,
    bool compress = true,
    int quality = AppConfig.maxImageQuality,
  }) async {
    return await pickImage(
      context: context,
      source: ImageSource.gallery,
      enableCrop: enableCrop,
      aspectRatio: aspectRatio,
      compress: compress,
      quality: quality,
    );
  }

  // Show source selection bottom sheet
  Future<ImageSource?> _showSourceSelection(BuildContext context) async {
    return await D2YBottomSheet.show<ImageSource>(
      context: context,
      title: 'Select Image Source',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt_outlined, color: AppColor.primary),
            title: const Text('Camera'),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined, color: AppColor.primary),
            title: const Text('Gallery'),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  // Check permission based on source
  Future<bool> _checkPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      return await _permissionService.requestCameraPermission();
    } else {
      return await _permissionService.requestPhotosPermission();
    }
  }

  // Show permission denied dialog
  Future<void> _showPermissionDenied(
    BuildContext context,
    ImageSource source,
  ) async {
    final permissionName = source == ImageSource.camera ? 'Camera' : 'Gallery';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$permissionName Permission Required'),
        content: Text(
          'Please grant $permissionName permission to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _permissionService.openAppSettings();
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  // Crop image
  Future<CroppedFile?> _cropImage(
    String imagePath, {
    CropAspectRatio? aspectRatio,
  }) async {
    try {
      return await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColor.primary,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.black,
            activeControlsWidgetColor: AppColor.primary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: aspectRatio != null,
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: aspectRatio != null,
          ),
        ],
      );
    } catch (e) {
      debugPrint('Error cropping image: $e');
      return null;
    }
  }

  // Compress image
  Future<File?> _compressImage(
    File file, {
    int quality = AppConfig.maxImageQuality,
    int? maxWidth,
    int? maxHeight,
  }) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
        minWidth: maxWidth ?? AppConfig.maxImageWidth,
        minHeight: maxHeight ?? AppConfig.maxImageHeight,
      );

      if (result != null) {
        return File(result.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return null;
    }
  }

  // Get file size in MB
  static Future<double> getFileSize(File file) async {
    final bytes = await file.length();
    return bytes / (1024 * 1024);
  }

  // Validate file size
  static Future<bool> validateFileSize(
    File file, {
    double maxSizeInMB = AppConfig.maxImageSizeInMB,
  }) async {
    final size = await getFileSize(file);
    return size <= maxSizeInMB;
  }
}