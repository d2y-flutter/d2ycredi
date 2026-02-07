import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YSlideable extends StatelessWidget {
  final Widget child;
  final List<D2YSlideAction>? startActions;
  final List<D2YSlideAction>? endActions;
  final double actionExtentRatio;
  final bool enabled;

  const D2YSlideable({
    super.key,
    required this.child,
    this.startActions,
    this.endActions,
    this.actionExtentRatio = 0.25,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled || (startActions == null && endActions == null)) {
      return child;
    }

    return Slidable(
      enabled: enabled,
      startActionPane: startActions != null
          ? ActionPane(
              motion: const ScrollMotion(),
              extentRatio: actionExtentRatio * startActions!.length,
              children: startActions!.map(_buildAction).toList(),
            )
          : null,
      endActionPane: endActions != null
          ? ActionPane(
              motion: const ScrollMotion(),
              extentRatio: actionExtentRatio * endActions!.length,
              children: endActions!.map(_buildAction).toList(),
            )
          : null,
      child: child,
    );
  }

  Widget _buildAction(D2YSlideAction action) {
    return SlidableAction(
      onPressed: (context) => action.onPressed(),
      backgroundColor: action.backgroundColor ?? AppColor.primary,
      foregroundColor: action.foregroundColor ?? AppColor.white,
      icon: action.icon,
      label: action.label,
      borderRadius: BorderRadius.circular(AppConstants.radiusMD),
    );
  }

  // Delete action helper
  static Widget delete({
    required Widget child,
    required VoidCallback onDelete,
    String? label,
    bool confirmDelete = true,
  }) {
    return D2YSlideable(
      endActions: [
        D2YSlideAction(
          icon: Icons.delete_outline,
          label: label ?? 'Delete',
          backgroundColor: AppColor.error,
          onPressed: onDelete,
        ),
      ],
      child: child,
    );
  }

  // Edit and Delete actions
  static Widget editDelete({
    required Widget child,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    String? editLabel,
    String? deleteLabel,
  }) {
    return D2YSlideable(
      endActions: [
        D2YSlideAction(
          icon: Icons.edit_outlined,
          label: editLabel ?? 'Edit',
          backgroundColor: AppColor.info,
          onPressed: onEdit,
        ),
        D2YSlideAction(
          icon: Icons.delete_outline,
          label: deleteLabel ?? 'Delete',
          backgroundColor: AppColor.error,
          onPressed: onDelete,
        ),
      ],
      child: child,
    );
  }

  // Archive action
  static Widget archive({
    required Widget child,
    required VoidCallback onArchive,
    String? label,
  }) {
    return D2YSlideable(
      endActions: [
        D2YSlideAction(
          icon: Icons.archive_outlined,
          label: label ?? 'Archive',
          backgroundColor: AppColor.warning,
          onPressed: onArchive,
        ),
      ],
      child: child,
    );
  }

  // Share action
  static Widget share({
    required Widget child,
    required VoidCallback onShare,
    String? label,
  }) {
    return D2YSlideable(
      startActions: [
        D2YSlideAction(
          icon: Icons.share_outlined,
          label: label ?? 'Share',
          backgroundColor: AppColor.info,
          onPressed: onShare,
        ),
      ],
      child: child,
    );
  }

  // Custom actions on both sides
  static Widget custom({
    required Widget child,
    List<D2YSlideAction>? leftActions,
    List<D2YSlideAction>? rightActions,
  }) {
    return D2YSlideable(
      startActions: leftActions,
      endActions: rightActions,
      child: child,
    );
  }
}

class D2YSlideAction {
  final IconData icon;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;

  D2YSlideAction({
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
  });
}

// Dismissible variant (swipe to dismiss)
class D2YDismissible extends StatelessWidget {
  final Widget child;
  final String dismissKey;
  final DismissDirection direction;
  final VoidCallback? onDismissed;
  final Future<bool> Function()? confirmDismiss;
  final Color? backgroundColor;
  final Widget? background;
  final Widget? secondaryBackground;

  const D2YDismissible({
    super.key,
    required this.child,
    required this.dismissKey,
    this.direction = DismissDirection.endToStart,
    this.onDismissed,
    this.confirmDismiss,
    this.backgroundColor,
    this.background,
    this.secondaryBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(dismissKey),
      direction: direction,
      onDismissed: (_) => onDismissed?.call(),
      confirmDismiss: confirmDismiss != null
          ? (_) => confirmDismiss!()
          : null,
      background: background ??
          Container(
            color: backgroundColor ?? AppColor.error,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: AppConstants.paddingXL),
            child: const Icon(Icons.delete_outline, color: Colors.white),
          ),
      secondaryBackground: secondaryBackground ??
          Container(
            color: backgroundColor ?? AppColor.error,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: AppConstants.paddingXL),
            child: const Icon(Icons.delete_outline, color: Colors.white),
          ),
      child: child,
    );
  }

  // Delete dismissible
  static Widget delete({
    required Widget child,
    required String dismissKey,
    required VoidCallback onDelete,
    bool confirmDelete = true,
  }) {
    return D2YDismissible(
      dismissKey: dismissKey,
      onDismissed: onDelete,
      confirmDismiss: confirmDelete
          ? () async {
              // You can show a confirmation dialog here
              return true;
            }
          : null,
      child: child,
    );
  }
}