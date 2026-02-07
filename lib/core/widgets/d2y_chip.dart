import 'package:flutter/material.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Widget? avatar;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? iconColor;
  final EdgeInsets? padding;
  final bool selected;
  final Color? selectedColor;

  const D2YChip({
    super.key,
    required this.label,
    this.icon,
    this.avatar,
    this.onTap,
    this.onDelete,
    this.backgroundColor,
    this.labelColor,
    this.iconColor,
    this.padding,
    this.selected = false,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    if (onDelete != null) {
      return Chip(
        label: Text(label),
        avatar: avatar,
        labelStyle: TextStyle(
          color: labelColor ?? AppColor.textPrimary,
          fontSize: AppConstants.fontSM,
        ),
        backgroundColor: backgroundColor ?? AppColor.grey100,
        deleteIcon: const Icon(Icons.close, size: AppConstants.iconSM),
        deleteIconColor: iconColor ?? AppColor.textSecondary,
        onDeleted: onDelete,
        padding: padding ?? const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingSM,
          vertical: AppConstants.paddingXS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
      );
    }

    if (selected) {
      return ChoiceChip(
        label: Text(label),
        avatar: avatar,
        labelStyle: TextStyle(
          color: labelColor ?? AppColor.white,
          fontSize: AppConstants.fontSM,
        ),
        selected: true,
        selectedColor: selectedColor ?? AppColor.primary,
        backgroundColor: backgroundColor ?? AppColor.grey100,
        onSelected: onTap != null ? (_) => onTap!() : null,
        padding: padding ?? const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingSM,
          vertical: AppConstants.paddingXS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
      );
    }

    return ActionChip(
      label: Text(label),
      avatar: avatar ?? (icon != null ? Icon(icon, size: AppConstants.iconSM) : null),
      labelStyle: TextStyle(
        color: labelColor ?? AppColor.textPrimary,
        fontSize: AppConstants.fontSM,
      ),
      backgroundColor: backgroundColor ?? AppColor.grey100,
      onPressed: onTap,
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingSM,
        vertical: AppConstants.paddingXS,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusSM),
      ),
    );
  }

  // Outlined chip
  static Widget outlined({
    required String label,
    IconData? icon,
    VoidCallback? onTap,
    VoidCallback? onDelete,
    Color? borderColor,
    Color? labelColor,
  }) {
    return D2YChip(
      label: label,
      icon: icon,
      onTap: onTap,
      onDelete: onDelete,
      backgroundColor: Colors.transparent,
      labelColor: labelColor ?? AppColor.primary,
    );
  }

  // Status chip
  static Widget status({
    required String label,
    required D2YChipStatus status,
    IconData? icon,
  }) {
    Color backgroundColor;
    Color labelColor;

    switch (status) {
      case D2YChipStatus.success:
        backgroundColor = AppColor.successSurface;
        labelColor = AppColor.success;
        break;
      case D2YChipStatus.error:
        backgroundColor = AppColor.errorSurface;
        labelColor = AppColor.error;
        break;
      case D2YChipStatus.warning:
        backgroundColor = AppColor.warningSurface;
        labelColor = AppColor.warning;
        break;
      case D2YChipStatus.info:
        backgroundColor = AppColor.infoSurface;
        labelColor = AppColor.info;
        break;
    }

    return D2YChip(
      label: label,
      icon: icon,
      backgroundColor: backgroundColor,
      labelColor: labelColor,
      iconColor: labelColor,
    );
  }
}

enum D2YChipStatus {
  success,
  error,
  warning,
  info,
}

// Chip group
class D2YChipGroup<T> extends StatelessWidget {
  final List<T> values;
  final T? selectedValue;
  final List<T>? selectedValues;
  final ValueChanged<T>? onSelected;
  final ValueChanged<List<T>>? onMultipleSelected;
  final String Function(T) labelBuilder;
  final bool multiSelect;
  final Color? selectedColor;
  final WrapAlignment alignment;
  final double spacing;
  final double runSpacing;

  const D2YChipGroup({
    super.key,
    required this.values,
    this.selectedValue,
    this.selectedValues,
    this.onSelected,
    this.onMultipleSelected,
    required this.labelBuilder,
    this.multiSelect = false,
    this.selectedColor,
    this.alignment = WrapAlignment.start,
    this.spacing = AppConstants.spaceSM,
    this.runSpacing = AppConstants.spaceSM,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
      spacing: spacing,
      runSpacing: runSpacing,
      children: values.map((value) {
        final isSelected = multiSelect
            ? (selectedValues?.contains(value) ?? false)
            : selectedValue == value;

        return D2YChip(
          label: labelBuilder(value),
          selected: isSelected,
          selectedColor: selectedColor,
          onTap: () {
            if (multiSelect) {
              final newValues = List<T>.from(selectedValues ?? []);
              if (isSelected) {
                newValues.remove(value);
              } else {
                newValues.add(value);
              }
              onMultipleSelected?.call(newValues);
            } else {
              onSelected?.call(value);
            }
          },
        );
      }).toList(),
    );
  }
}