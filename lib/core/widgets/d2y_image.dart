import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';
import 'd2y_shimmer.dart';

class D2YImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? color;
  final BlendMode? colorBlendMode;
  final bool enableMemoryCache;
  final Map<String, String>? headers;

  const D2YImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.color,
    this.colorBlendMode,
    this.enableMemoryCache = true,
    this.headers,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? BorderRadius.zero;

    // SVG Image
    if (imageUrl.endsWith('.svg')) {
      return ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: SvgPicture.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholderBuilder: (context) =>
              placeholder ?? _defaultPlaceholder(),
        ),
      );
    }

    // Network Image
    if (imageUrl.startsWith('http')) {
      return ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,
          memCacheWidth: enableMemoryCache ? (width?.toInt() ?? 500) : null,
          memCacheHeight: enableMemoryCache ? (height?.toInt() ?? 500) : null,
          httpHeaders: headers,
          placeholder: (context, url) =>
              placeholder ?? _defaultPlaceholder(),
          errorWidget: (context, url, error) =>
              errorWidget ?? _defaultErrorWidget(),
        ),
      );
    }

    // Local Asset Image
    return ClipRRect(
      borderRadius: effectiveBorderRadius,
      child: Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        colorBlendMode: colorBlendMode,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _defaultErrorWidget(),
      ),
    );
  }

  Widget _defaultPlaceholder() {
    return D2YShimmer.rectangular(
      width: width ?? double.infinity,
      height: height ?? 200,
      borderRadius: borderRadius,
    );
  }

  Widget _defaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: AppColor.grey200,
      child: const Icon(
        Icons.broken_image_outlined,
        color: AppColor.grey500,
        size: AppConstants.iconLG,
      ),
    );
  }

  // Factory constructors for common use cases
  static Widget circular({
    required String imageUrl,
    required double size,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return D2YImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      fit: fit,
      borderRadius: BorderRadius.circular(size / 2),
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }

  static Widget square({
    required String imageUrl,
    required double size,
    double borderRadius = AppConstants.radiusMD,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return D2YImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      fit: fit,
      borderRadius: BorderRadius.circular(borderRadius),
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }

  static Widget rectangle({
    required String imageUrl,
    required double width,
    required double height,
    double borderRadius = AppConstants.radiusMD,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return D2YImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      borderRadius: BorderRadius.circular(borderRadius),
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }
}