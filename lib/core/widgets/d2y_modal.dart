import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../config/app_color.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';
import 'd2y_button.dart';

class D2YModal {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool barrierDismissible = true,
    bool adaptive = true,
  }) async {
    if (adaptive && Platform.isIOS) {
      return await showCupertinoDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: child,
        ),
      );
    }

    return await showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                Text(
                  title,
                  style: AppTextStyles.h5,
                ),
                const SizedBox(height: AppConstants.spaceLG),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }

  // Confirm dialog
  static Future<bool?> confirm({
    required BuildContext context,
    String? title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
    bool isDangerous = false,
    bool adaptive = true,
  }) async {
    if (adaptive && Platform.isIOS) {
      return await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context, false),
              child: Text(cancelText, style: TextStyle(color: AppColor.error)),
            ),
            CupertinoDialogAction(
              isDestructiveAction: isDangerous,
              onPressed: () => Navigator.pop(context, true),
              child: Text(confirmText),
            ),
          ],
        ),
      );
    }

    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: confirmColor ?? 
                  (isDangerous ? AppColor.error : AppColor.primary),
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // Alert dialog
  static Future<void> alert({
    required BuildContext context,
    String? title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    bool adaptive = true,
  }) async {
    if (adaptive && Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
                onPressed?.call();
              },
              child: Text(buttonText),
            ),
          ],
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onPressed?.call();
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  // Success dialog
  static Future<void> success({
    required BuildContext context,
    String? title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingXXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColor.successSurface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: AppColor.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppConstants.spaceLG),
              if (title != null) ...[
                Text(
                  title,
                  style: AppTextStyles.h5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.spaceMD),
              ],
              Text(
                message,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceXL),
              D2YButton(
                label: buttonText,
                onPressed: () {
                  Navigator.pop(context);
                  onPressed?.call();
                },
                fullWidth: true,
                backgroundColor: AppColor.success,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Error dialog
  static Future<void> error({
    required BuildContext context,
    String? title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingXXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColor.errorSurface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: AppColor.error,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppConstants.spaceLG),
              if (title != null) ...[
                Text(
                  title,
                  style: AppTextStyles.h5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.spaceMD),
              ],
              Text(
                message,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceXL),
              D2YButton(
                label: buttonText,
                onPressed: () {
                  Navigator.pop(context);
                  onPressed?.call();
                },
                fullWidth: true,
                backgroundColor: AppColor.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Loading dialog
  static Future<void> showLoading({
    required BuildContext context,
    String? message,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(AppConstants.paddingXXL),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(AppConstants.radiusLG),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (message != null) ...[
                  const SizedBox(height: AppConstants.spaceLG),
                  Text(
                    message,
                    style: AppTextStyles.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hide loading dialog
  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Custom dialog with actions
  static Future<T?> showWithActions<T>({
    required BuildContext context,
    String? title,
    required String message,
    required List<D2YModalAction> actions,
  }) async {
    return await showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        ),
        actions: actions.map((action) {
          return TextButton(
            onPressed: () {
              Navigator.pop(context, action.value);
              action.onPressed?.call();
            },
            style: TextButton.styleFrom(
              foregroundColor: action.color ?? AppColor.primary,
            ),
            child: Text(action.label),
          );
        }).toList(),
      ),
    );
  }

  // Full screen dialog
  static Future<T?> fullScreen<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    List<Widget>? actions,
  }) async {
    return await Navigator.push<T>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: title != null ? Text(title) : null,
            actions: actions,
          ),
          body: child,
        ),
      ),
    );
  }
}

class D2YModalAction {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final dynamic value;

  D2YModalAction({
    required this.label,
    this.onPressed,
    this.color,
    this.value,
  });
}