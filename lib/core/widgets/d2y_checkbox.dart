import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final Color? activeColor;
  final Color? checkColor;
  final bool adaptive;
  final EdgeInsets? padding;

  const D2YCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor,
    this.checkColor,
    this.adaptive = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return InkWell(
        onTap: onChanged != null ? () => onChanged!(!value) : null,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: AppConstants.paddingSM),
          child: Row(
            children: [
              _buildCheckbox(),
              const SizedBox(width: AppConstants.spaceMD),
              Expanded(
                child: Text(
                  label!,
                  style: TextStyle(
                    color: onChanged != null ? AppColor.textPrimary : AppColor.textDisabled,
                    fontSize: AppConstants.fontMD,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return _buildCheckbox();
  }

  Widget _buildCheckbox() {
    if (adaptive && Platform.isIOS) {
      return CupertinoCheckbox(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor ?? AppColor.primary,
        checkColor: checkColor ?? AppColor.white,
      );
    }

    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? AppColor.primary,
      checkColor: checkColor ?? AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusXS),
      ),
    );
  }

  // Checkbox list tile
  static Widget listTile({
    required bool value,
    required ValueChanged<bool?>? onChanged,
    required String title,
    String? subtitle,
    Widget? secondary,
    Color? activeColor,
    bool adaptive = true,
  }) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      secondary: secondary,
      activeColor: activeColor ?? AppColor.primary,
      controlAffinity: ListTileControlAffinity.leading,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      ),
    );
  }
}

// Checkbox group
class D2YCheckboxGroup<T> extends StatelessWidget {
  final List<T> values;
  final List<T> selectedValues;
  final ValueChanged<List<T>> onChanged;
  final String Function(T) labelBuilder;
  final Color? activeColor;
  final bool adaptive;
  final Axis direction;

  const D2YCheckboxGroup({
    super.key,
    required this.values,
    required this.selectedValues,
    required this.onChanged,
    required this.labelBuilder,
    this.activeColor,
    this.adaptive = true,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Wrap(
        spacing: AppConstants.spaceMD,
        children: values.map((value) => _buildCheckbox(value)).toList(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: values.map((value) => _buildCheckbox(value)).toList(),
    );
  }

  Widget _buildCheckbox(T value) {
    final isSelected = selectedValues.contains(value);

    return D2YCheckbox(
      value: isSelected,
      onChanged: (_) {
        final newValues = List<T>.from(selectedValues);
        if (isSelected) {
          newValues.remove(value);
        } else {
          newValues.add(value);
        }
        onChanged(newValues);
      },
      label: labelBuilder(value),
      activeColor: activeColor,
      adaptive: adaptive,
    );
  }
}