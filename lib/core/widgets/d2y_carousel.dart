import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../config/app_color.dart';
import '../config/app_constants.dart';
import 'd2y_image.dart';

class D2YCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final bool enableInfiniteScroll;
  final double viewportFraction;
  final bool enlargeCenterPage;
  final Function(int)? onPageChanged;
  final bool showIndicator;
  final Color? indicatorColor;
  final Color? activeIndicatorColor;
  final double borderRadius;
  final BoxFit imageFit;
  final bool enableZoom;

  const D2YCarousel({
    super.key,
    required this.images,
    this.height = 200.0,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.enableInfiniteScroll = true,
    this.viewportFraction = 1.0,
    this.enlargeCenterPage = false,
    this.onPageChanged,
    this.showIndicator = true,
    this.indicatorColor,
    this.activeIndicatorColor,
    this.borderRadius = AppConstants.radiusMD,
    this.imageFit = BoxFit.cover,
    this.enableZoom = false,
  });

  @override
  State<D2YCarousel> createState() => _D2YCarouselState();
}

class _D2YCarouselState extends State<D2YCarousel> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: const Center(
          child: Text('No images'),
        ),
      );
    }

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: widget.enableZoom
                  ? () => _showFullImage(context, index)
                  : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: D2YImage(
                  imageUrl: widget.images[index],
                  width: double.infinity,
                  height: widget.height,
                  fit: widget.imageFit,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.height,
            autoPlay: widget.autoPlay,
            autoPlayInterval: widget.autoPlayInterval,
            enableInfiniteScroll: widget.enableInfiniteScroll,
            viewportFraction: widget.viewportFraction,
            enlargeCenterPage: widget.enlargeCenterPage,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              widget.onPageChanged?.call(index);
            },
          ),
        ),
        if (widget.showIndicator && widget.images.length > 1) ...[
          const SizedBox(height: AppConstants.spaceMD),
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: widget.images.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: widget.activeIndicatorColor ?? AppColor.primary,
              dotColor: widget.indicatorColor ?? AppColor.grey300,
              expansionFactor: 3,
              spacing: 4,
            ),
            onDotClicked: (index) {
              _controller.animateToPage(index);
            },
          ),
        ],
      ],
    );
  }

  void _showFullImage(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenCarousel(
          images: widget.images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

class _FullScreenCarousel extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenCarousel({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenCarousel> createState() => _FullScreenCarouselState();
}

class _FullScreenCarouselState extends State<_FullScreenCarousel> {
  late int _currentIndex;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${_currentIndex + 1}/${widget.images.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            return InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: D2YImage(
                imageUrl: widget.images[index],
                fit: BoxFit.contain,
              ),
            );
          },
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1.0,
            initialPage: widget.initialIndex,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}