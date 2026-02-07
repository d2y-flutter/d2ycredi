import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';

class D2YShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final bool enabled;

  const D2YShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColor.shimmerBase,
      highlightColor: highlightColor ?? AppColor.shimmerHighlight,
      child: child,
    );
  }

  // Rectangular shimmer
  static Widget rectangular({
    double? width,
    double? height = 200,
    BorderRadius? borderRadius,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return D2YShimmer(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.radiusMD),
        ),
      ),
    );
  }

  // Circular shimmer
  static Widget circular({
    required double size,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return D2YShimmer(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  // Text line shimmer
  static Widget textLine({
    double? width,
    double height = 16,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return D2YShimmer(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusXS),
        ),
      ),
    );
  }

  // Multiple text lines
  static Widget textLines({
    int lines = 3,
    double spacing = AppConstants.spaceSM,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        lines,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index < lines - 1 ? spacing : 0),
          child: D2YShimmer.textLine(
            width: index == lines - 1 ? 200 : double.infinity,
            baseColor: baseColor,
            highlightColor: highlightColor,
          ),
        ),
      ),
    );
  }

  // List tile shimmer
  static Widget listTile({
    bool showLeading = true,
    bool showTrailing = false,
    int titleLines = 1,
    int subtitleLines = 1,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLG,
        vertical: AppConstants.paddingMD,
      ),
      child: Row(
        children: [
          if (showLeading) ...[
            D2YShimmer.circular(
              size: AppConstants.avatarMD,
              baseColor: baseColor,
              highlightColor: highlightColor,
            ),
            const SizedBox(width: AppConstants.spaceMD),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                D2YShimmer.textLine(
                  width: 150,
                  height: 16,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                ),
                if (subtitleLines > 0) ...[
                  const SizedBox(height: AppConstants.spaceSM),
                  ...List.generate(
                    subtitleLines,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: index < subtitleLines - 1 ? AppConstants.spaceXS : 0,
                      ),
                      child: D2YShimmer.textLine(
                        width: index == subtitleLines - 1 ? 100 : double.infinity,
                        height: 14,
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showTrailing) ...[
            const SizedBox(width: AppConstants.spaceMD),
            D2YShimmer.rectangular(
              width: 60,
              height: 30,
              baseColor: baseColor,
              highlightColor: highlightColor,
            ),
          ],
        ],
      ),
    );
  }

  // Card shimmer
  static Widget card({
    double? width,
    double height = 200,
    bool showImage = true,
    int titleLines = 1,
    int contentLines = 2,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(color: AppColor.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showImage)
            D2YShimmer.rectangular(
              width: width,
              height: height * 0.6,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusMD),
              ),
              baseColor: baseColor,
              highlightColor: highlightColor,
            ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  titleLines,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      bottom: index < titleLines - 1 ? AppConstants.spaceXS : AppConstants.spaceSM,
                    ),
                    child: D2YShimmer.textLine(
                      width: 150,
                      height: 18,
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                    ),
                  ),
                ),
                ...List.generate(
                  contentLines,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      bottom: index < contentLines - 1 ? AppConstants.spaceXS : 0,
                    ),
                    child: D2YShimmer.textLine(
                      width: index == contentLines - 1 ? 100 : double.infinity,
                      height: 14,
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Grid shimmer
  static Widget grid({
    int crossAxisCount = 2,
    int itemCount = 6,
    double childAspectRatio = 1.0,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: AppConstants.spaceMD,
        mainAxisSpacing: AppConstants.spaceMD,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return D2YShimmer.card(
          showImage: true,
          titleLines: 1,
          contentLines: 1,
          baseColor: baseColor,
          highlightColor: highlightColor,
        );
      },
    );
  }

  // List shimmer
  static Widget list({
    int itemCount = 5,
    bool showLeading = true,
    bool showTrailing = false,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return D2YShimmer.listTile(
          showLeading: showLeading,
          showTrailing: showTrailing,
          baseColor: baseColor,
          highlightColor: highlightColor,
        );
      },
    );
  }
}