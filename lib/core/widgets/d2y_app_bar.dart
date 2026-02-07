import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_color.dart';

class D2YAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const D2YAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.bottom,
    this.systemOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColor.white,
      foregroundColor: foregroundColor ?? AppColor.textPrimary,
      elevation: elevation,
      bottom: bottom,
      systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  // Transparent app bar
  static PreferredSizeWidget transparent({
    String? title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = true,
  }) {
    return D2YAppBar(
      title: title,
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColor.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  // Search app bar
  static PreferredSizeWidget search({
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    String? hint,
    VoidCallback? onClear,
    List<Widget>? actions,
  }) {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      titleSpacing: 0,
      title: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint ?? 'Search...',
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                )
              : null,
        ),
      ),
      actions: actions,
    );
  }

  // Sliver app bar
  static Widget sliver({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool pinned = true,
    bool floating = false,
    bool snap = false,
    double expandedHeight = 200.0,
    Widget? flexibleSpace,
    Color? backgroundColor,
  }) {
    return SliverAppBar(
      title: Text(title),
      leading: leading,
      actions: actions,
      pinned: pinned,
      floating: floating,
      snap: snap,
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace,
      backgroundColor: backgroundColor ?? AppColor.primary,
    );
  }

  // Custom app bar with gradient
  static PreferredSizeWidget gradient({
    String? title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = true,
    required Gradient gradient,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: AppBar(
          title: title != null ? Text(title) : null,
          leading: leading,
          actions: actions,
          centerTitle: centerTitle,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}

// Tab bar for use with D2YAppBar
class D2YTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final bool isScrollable;

  const D2YTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      indicatorColor: indicatorColor ?? AppColor.primary,
      labelColor: labelColor ?? AppColor.primary,
      unselectedLabelColor: unselectedLabelColor ?? AppColor.textSecondary,
      isScrollable: isScrollable,
      indicatorWeight: 3,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}