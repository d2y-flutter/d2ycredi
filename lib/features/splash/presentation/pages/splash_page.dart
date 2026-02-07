// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/routes/route_guards.dart';
import '../../../../core/widgets/d2y_loading.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToNext();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final isFirstLaunch = await RouteGuard.isFirstLaunch();
    final isAuthenticated = await RouteGuard.isAuthenticated();

    if (isFirstLaunch) {
      context.go(AppRoutes.onboarding);
    } else if (isAuthenticated) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.primary,
              AppColor.primaryDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                // Animated Logo
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.wallet,
                          size: 80,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.spaceXXL),

                // App Name
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'D2YCREDI',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.spaceMD),

                // Tagline
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Smart logs for smarter finances.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.white.withOpacity(0.9),
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const Spacer(),

                // Loading Indicator
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: D2YLoading(
                    color: AppColor.white,
                    size: AppConstants.iconLG,
                  ),
                ),

                const SizedBox(height: AppConstants.spaceXXL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}