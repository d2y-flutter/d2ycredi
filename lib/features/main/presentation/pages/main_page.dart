import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/routes/app_routes.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({
    super.key,
    required this.child,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.home)) return 0;
    if (location.startsWith(AppRoutes.summary)) return 1;
    return 0;
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.summary);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarySurface,
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColor.primarySurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLG,
              vertical: AppConstants.paddingSM,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: Iconsax.home_1,
                  activeIcon: Iconsax.home_1,
                  label: 'BERANDA',
                  isActive: _getCurrentIndex(context) == 0,
                  onTap: () => _onItemTapped(0),
                ),
                _NavBarItem(
                  icon: Iconsax.note,
                  activeIcon: Iconsax.note,
                  label: 'LAPORAN',
                  isActive: _getCurrentIndex(context) == 1,
                  onTap: () => _onItemTapped(1),
                ),
                // _NavBarItem(
                //   icon: Icons.contacts_outlined,
                //   activeIcon: Icons.contacts,
                //   label: 'KONTAK',
                //   isActive: _getCurrentIndex(context) == 2,
                //   onTap: () => _onItemTapped(2),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            color: isActive ? AppColor.primary : AppColor.grey500,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColor.primary : AppColor.grey500,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}