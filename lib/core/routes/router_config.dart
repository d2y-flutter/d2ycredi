import 'package:d2ycredi/features/debt/presentation/pages/add_debt_page.dart';
import 'package:d2ycredi/features/debt/presentation/pages/debt_detail_page.dart';
import 'package:d2ycredi/features/debt/presentation/pages/debt_list_page.dart';
import 'package:d2ycredi/features/debt/presentation/pages/edit_debt_page.dart';
import 'package:d2ycredi/features/main/presentation/pages/main_page.dart';
import 'package:d2ycredi/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:d2ycredi/features/reminder/presentation/pages/set_reminder_page.dart';
import 'package:d2ycredi/features/splash/presentation/pages/splash_page.dart';
import 'package:d2ycredi/features/summary/presentation/pages/summary_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/app_config.dart';
import 'app_routes.dart';

class RouterConfig {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
  GlobalKey<NavigatorState>();

  static GoRouter createRouter(String? initialDeepLink) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: initialDeepLink ?? '/',
      debugLogDiagnostics: AppConfig.enableDebugMode,
      // redirect: _handleRedirect,
      routes: [
        // Public Routes (No Auth Required)
        GoRoute(
          path: AppRoutes.splash,
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: AppRoutes.onboarding,
          name: 'onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        
        GoRoute(
          path: AppRoutes.addDebt,
          name: 'addDebt',
          builder: (context, state) => const AddDebtPage(),
        ),
        GoRoute(
          path: '${AppRoutes.detailDebt}/:id',
          name: 'debtDetail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return DebtDetailPage(debtId: id);
          },
        ),
        GoRoute(
          path: '${AppRoutes.editDebt}/:id',
          name: 'editDebt',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return EditDebtPage(debtId: id);
          },
        ),
        GoRoute(
          path: '${AppRoutes.setReminder}/:id',
          name: 'setReminder',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return SetReminderPage(debtId: id);
          },
        ),

        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return MainPage(child: child);
          },
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              pageBuilder: (context, state) => NoTransitionPage(
                child: const DebtListPage(),
              ),
            ),
            GoRoute(
              path: AppRoutes.summary,
              name: 'summary',
              pageBuilder: (context, state) => NoTransitionPage(
                child: const SummaryPage(),
              ),
            ),
            GoRoute(
              path: AppRoutes.profile,
              name: 'profile',
              pageBuilder: (context, state) => NoTransitionPage(
                child: const DebtListPage(),
              ),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => ErrorPage(error: state.error),
    );
  }
}

// Error Page
class ErrorPage extends StatelessWidget {
  final Exception? error;

  const ErrorPage({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 100, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Page not found', style: TextStyle(fontSize: 20)),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(error.toString(), style: const TextStyle(fontSize: 14)),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}