import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';
import 'd2y_loading.dart';

class D2YImagePreview {
  // Show single image preview
  static Future<void> show({
    required BuildContext context,
    required String imageUrl,
    String? heroTag,
    Color? backgroundColor,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _D2YImagePreviewScreen(
          imageUrls: [imageUrl],
          initialIndex: 0,
          heroTag: heroTag,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }

  // Show multiple images gallery
  static Future<void> showGallery({
    required BuildContext context,
    required List<String> imageUrls,
    int initialIndex = 0,
    List<String>? heroTags,
    Color? backgroundColor,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _D2YImagePreviewScreen(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
          heroTags: heroTags,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}

class _D2YImagePreviewScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final String? heroTag;
  final List<String>? heroTags;
  final Color? backgroundColor;

  const _D2YImagePreviewScreen({
    required this.imageUrls,
    required this.initialIndex,
    this.heroTag,
    this.heroTags,
    this.backgroundColor,
  });

  @override
  State<_D2YImagePreviewScreen> createState() => _D2YImagePreviewScreenState();
}

class _D2YImagePreviewScreenState extends State<_D2YImagePreviewScreen> {
  late PageController _pageController;
  late int _currentIndex;
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleAppBar() {
    setState(() {
      _showAppBar = !_showAppBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? Colors.black,
      extendBodyBehindAppBar: true,
      appBar: _showAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: widget.imageUrls.length > 1
                  ? Text(
                      '${_currentIndex + 1}/${widget.imageUrls.length}',
                      style: const TextStyle(color: Colors.white),
                    )
                  : null,
              actions: [
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    // Implement share functionality
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.white),
                  onPressed: () {
                    // Implement download functionality
                  },
                ),
              ],
            )
          : null,
      body: GestureDetector(
        onTap: _toggleAppBar,
        child: widget.imageUrls.length == 1
            ? _buildSingleImage()
            : _buildGallery(),
      ),
    );
  }

  Widget _buildSingleImage() {
    final imageUrl = widget.imageUrls.first;
    final heroTag = widget.heroTag;

    Widget imageWidget = PhotoView(
      imageProvider: CachedNetworkImageProvider(imageUrl),
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 3,
      initialScale: PhotoViewComputedScale.contained,
      loadingBuilder: (context, event) => Center(
        child: D2YLoading(),
      ),
      errorBuilder: (context, error, stackTrace) => const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Colors.white,
          size: 100,
        ),
      ),
    );

    if (heroTag != null) {
      return Hero(
        tag: heroTag,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildGallery() {
    return PhotoViewGallery.builder(
      pageController: _pageController,
      itemCount: widget.imageUrls.length,
      builder: (context, index) {
        final imageUrl = widget.imageUrls[index];
        final heroTag = widget.heroTags?[index];

        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 3,
          initialScale: PhotoViewComputedScale.contained,
          heroAttributes: heroTag != null
              ? PhotoViewHeroAttributes(tag: heroTag)
              : null,
        );
      },
      loadingBuilder: (context, event) => Center(
        child: D2YLoading(),
      ),
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      scrollPhysics: const BouncingScrollPhysics(),
      backgroundDecoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.black,
      ),
    );
  }
}

// Image preview widget (inline preview)
class D2YImagePreviewWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? heroTag;
  final VoidCallback? onTap;

  const D2YImagePreviewWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.heroTag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.radiusMD),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: AppColor.grey200,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: AppColor.grey200,
          child: const Icon(Icons.broken_image_outlined),
        ),
      ),
    );

    if (heroTag != null) {
      image = Hero(tag: heroTag!, child: image);
    }

    return GestureDetector(
      onTap: onTap ??
          () {
            D2YImagePreview.show(
              context: context,
              imageUrl: imageUrl,
              heroTag: heroTag,
            );
          },
      child: image,
    );
  }
}

// Image gallery preview widget
class D2YImageGalleryPreview extends StatelessWidget {
  final List<String> imageUrls;
  final double itemHeight;
  final double itemWidth;
  final int maxVisible;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final List<String>? heroTags;

  const D2YImageGalleryPreview({
    super.key,
    required this.imageUrls,
    this.itemHeight = 100,
    this.itemWidth = 100,
    this.maxVisible = 4,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.heroTags,
  });

  @override
  Widget build(BuildContext context) {
    final visibleImages = imageUrls.take(maxVisible).toList();
    final remaining = imageUrls.length - maxVisible;

    return Wrap(
      spacing: AppConstants.spaceSM,
      runSpacing: AppConstants.spaceSM,
      children: [
        ...List.generate(visibleImages.length, (index) {
          return GestureDetector(
            onTap: () {
              D2YImagePreview.showGallery(
                context: context,
                imageUrls: imageUrls,
                initialIndex: index,
                heroTags: heroTags,
              );
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: borderRadius ??
                      BorderRadius.circular(AppConstants.radiusMD),
                  child: CachedNetworkImage(
                    imageUrl: visibleImages[index],
                    width: itemWidth,
                    height: itemHeight,
                    fit: fit,
                    placeholder: (context, url) => Container(
                      width: itemWidth,
                      height: itemHeight,
                      color: AppColor.grey200,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: itemWidth,
                      height: itemHeight,
                      color: AppColor.grey200,
                      child: const Icon(Icons.broken_image_outlined),
                    ),
                  ),
                ),
                if (index == maxVisible - 1 && remaining > 0)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: borderRadius ??
                            BorderRadius.circular(AppConstants.radiusMD),
                      ),
                      child: Center(
                        child: Text(
                          '+$remaining',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }
}