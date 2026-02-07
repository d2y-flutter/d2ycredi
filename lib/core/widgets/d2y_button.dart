import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../config/app_color.dart';
import '../config/app_constants.dart';
import '../config/app_text_styles.dart';

enum D2YButtonType {
  elevated,
  outlined,
  text,
  icon,
}

enum D2YButtonSize {
  small,
  medium,
  large,
}

class D2YButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final Widget? child;
  final VoidCallback? onPressed;
  final D2YButtonType type;
  final D2YButtonSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool fullWidth;
  final bool loading;
  final bool disabled;
  final double? borderRadius;
  final EdgeInsets? padding;
  final bool adaptive;
  final Color? textColor;

  const D2YButton({
    super.key,
    this.label,
    this.icon,
    this.child,
    required this.onPressed,
    this.type = D2YButtonType.elevated,
    this.size = D2YButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.fullWidth = false,
    this.loading = false,
    this.disabled = false,
    this.borderRadius,
    this.padding,
    this.adaptive = false,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = (disabled || loading) ? null : onPressed;

    if (adaptive && Platform.isIOS && type == D2YButtonType.elevated) {
      return _buildCupertinoButton(effectiveOnPressed);
    }

    Widget button = _buildButton(context, effectiveOnPressed);

    if (fullWidth) {
      button = SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }

  Widget _buildButton(BuildContext context, VoidCallback? effectiveOnPressed) {
    final effectiveBorderRadius = borderRadius ?? AppConstants.radiusMD;

    switch (type) {
      case D2YButtonType.elevated:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColor.primary,
            foregroundColor: foregroundColor ?? AppColor.textOnPrimary,
            disabledBackgroundColor: AppColor.grey300,
            disabledForegroundColor: AppColor.grey500,
            padding: padding ?? _getPadding(),
            minimumSize: Size(0, _getHeight()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
            elevation: 0,
          ),
          child: _buildContent(),
        );

      case D2YButtonType.outlined:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor ?? AppColor.primary,
            disabledForegroundColor: AppColor.grey500,
            side: BorderSide(
              color: borderColor ?? (foregroundColor ?? AppColor.primary),
              width: AppConstants.borderWidthThick,
            ),
            padding: padding ?? _getPadding(),
            minimumSize: Size(0, _getHeight()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
          ),
          child: _buildContent(),
        );

      case D2YButtonType.text:
        return TextButton(
          onPressed: effectiveOnPressed,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor ?? AppColor.primary,
            disabledForegroundColor: AppColor.grey500,
            padding: padding ?? _getPadding(),
            minimumSize: Size(0, _getHeight()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
          ),
          child: _buildContent(),
        );

      case D2YButtonType.icon:
        return IconButton(
          onPressed: effectiveOnPressed,
          icon: Icon(icon),
          color: foregroundColor ?? AppColor.primary,
          disabledColor: AppColor.grey500,
          iconSize: _getIconSize(),
        );
    }
  }

  Widget _buildCupertinoButton(VoidCallback? effectiveOnPressed) {
    return CupertinoButton(
      onPressed: effectiveOnPressed,
      color: backgroundColor ?? AppColor.primary,
      padding: padding ?? _getPadding(),
      borderRadius: BorderRadius.circular(borderRadius ?? AppConstants.radiusMD),
      minimumSize: Size(_getHeight(), _getHeight()),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (loading) {
      return SizedBox(
        width: _getLoadingSize(),
        height: _getLoadingSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == D2YButtonType.elevated
                ? (foregroundColor ?? AppColor.textOnPrimary)
                : (foregroundColor ?? AppColor.primary),
          ),
        ),
      );
    }

    if (child != null) return child!;

    final hasIcon = icon != null;
    final hasLabel = label != null && label!.isNotEmpty;

    if (hasIcon && hasLabel) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize(), color: _resolveTextColor()),
          const SizedBox(width: AppConstants.spaceSM),
          Text(
            label!,
            style: _getTextStyle().copyWith(
              color: _resolveTextColor(),
            ),
          ),
        ],
      );
    }

    if (hasIcon) {
      return Icon(icon, size: _getIconSize(), color: _resolveTextColor());
    }

    if (hasLabel) {
      return Text(
        label!,
        style: _getTextStyle().copyWith(
          color: _resolveTextColor(),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Color _resolveTextColor() {
  if (disabled) return AppColor.grey500;

  if (textColor != null) return textColor!;

  switch (type) {
    case D2YButtonType.outlined:
    case D2YButtonType.text:
      return AppColor.primary; 
    case D2YButtonType.elevated:
    default:
      return AppColor.textOnPrimary; 
  }
}

  EdgeInsets _getPadding() {
    switch (size) {
      case D2YButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMD,
          vertical: AppConstants.paddingSM,
        );
      case D2YButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingXL,
          vertical: AppConstants.paddingMD,
        );
      case D2YButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingXXL,
          vertical: AppConstants.paddingLG,
        );
    }
  }

  double _getHeight() {
    switch (size) {
      case D2YButtonSize.small:
        return AppConstants.buttonHeightSM;
      case D2YButtonSize.medium:
        return AppConstants.buttonHeightMD;
      case D2YButtonSize.large:
        return AppConstants.buttonHeightLG;
    }
  }

  double _getIconSize() {
    switch (size) {
      case D2YButtonSize.small:
        return AppConstants.iconSM;
      case D2YButtonSize.medium:
        return AppConstants.iconMD;
      case D2YButtonSize.large:
        return AppConstants.iconLG;
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case D2YButtonSize.small:
        return 16;
      case D2YButtonSize.medium:
        return 20;
      case D2YButtonSize.large:
        return 24;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case D2YButtonSize.small:
        return AppTextStyles.buttonSmall;
      case D2YButtonSize.medium:
        return AppTextStyles.buttonMedium;
      case D2YButtonSize.large:
        return AppTextStyles.buttonLarge;
    }
  }

  // Factory constructors
  static Widget primary({
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
    D2YButtonSize size = D2YButtonSize.medium,
    bool fullWidth = false,
    bool loading = false,
  }) {
    return D2YButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      type: D2YButtonType.elevated,
      size: size,
      fullWidth: fullWidth,
      loading: loading,
    );
  }

  static Widget secondary({
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
    D2YButtonSize size = D2YButtonSize.medium,
    bool fullWidth = false,
    bool loading = false,
  }) {
    return D2YButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      type: D2YButtonType.outlined,
      size: size,
      fullWidth: fullWidth,
      loading: loading,
    );
  }

  static Widget danger({
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
    D2YButtonSize size = D2YButtonSize.medium,
    bool fullWidth = false,
    bool loading = false,
  }) {
    return D2YButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      type: D2YButtonType.elevated,
      backgroundColor: AppColor.error,
      size: size,
      fullWidth: fullWidth,
      loading: loading,
    );
  }

  static Widget success({
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
    D2YButtonSize size = D2YButtonSize.medium,
    bool fullWidth = false,
    bool loading = false,
  }) {
    return D2YButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      type: D2YButtonType.elevated,
      backgroundColor: AppColor.success,
      size: size,
      fullWidth: fullWidth,
      loading: loading,
    );
  }

  static Widget iconButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
    D2YButtonSize size = D2YButtonSize.medium,
  }) {
    return D2YButton(
      icon: icon,
      onPressed: onPressed,
      type: D2YButtonType.icon,
      foregroundColor: color,
      size: size,
    );
  }
}