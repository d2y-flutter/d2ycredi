import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';
import 'd2y_button.dart';

class D2YNoData extends StatelessWidget {
  final String? title;
  final String? message;
  final String? imagePath;
  final IconData? icon;
  final double imageSize;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? customWidget;

  const D2YNoData({
    super.key,
    this.title,
    this.message,
    this.imagePath,
    this.icon,
    this.imageSize = 200.0,
    this.actionLabel,
    this.onAction,
    this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image or Icon
            if (customWidget != null)
              customWidget!
            else if (imagePath != null)
              _buildImage()
            else if (icon != null)
              _buildIcon()
            else
              _buildDefaultIcon(),

            const SizedBox(height: AppConstants.spaceXL),

            // Title
            if (title != null)
              Text(
                title!,
                style: AppTextStyles.h5.copyWith(
                  color: AppColor.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

            // Message
            if (message != null) ...[
              const SizedBox(height: AppConstants.spaceMD),
              Text(
                message!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColor.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Action Button
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppConstants.spaceXXL),
              D2YButton(
                label: actionLabel!,
                onPressed: onAction!,
                type: D2YButtonType.outlined,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath!.endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath!,
        width: imageSize,
        height: imageSize,
        colorFilter: const ColorFilter.mode(
          AppColor.grey400,
          BlendMode.srcIn,
        ),
      );
    }
    return Image.asset(
      imagePath!,
      width: imageSize,
      height: imageSize,
      color: AppColor.grey400,
    );
  }

  Widget _buildIcon() {
    return Icon(
      icon,
      size: imageSize,
      color: AppColor.grey400,
    );
  }

  Widget _buildDefaultIcon() {
    return Icon(
      Icons.inbox_outlined,
      size: imageSize,
      color: AppColor.grey400,
    );
  }

  // Predefined variants
  static Widget empty({
    String? title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return D2YNoData(
      icon: Icons.inbox_outlined,
      title: title ?? 'No Data',
      message: message ?? 'There is no data to display',
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static Widget search({
    String? title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return D2YNoData(
      icon: Icons.search_off_outlined,
      title: title ?? 'No Results',
      message: message ?? 'We couldn\'t find any results',
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static Widget error({
    String? title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return D2YNoData(
      icon: Icons.error_outline,
      title: title ?? 'Something Went Wrong',
      message: message ?? 'An error occurred. Please try again.',
      actionLabel: actionLabel ?? 'Retry',
      onAction: onAction,
    );
  }

  static Widget network({
    String? title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return D2YNoData(
      icon: Icons.wifi_off_outlined,
      title: title ?? 'No Connection',
      message: message ?? 'Please check your internet connection',
      actionLabel: actionLabel ?? 'Retry',
      onAction: onAction,
    );
  }
}