import 'package:flutter/material.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';
import 'd2y_image.dart';

class D2YAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;
  final Border? border;
  final BoxShape shape;
  final VoidCallback? onTap;
  final Widget? badge;
  final bool showInitials;

  const D2YAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AppConstants.avatarMD,
    this.backgroundColor,
    this.textColor,
    this.border,
    this.shape = BoxShape.circle,
    this.onTap,
    this.badge,
    this.showInitials = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? _getColorFromName(name),
        border: border,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? BorderRadius.circular(AppConstants.radiusMD)
            : null,
      ),
      child: _buildContent(),
    );

    // Add badge if provided
    if (badge != null) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: badge!,
          ),
        ],
      );
    }

    // Add tap gesture if provided
    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        borderRadius: shape == BoxShape.circle
            ? BorderRadius.circular(size / 2)
            : BorderRadius.circular(AppConstants.radiusMD),
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildContent() {
    // Show image if URL is provided
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: shape == BoxShape.circle
            ? BorderRadius.circular(size / 2)
            : BorderRadius.circular(AppConstants.radiusMD),
        child: D2YImage(
          imageUrl: imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }

    // Show initials if name is provided
    if (showInitials && name != null && name!.isNotEmpty) {
      return Center(
        child: Text(
          _getInitials(name!),
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    // Show default icon
    return Center(
      child: Icon(
        Icons.person_outline,
        size: size * 0.6,
        color: textColor ?? Colors.white,
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '';
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return '${words[0].substring(0, 1)}${words[1].substring(0, 1)}'.toUpperCase();
  }

  Color _getColorFromName(String? name) {
    if (name == null || name.isEmpty) return AppColor.primary;

    final colors = [
      AppColor.primary,
      AppColor.secondary,
      AppColor.accent,
      AppColor.info,
      AppColor.success,
      AppColor.warning,
    ];

    final index = name.codeUnitAt(0) % colors.length;
    return colors[index];
  }

  // Predefined sizes
  static Widget small({
    String? imageUrl,
    String? name,
    Color? backgroundColor,
    VoidCallback? onTap,
    Widget? badge,
  }) {
    return D2YAvatar(
      imageUrl: imageUrl,
      name: name,
      size: AppConstants.avatarSM,
      backgroundColor: backgroundColor,
      onTap: onTap,
      badge: badge,
    );
  }

  static Widget medium({
    String? imageUrl,
    String? name,
    Color? backgroundColor,
    VoidCallback? onTap,
    Widget? badge,
  }) {
    return D2YAvatar(
      imageUrl: imageUrl,
      name: name,
      size: AppConstants.avatarMD,
      backgroundColor: backgroundColor,
      onTap: onTap,
      badge: badge,
    );
  }

  static Widget large({
    String? imageUrl,
    String? name,
    Color? backgroundColor,
    VoidCallback? onTap,
    Widget? badge,
  }) {
    return D2YAvatar(
      imageUrl: imageUrl,
      name: name,
      size: AppConstants.avatarLG,
      backgroundColor: backgroundColor,
      onTap: onTap,
      badge: badge,
    );
  }

  static Widget extraLarge({
    String? imageUrl,
    String? name,
    Color? backgroundColor,
    VoidCallback? onTap,
    Widget? badge,
  }) {
    return D2YAvatar(
      imageUrl: imageUrl,
      name: name,
      size: AppConstants.avatarXL,
      backgroundColor: backgroundColor,
      onTap: onTap,
      badge: badge,
    );
  }

  // Avatar with online status badge
  static Widget withStatus({
    String? imageUrl,
    String? name,
    double size = AppConstants.avatarMD,
    bool isOnline = false,
    VoidCallback? onTap,
  }) {
    return D2YAvatar(
      imageUrl: imageUrl,
      name: name,
      size: size,
      onTap: onTap,
      badge: Container(
        width: size * 0.25,
        height: size * 0.25,
        decoration: BoxDecoration(
          color: isOnline ? AppColor.success : AppColor.grey400,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColor.white,
            width: 2,
          ),
        ),
      ),
    );
  }

  // Avatar group (stacked avatars)
  static Widget group({
    required List<String?> imageUrls,
    required List<String?> names,
    double size = AppConstants.avatarSM,
    int maxVisible = 3,
    VoidCallback? onTap,
  }) {
    final visibleCount = imageUrls.length > maxVisible ? maxVisible : imageUrls.length;
    final remaining = imageUrls.length - visibleCount;

    return SizedBox(
      width: size + (visibleCount - 1) * (size * 0.7),
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < visibleCount; i++)
            Positioned(
              left: i * (size * 0.7),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.white,
                    width: 2,
                  ),
                ),
                child: D2YAvatar(
                  imageUrl: imageUrls[i],
                  name: names[i],
                  size: size,
                  onTap: onTap,
                ),
              ),
            ),
          if (remaining > 0)
            Positioned(
              left: visibleCount * (size * 0.7),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: AppColor.grey700,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.white,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size * 0.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}