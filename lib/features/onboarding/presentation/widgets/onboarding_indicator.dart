import 'package:d2ycredi/core/config/app_color.dart';
import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final int length;
  final int currentIndex;

  const OnboardingIndicator({super.key, 
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: currentIndex == index ? 20 : 6,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColor.primary
                : AppColor.grey300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}