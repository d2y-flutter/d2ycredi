import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_loading.dart';
import '../../../../injection_container.dart';
import '../bloc/summary_bloc.dart';
import '../bloc/summary_event.dart';
import '../bloc/summary_state.dart';
import '../widgets/summary_header_card.dart';
import '../widgets/summary_stats_card.dart';
import '../widgets/monthly_summary_item.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SummaryBloc(
        getSummaryStatsUseCase: getIt(),
      )..add(LoadSummaryStats()),
      child: const SummaryView(),
    );
  }
}

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Ringkasan',
          style: AppTextStyles.h5.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: AppColor.primary),
            onPressed: () {
              _showYearPicker(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<SummaryBloc, SummaryState>(
        builder: (context, state) {
          if (state is SummaryLoading) {
            return D2YLoading.center(message: 'Memuat ringkasan...');
          }

          if (state is SummaryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColor.error,
                  ),
                  const SizedBox(height: AppConstants.spaceLG),
                  Text(
                    state.message,
                    style: AppTextStyles.bodyLarge,
                  ),
                ],
              ),
            );
          }

          if (state is SummaryLoaded) {
            return _buildContent(context, state);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, SummaryLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SummaryBloc>().add(LoadSummaryStats());
      },
      color: AppColor.primary,
      child: CustomScrollView(
        slivers: [
          // Header Card
          SliverToBoxAdapter(
            child: SummaryHeaderCard(stats: state.stats),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.spaceLG),
          ),

          // Stats Cards
          SliverToBoxAdapter(
            child: SummaryStatsCard(stats: state.stats),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.spaceXL),
          ),

          // Monthly History Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingLG,
              ),
              child: Text(
                state.stats.monthlyData.isNotEmpty
                    ? state.stats.monthlyData.first.month.toUpperCase()
                    : 'RIWAYAT BULANAN',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColor.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.spaceMD),
          ),

          // Monthly History List
          state.stats.monthlyData.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 64,
                          color: AppColor.grey400,
                        ),
                        const SizedBox(height: AppConstants.spaceLG),
                        Text(
                          'Belum ada riwayat',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLG,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final summary = state.stats.monthlyData[index];
                        return MonthlySummaryItem(summary: summary);
                      },
                      childCount: state.stats.monthlyData.length,
                    ),
                  ),
                ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.spaceXXL),
          ),
        ],
      ),
    );
  }

  void _showYearPicker(BuildContext context) {
    final currentYear = DateTime.now().year;
    final years = List.generate(5, (index) => currentYear - index);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Tahun',
              style: AppTextStyles.h6.copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spaceLG),
            ...years.map((year) {
              return ListTile(
                title: Text(
                  year.toString(),
                  style: AppTextStyles.bodyLarge,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.read<SummaryBloc>().add(ChangeSelectedYear(year));
                  Navigator.pop(context);
                },
              );
            // ignore: unnecessary_to_list_in_spreads
            }).toList(),
            const SizedBox(height: AppConstants.spaceLG),
          ],
        ),
      ),
    );
  }
}