import 'package:d2ycredi/core/routes/app_routes.dart';
import 'package:d2ycredi/core/routes/route_guards.dart';
import 'package:d2ycredi/features/onboarding/data/datasources/onboarding_data.dart';
import 'package:d2ycredi/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:d2ycredi/features/onboarding/presentation/widgets/onboarding_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}



class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  Future<void> _onGetStarted() async {
    await RouteGuard.setFirstLaunchCompleted();
    // ignore: use_build_context_synchronously
    context.go(AppRoutes.home);
  }

  void _next() {
    if (_currentIndex == onboardingItems.length - 1) {
      _onGetStarted();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingItems.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (_, index) {
                  return OnboardingContent(
                    item: onboardingItems[index],
                  );
                },
              ),
            ),

            OnboardingIndicator(
              length: onboardingItems.length,
              currentIndex: _currentIndex,
            ),

            const SizedBox(height: AppConstants.spaceLG),

            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLG),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMD),
                    ),
                  ),
                  child: Text(
                    _currentIndex == onboardingItems.length - 1
                        ? 'Mulai Sekarang'
                        : 'Lanjut',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}