import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YLoading extends StatelessWidget {
  final Color? color;
  final double size;
  final double strokeWidth;
  final String? message;
  final bool adaptive;

  const D2YLoading({
    super.key,
    this.color,
    this.size = AppConstants.iconLG,
    this.strokeWidth = 3.0,
    this.message,
    this.adaptive = true,
  });

  @override
  Widget build(BuildContext context) {
    final loadingColor = color ?? AppColor.primary;

    Widget loadingIndicator;
    if (adaptive && Platform.isIOS) {
      loadingIndicator = CupertinoActivityIndicator(
        color: loadingColor,
        radius: size / 2,
      );
    } else {
      loadingIndicator = SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
        ),
      );
    }

    if (message != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loadingIndicator,
          const SizedBox(height: AppConstants.spaceMD),
          Text(
            message!,
            style: TextStyle(
              color: AppColor.textSecondary,
              fontSize: AppConstants.fontMD,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return loadingIndicator;
  }

  // Center loading with optional message
  static Widget center({
    Color? color,
    double size = AppConstants.iconLG,
    String? message,
    bool adaptive = true,
  }) {
    return Center(
      child: D2YLoading(
        color: color,
        size: size,
        message: message,
        adaptive: adaptive,
      ),
    );
  }

  // Overlay loading (full screen)
  static Widget overlay({
    Color? backgroundColor,
    Color? indicatorColor,
    double size = AppConstants.iconLG,
    String? message,
    bool adaptive = true,
  }) {
    return Container(
      color: backgroundColor ?? AppColor.overlay,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(AppConstants.paddingXXL),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          ),
          child: D2YLoading(
            color: indicatorColor,
            size: size,
            message: message,
            adaptive: adaptive,
          ),
        ),
      ),
    );
  }

  // Show loading dialog
  static void show(
    BuildContext context, {
    String? message,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      // ignore: deprecated_member_use
      builder: (context) => WillPopScope(
        onWillPop: () async => barrierDismissible,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(AppConstants.paddingXXL),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(AppConstants.radiusLG),
            ),
            child: D2YLoading(message: message),
          ),
        ),
      ),
    );
  }

  // Hide loading dialog
  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

// Linear Progress Indicator
class D2YLinearLoading extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final double? value;
  final double height;
  final BorderRadius? borderRadius;

  const D2YLinearLoading({
    super.key,
    this.color,
    this.backgroundColor,
    this.value,
    this.height = 4.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.radiusSM),
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor ?? AppColor.grey200,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColor.primary,
          ),
        ),
      ),
    );
  }
}