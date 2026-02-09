// ignore_for_file: use_build_context_synchronously

import 'package:d2ycredi/core/routes/app_routes.dart';
import 'package:d2ycredi/core/utils/avatar_color_utils.dart';
import 'package:d2ycredi/core/utils/helpers.dart';
import 'package:d2ycredi/core/widgets/d2y_modal.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_event.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_state.dart';
import 'package:d2ycredi/features/debt/presentation/widgets/debt_filter_chip.dart';
import 'package:d2ycredi/features/debt/presentation/widgets/debt_summary_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/d2y_loading.dart';
import '../../../../core/widgets/d2y_no_data.dart';
import '../../../../core/widgets/d2y_slideable.dart';
import '../../../../core/widgets/d2y_toast.dart';
import '../../domain/entities/debt.dart';

class DebtListPage extends StatefulWidget {
  const DebtListPage({super.key});

  @override
  State<DebtListPage> createState() => _DebtListPageState();
}

class _DebtListPageState extends State<DebtListPage> {
  @override
  void initState() {
    super.initState();
    context.read<DebtBloc>().add(LoadDebts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DebtBloc, DebtState>(
          listener: (context, state) {
            if (state is DebtError) {
              D2YToast.error(context, state.message);
            } else if (state is DebtActionSuccess) {
              D2YToast.success(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is DebtLoading) {
              return D2YLoading.center();
            }

            if (state is DebtError) {
              return D2YNoData.error(
                message: state.message,
                onAction: () => context.read<DebtBloc>().add(LoadDebts()),
              );
            }

            if (state is DebtLoaded) {
              return _buildContent(state);
            }

            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.addDebt);
        },
        backgroundColor: AppColor.primary,
        child: const Icon(Icons.add, color: AppColor.white),
      ),
    );
  }

  Widget _buildContent(DebtLoaded state) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<DebtBloc>().add(LoadDebts());
      },
      color: AppColor.primary,
      child: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),

          // Summary Card
          SliverToBoxAdapter(
            child: DebtSummaryCard(summary: state.summary),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.spaceLG),
          ),

          // Filter and Title
          SliverToBoxAdapter(
            child: _buildFilterSection(state),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.spaceMD),
          ),

          // Debt List
          state.filteredDebts.isEmpty
              ? SliverFillRemaining(
                  child: D2YNoData.empty(
                    title: 'Tidak ada data',
                    message: 'Belum ada daftar utang',
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLG,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final debt = state.filteredDebts[index];
                        return _buildDebtItem(debt);
                      },
                      childCount: state.filteredDebts.length,
                    ),
                  ),
                ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingLG),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'app_name'.tr().toUpperCase(),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColor.textSecondary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: AppConstants.spaceXS),
                Text(
                  'debt.title'.tr(),
                  style: AppTextStyles.h3.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context.push("/settings");
            },
            icon: const Icon(
              CupertinoIcons.settings,
              color: AppColor.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(DebtLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'common.latest_transaction'.tr(),
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColor.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              TextButton(
                onPressed: () {
                  // View all
                },
                child: Text(
                  'common.see_all'.tr(),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spaceMD),
          Row(
            children: [
              DebtFilterChip(
                label: 'Semua',
                isSelected: state.filterStatus == null,
                onTap: () {
                  context.read<DebtBloc>().add(const FilterDebts(null));
                },
              ),
              const SizedBox(width: AppConstants.spaceSM),
              DebtFilterChip(
                label: 'Belum Lunas',
                isSelected: state.filterStatus == DebtStatus.belum,
                color: AppColor.statusBelum,
                onTap: () {
                  context
                      .read<DebtBloc>()
                      .add(const FilterDebts(DebtStatus.belum));
                },
              ),
              const SizedBox(width: AppConstants.spaceSM),
              DebtFilterChip(
                label: 'Lunas',
                isSelected: state.filterStatus == DebtStatus.lunas,
                color: AppColor.statusLunas,
                onTap: () {
                  context
                      .read<DebtBloc>()
                      .add(const FilterDebts(DebtStatus.lunas));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDebtItem(Debt debt) {
    final isLunas = debt.status == DebtStatus.lunas;
    final statusColor = isLunas ? AppColor.statusLunas : AppColor.statusBelum;
    final statusBgColor =
        isLunas ? AppColor.statusLunasLight : AppColor.statusBelumLight;

    final bgColor =
        AvatarColorUtils.backgroundFromName(debt.borrowerName);
    final textColor =
        AvatarColorUtils.textColorFromBackground(bgColor);

    return D2YSlideable(
      endActions: [
        D2YSlideAction(
          icon: Icons.delete_outline,
          label: 'Hapus',
          backgroundColor: AppColor.error,
          onPressed: () {
            _showDeleteConfirmation(debt);
          },
        ),
      ],
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.spaceMD),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          border: Border.all(
            color: isLunas ? AppColor.statusLunas.withOpacity(0.2) : AppColor.border,
            width: isLunas ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.push('${AppRoutes.detailDebt}/${debt.id}');
            },
            borderRadius: BorderRadius.circular(AppConstants.radiusLG),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLG),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: bgColor,
                    child: Text(
                      Helpers.getInitials(debt.borrowerName),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: AppConstants.spaceMD),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                debt.borrowerName,
                                style: AppTextStyles.h6.copyWith(
                                  color: AppColor.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.paddingSM,
                                vertical: AppConstants.paddingXS,
                              ),
                              decoration: BoxDecoration(
                                color: statusBgColor,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusLG,
                                ),
                              ),
                              child: Text(
                                isLunas ? 'LUNAS' : 'BELUM',
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.spaceXS),
                        Text(
                          Formatters.currency(
                            debt.amount,
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ),
                          style: AppTextStyles.h5.copyWith(
                            color: isLunas ? AppColor.statusLunas : AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spaceXS),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: AppColor.textSecondary,
                            ),
                            const SizedBox(width: AppConstants.spaceXS),
                            Text(
                              'Jatuh Tempo: ${DateFormat('dd MMM yyyy', 'id').format(debt.dueDate)}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(Debt debt) async {
    final confirmed = await D2YModal.confirm(
      context: context,
      title: 'debt.delete'.tr(),
      message: 'debt.delete_confirm'.tr(args: [debt.borrowerName]),
      confirmText: 'Hapus',
      cancelText: 'Batal',
    );

    if (confirmed == true) {
      context.read<DebtBloc>().add(DeleteDebt(debt.id));
    }
  }
}