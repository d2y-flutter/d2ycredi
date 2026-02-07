import 'package:flutter/material.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Gradient? gradient;
  final double? width;
  final double? height;

  const D2YCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.onTap,
    this.onLongPress,
    this.gradient,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppConstants.paddingLG),
      decoration: BoxDecoration(
        color: gradient == null ? (color ?? AppColor.white) : null,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.radiusMD),
        border: border,
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: AppColor.shadowLight,
            blurRadius: elevation ?? AppConstants.elevationSM,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      card = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.radiusMD),
        child: card,
      );
    }

    return card;
  }

  // Elevated card
  static Widget elevated({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    double elevation = AppConstants.elevationMD,
  }) {
    return D2YCard(
      padding: padding,
      margin: margin,
      onTap: onTap,
      elevation: elevation,
      child: child,
    );
  }

  // Outlined card
  static Widget outlined({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
    Color? borderColor,
  }) {
    return D2YCard(
      padding: padding,
      margin: margin,
      onTap: onTap,
      border: Border.all(
        color: borderColor ?? AppColor.border,
        width: AppConstants.borderWidthNormal,
      ),
      boxShadow: [],
      child: child,
    );
  }

  // Gradient card
  static Widget gradients({
    required Widget child,
    required Gradient gradient,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
  }) {
    return D2YCard(
      padding: padding,
      margin: margin,
      onTap: onTap,
      gradient: gradient,
      child: child,
    );
  }

  // Image card
  static Widget image({
    required String imageUrl,
    required Widget child,
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
    VoidCallback? onTap,
  }) {
    return D2YCard(
      padding: EdgeInsets.zero,
      margin: margin,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (height != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusMD),
              ),
              child: Image.network(
                imageUrl,
                height: height,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: padding ?? const EdgeInsets.all(AppConstants.paddingLG),
            child: child,
          ),
        ],
      ),
    );
  }
}