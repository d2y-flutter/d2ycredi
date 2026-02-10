import 'package:flutter/material.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/search_history.dart';

class SearchHistoryItem extends StatelessWidget {
  final SearchHistory history;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const SearchHistoryItem({
    Key? key,
    required this.history,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLG,
        vertical: AppConstants.spaceXS,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        border: Border.all(color: AppColor.border, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLG,
              vertical: AppConstants.paddingMD,
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColor.grey100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.history,
                    color: AppColor.textSecondary,
                    size: 20,
                  ),
                ),

                const SizedBox(width: AppConstants.spaceMD),

                // Query & Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        history.query,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppConstants.spaceXS),
                      Text(
                        history.timestamp.timeAgo(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: AppConstants.spaceMD),

                // Delete Button
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.close,
                    color: AppColor.textSecondary,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}