import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';

class D2YBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
    double? maxHeight,
    Color? backgroundColor,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor ?? AppColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      builder: (context) => Container(
        constraints: maxHeight != null
            ? BoxConstraints(maxHeight: maxHeight)
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            if (enableDrag)
              Container(
                margin: const EdgeInsets.only(top: AppConstants.paddingMD),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColor.grey300,
                  borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                ),
              ),

            // Title
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLG),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.h5,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

            // Content
            Flexible(
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  // Scrollable bottom sheet
  static Future<T?> showScrollable<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    double initialChildSize = 0.5,
    double minChildSize = 0.25,
    double maxChildSize = 0.9,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: AppColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            // Drag Handle
            if (enableDrag)
              Container(
                margin: const EdgeInsets.only(top: AppConstants.paddingMD),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColor.grey300,
                  borderRadius: BorderRadius.circular(AppConstants.radiusSM),
                ),
              ),

            // Title
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLG),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.h5,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Material bottom sheet (using modal_bottom_sheet package)
  static Future<T?> showMaterial<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
  }) async {
    return await showMaterialModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor ?? AppColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (enableDrag)
            Container(
              margin: const EdgeInsets.only(top: AppConstants.paddingMD),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColor.grey300,
                borderRadius: BorderRadius.circular(AppConstants.radiusSM),
              ),
            ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLG),
              child: Row(
                children: [
                  Expanded(
                    child: Text(title, style: AppTextStyles.h5),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          Flexible(child: child),
        ],
      ),
    );
  }

  // List options bottom sheet
  static Future<T?> showOptions<T>({
    required BuildContext context,
    String? title,
    required List<D2YBottomSheetOption<T>> options,
  }) async {
    return await show<T>(
      context: context,
      title: title,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: options.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final option = options[index];
          return ListTile(
            leading: option.icon != null
                ? Icon(option.icon, color: option.color)
                : null,
            title: Text(
              option.label,
              style: TextStyle(color: option.color),
            ),
            subtitle: option.subtitle != null
                ? Text(option.subtitle!)
                : null,
            onTap: () {
              Navigator.pop(context, option.value);
              option.onTap?.call();
            },
          );
        },
      ),
    );
  }

  // Action sheet (iOS style)
  static Future<T?> showActionSheet<T>({
    required BuildContext context,
    String? title,
    String? message,
    required List<D2YBottomSheetOption<T>> actions,
    String cancelText = 'Cancel',
  }) async {
    return await show<T>(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || message != null)
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLG),
              child: Column(
                children: [
                  if (title != null)
                    Text(
                      title,
                      style: AppTextStyles.h6,
                      textAlign: TextAlign.center,
                    ),
                  if (message != null) ...[
                    const SizedBox(height: AppConstants.spaceSM),
                    Text(
                      message,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColor.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: actions.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final action = actions[index];
              return ListTile(
                leading: action.icon != null
                    ? Icon(action.icon, color: action.color)
                    : null,
                title: Text(
                  action.label,
                  style: TextStyle(
                    color: action.color,
                    fontWeight: action.isDestructive 
                        ? FontWeight.w600 
                        : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context, action.value);
                  action.onTap?.call();
                },
              );
            },
          ),
          const Divider(height: 8, thickness: 8),
          ListTile(
            title: Text(
              cancelText,
              style: const TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class D2YBottomSheetOption<T> {
  final String label;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final T? value;
  final VoidCallback? onTap;
  final bool isDestructive;

  D2YBottomSheetOption({
    required this.label,
    this.subtitle,
    this.icon,
    this.color,
    this.value,
    this.onTap,
    this.isDestructive = false,
  });
}