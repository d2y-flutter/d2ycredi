import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<D2YBottomNavItem> items;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final bool showLabel;
  final bool adaptive;
  final double? elevation;

  const D2YBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabel = true,
    this.adaptive = true,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    if (adaptive && Platform.isIOS) {
      return _buildCupertinoTabBar();
    }
    return _buildMaterialBottomNav();
  }

  Widget _buildMaterialBottomNav() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: backgroundColor ?? AppColor.white,
      selectedItemColor: selectedColor ?? AppColor.primary,
      unselectedItemColor: unselectedColor ?? AppColor.grey500,
      type: BottomNavigationBarType.fixed,
      elevation: elevation ?? AppConstants.elevationMD,
      showSelectedLabels: showLabel,
      showUnselectedLabels: showLabel,
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          activeIcon: Icon(item.activeIcon ?? item.icon),
          label: item.label,
          tooltip: item.tooltip,
          backgroundColor: item.backgroundColor,
        );
      }).toList(),
    );
  }

  Widget _buildCupertinoTabBar() {
    return CupertinoTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: backgroundColor ?? AppColor.white,
      activeColor: selectedColor ?? AppColor.primary,
      inactiveColor: unselectedColor ?? AppColor.grey500,
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          activeIcon: Icon(item.activeIcon ?? item.icon),
          label: item.label,
          tooltip: item.tooltip,
        );
      }).toList(),
    );
  }

  // Floating action button style
  static Widget floating({
    required int currentIndex,
    required ValueChanged<int> onTap,
    required List<D2YBottomNavItem> items,
    Color? backgroundColor,
    Color? selectedColor,
    Color? unselectedColor,
  }) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingLG),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowMedium,
            blurRadius: AppConstants.elevationLG,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMD,
          vertical: AppConstants.paddingSM,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = currentIndex == index;
            
            return InkWell(
              onTap: () => onTap(index),
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMD,
                  vertical: AppConstants.paddingSM,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (selectedColor ?? AppColor.primary).withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? (item.activeIcon ?? item.icon) : item.icon,
                      color: isSelected
                          ? (selectedColor ?? AppColor.primary)
                          : (unselectedColor ?? AppColor.grey500),
                      size: AppConstants.iconMD,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: AppConstants.spaceSM),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: selectedColor ?? AppColor.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: AppConstants.fontSM,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class D2YBottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final String? tooltip;
  final Color? backgroundColor;
  final Widget? badge;

  D2YBottomNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.tooltip,
    this.backgroundColor,
    this.badge,
  });
}