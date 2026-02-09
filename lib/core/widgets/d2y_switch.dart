import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool adaptive;
  final EdgeInsets? padding;

  const D2YSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.adaptive = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return InkWell(
        onTap: onChanged != null ? () => onChanged!(!value) : null,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(
            vertical: AppConstants.paddingSM,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label!,
                  style: TextStyle(
                    color: onChanged != null
                        ? AppColor.textPrimary
                        : AppColor.textDisabled,
                    fontSize: AppConstants.fontMD,
                  ),
                ),
              ),
              _buildSwitch(),
            ],
          ),
        ),
      );
    }

    return _buildSwitch();
  }

  Widget _buildSwitch() {
    if (adaptive && Platform.isIOS) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor ?? AppColor.primary,
      );
    }

    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? AppColor.primary,
      inactiveThumbColor: inactiveColor,
    );
  }

  // Switch list tile
  static Widget listTile({
    required bool value,
    required ValueChanged<bool>? onChanged,
    required String title,
    String? subtitle,
    Widget? secondary,
    Color? activeColor,
    bool adaptive = true,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      secondary: secondary,
      activeColor: activeColor ?? AppColor.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      ),
    );
  }
}

// Custom styled switch
class D2YCustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double width;
  final double height;
  final Duration duration;

  const D2YCustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.width = 52,
    this.height = 32,
    this.duration = const Duration(milliseconds: 180),
  });

  @override
  Widget build(BuildContext context) {
    final double padding = 3;
    final double thumbSize = height - padding * 2;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: duration,
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          color: value
              ? (activeColor ?? AppColor.primary)
              : (inactiveColor ?? AppColor.grey300),
        ),
        child: AnimatedAlign(
          duration: duration,
          curve: Curves.easeOutCubic,
          alignment:
              value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: thumbSize,
            height: thumbSize,
            decoration: BoxDecoration(
              color: thumbColor ?? AppColor.white,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Switch with icons
class D2YIconSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final Color? activeColor;
  final Color? inactiveColor;
  final double width;
  final double height;

  const D2YIconSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeIcon = Icons.check,
    this.inactiveIcon = Icons.close,
    this.activeColor,
    this.inactiveColor,
    this.width = 60,
    this.height = 32,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          color: value
              ? (activeColor ?? AppColor.primary)
              : (inactiveColor ?? AppColor.grey300),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? width - height : 0,
              child: Container(
                width: height,
                height: height,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.white,
                ),
                child: Icon(
                  value ? activeIcon : inactiveIcon,
                  size: height * 0.6,
                  color: value
                      ? (activeColor ?? AppColor.primary)
                      : (inactiveColor ?? AppColor.grey500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Switch group (like radio buttons but with switches)
class D2YSwitchGroup extends StatelessWidget {
  final List<D2YSwitchItem> items;
  final ValueChanged<int>? onChanged;
  final int? selectedIndex;
  final Color? activeColor;
  final bool adaptive;

  const D2YSwitchGroup({
    super.key,
    required this.items,
    this.onChanged,
    this.selectedIndex,
    this.activeColor,
    this.adaptive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        final isSelected = selectedIndex == index;

        return D2YSwitch(
          value: isSelected,
          onChanged: onChanged != null
              ? (value) {
                  if (value) {
                    onChanged!(index);
                  }
                }
              : null,
          label: item.label,
          activeColor: activeColor,
          adaptive: adaptive,
        );
      }),
    );
  }
}

class D2YSwitchItem {
  final String label;
  final dynamic value;

  D2YSwitchItem({
    required this.label,
    this.value,
  });
}