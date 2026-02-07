import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';

enum ToastType {
  success,
  error,
  warning,
  info,
}

class D2YToast {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (_isShowing) return;

    _isShowing = true;

    final overlay = Overlay.of(context);

    late AnimationController controller;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return _ToastWidget(
          message: message,
          type: type,
          duration: duration,
          onDismiss: () {
            controller.reverse().then((_) {
              _remove();
            });
          },
          onControllerCreated: (c) => controller = c,
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  static void _remove() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isShowing = false;
  }

  // Shortcut helpers
  static void success(BuildContext context, String message) {
    show(context, message: message, type: ToastType.success);
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, type: ToastType.error);
  }

  static void warning(BuildContext context, String message) {
    show(context, message: message, type: ToastType.warning);
  }

  static void info(BuildContext context, String message) {
    show(context, message: message, type: ToastType.info);
  }
}

/// ==============================
/// INTERNAL TOAST WIDGET
/// ==============================
class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final Duration duration;
  final VoidCallback onDismiss;
  final Function(AnimationController) onControllerCreated;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismiss,
    required this.onControllerCreated,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    widget.onControllerCreated(_controller);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();

    Timer(widget.duration, widget.onDismiss);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = _ToastStyle.fromType(widget.type);

    return Positioned(
      top: MediaQuery.of(context).padding.top + AppConstants.spaceMD,
      left: AppConstants.spaceMD,
      right: AppConstants.spaceMD,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: GestureDetector(
              onTap: widget.onDismiss,
             child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLG,
                    vertical: AppConstants.paddingLG,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                    border: Border.all(
                      color: style.accentColor.withValues(alpha: 0.8),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        style.icon,
                        color: style.accentColor,
                        size: 22,
                      ),
                      const SizedBox(width: AppConstants.spaceMD),
                      Expanded(
                        child: Text(
                          widget.message,
                          style: TextStyle(
                            color: AppColor.textPrimary,
                            fontSize: AppConstants.fontMD,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ==============================
/// STYLE CONFIG
/// ==============================
class _ToastStyle {
  final Color accentColor;
  final IconData icon;

  _ToastStyle({
    required this.accentColor,
    required this.icon,
  });

  factory _ToastStyle.fromType(ToastType type) {
    switch (type) {
      case ToastType.success:
        return _ToastStyle(
          accentColor: AppColor.success,
          icon: Icons.check_circle_outline,
        );
      case ToastType.error:
        return _ToastStyle(
          accentColor: AppColor.error,
          icon: Icons.error_outline,
        );
      case ToastType.warning:
        return _ToastStyle(
          accentColor: AppColor.warning,
          icon: Icons.warning_amber_outlined,
        );
      case ToastType.info:
      return _ToastStyle(
          accentColor: AppColor.primary,
          icon: Icons.info_outline,
        );
    }
  }
}