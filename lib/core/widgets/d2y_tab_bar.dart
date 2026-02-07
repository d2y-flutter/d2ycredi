import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YTabBarView extends StatelessWidget {
  final TabController controller;
  final List<Widget> children;
  final DragStartBehavior dragStartBehavior;
  final ScrollPhysics? physics;

  const D2YTabBarView({
    super.key,
    required this.controller,
    required this.children,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      dragStartBehavior: dragStartBehavior,
      physics: physics,
      children: children,
    );
  }
}

// Custom tab bar widget
class D2YCustomTabBar extends StatelessWidget {
  final List<D2YTab> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;
  final Color? backgroundColor;
  final bool isScrollable;
  final EdgeInsets? padding;
  final double indicatorHeight;

  const D2YCustomTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.backgroundColor,
    this.isScrollable = false,
    this.padding,
    this.indicatorHeight = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColor.white,
      padding: padding,
      child: isScrollable
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildTabs(),
            )
          : _buildTabs(),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisSize: isScrollable ? MainAxisSize.min : MainAxisSize.max,
      children: List.generate(tabs.length, (index) {
        final tab = tabs[index];
        final isSelected = currentIndex == index;

        return Expanded(
          flex: isScrollable ? 0 : 1,
          child: InkWell(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingLG,
                vertical: AppConstants.paddingMD,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? (indicatorColor ?? AppColor.primary)
                        : Colors.transparent,
                    width: indicatorHeight,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (tab.icon != null) ...[
                    Icon(
                      tab.icon,
                      size: AppConstants.iconSM,
                      color: isSelected
                          ? (selectedColor ?? AppColor.primary)
                          : (unselectedColor ?? AppColor.textSecondary),
                    ),
                    const SizedBox(width: AppConstants.spaceSM),
                  ],
                  Text(
                    tab.label,
                    style: TextStyle(
                      color: isSelected
                          ? (selectedColor ?? AppColor.primary)
                          : (unselectedColor ?? AppColor.textSecondary),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: AppConstants.fontMD,
                    ),
                  ),
                  if (tab.badge != null) ...[
                    const SizedBox(width: AppConstants.spaceSM),
                    tab.badge!,
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // Segmented style tab bar
  static Widget segmented({
    required List<D2YTab> tabs,
    required int currentIndex,
    required ValueChanged<int> onTap,
    Color? selectedColor,
    Color? unselectedColor,
    Color? backgroundColor,
  }) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMD),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.grey100,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final tab = tabs[index];
          final isSelected = currentIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.paddingMD,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (selectedColor ?? AppColor.primary)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                ),
                child: Center(
                  child: Text(
                    tab.label,
                    style: TextStyle(
                      color: isSelected
                          ? AppColor.white
                          : (unselectedColor ?? AppColor.textSecondary),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: AppConstants.fontMD,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class D2YTab {
  final String label;
  final IconData? icon;
  final Widget? badge;

  D2YTab({
    required this.label,
    this.icon,
    this.badge,
  });
}

// Badge widget for tabs
class D2YTabBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const D2YTabBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingSM,
        vertical: AppConstants.paddingXS,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.error,
        borderRadius: BorderRadius.circular(AppConstants.radiusCircle),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColor.white,
          fontSize: AppConstants.fontXS,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}