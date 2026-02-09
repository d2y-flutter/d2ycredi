import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLG,
          ),
          child: Text(
            title,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColor.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spaceMD),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLG,
          ),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusLG),
            border: Border.all(color: AppColor.border, width: 1),
          ),
          child: Column(
            children: _buildChildrenWithDividers(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    final List<Widget> items = [];
    
    for (int i = 0; i < children.length; i++) {
      items.add(children[i]);
      
      // Add divider between items (not after the last one)
      if (i < children.length - 1) {
        items.add(
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLG,
            ),
            child: Divider(height: 1),
          ),
        );
      }
    }
    
    return items;
  }
}