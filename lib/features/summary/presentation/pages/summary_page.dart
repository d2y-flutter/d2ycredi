// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_loading.dart';
import '../../../../injection_container.dart';
import '../bloc/summary_bloc.dart';
import '../bloc/summary_event.dart';
import '../bloc/summary_state.dart';
import '../widgets/monthly_summary_item.dart';
import '../widgets/summary_header_card.dart';
import '../widgets/summary_stats_card.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SummaryBloc(
        getSummaryStatsUseCase: getIt(),
        summaryRepository: getIt(),
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
        title: Text(
          'Ringkasan',
          style: AppTextStyles.h5.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<SummaryBloc, SummaryState>(
            builder: (context, state) {
              if (state is! SummaryLoaded) {
                return const SizedBox(width: 48);
              }

              return IconButton(
                icon: const Icon(Icons.calendar_today, color: AppColor.primary),
                onPressed: () {
                  _showYearPicker(context, state);
                },
              );
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
                  const SizedBox(height: AppConstants.spaceLG),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SummaryBloc>().add(LoadSummaryStats());
                    },
                    child: const Text('Coba Lagi'),
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
    // Group monthly data by year
    final Map<int, List<dynamic>> groupedByYear = {};
    for (var summary in state.stats.monthlyData) {
      if (!groupedByYear.containsKey(summary.year)) {
        groupedByYear[summary.year] = [];
      }
      groupedByYear[summary.year]!.add(summary);
    }

    // Sort years descending
    final sortedYears = groupedByYear.keys.toList()..sort((a, b) => b.compareTo(a));

    return RefreshIndicator.adaptive(
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

          // Monthly History by Year
          if (state.stats.monthlyData.isEmpty)
            SliverFillRemaining(
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
                      'Belum ada riwayat transaksi',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...sortedYears.map((year) {
              final yearData = groupedByYear[year]!;
              
              return SliverList(
                delegate: SliverChildListDelegate([
                  // Year divider/header would go here if needed
                  ...yearData.map((summary) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Month/Year header
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingLG,
                          ),
                          child: Text(
                            '${summary.month} ${summary.year}',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColor.textSecondary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppConstants.spaceMD),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingLG,
                          ),
                          child: MonthlySummaryItem(summary: summary),
                        ),
                        const SizedBox(height: AppConstants.spaceLG),
                      ],
                    );
                  }).toList(),
                ]),
              );
            }).toList(),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppConstants.spaceXXL),
          ),
        ],
      ),
    );
  }

  void _showYearPicker(BuildContext context, SummaryLoaded state) {
    // Get available years from data
    final availableYears = state.stats.monthlyData
        .map((m) => m.year)
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    // If no data, show current year and previous years
    if (availableYears.isEmpty) {
      final currentYear = DateTime.now().year;
      availableYears.addAll([currentYear, currentYear - 1, currentYear - 2]);
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      builder: (modalContext) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pilih Tahun',
                  style: AppTextStyles.h6.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tahun saat ini: ${state.selectedYear}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spaceLG),
            ...availableYears.map((year) {
              final isSelected = year == state.selectedYear;
              return ListTile(
                title: Text(
                  year.toString(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: isSelected ? AppColor.primary : AppColor.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check, color: AppColor.primary)
                    : const Icon(Icons.chevron_right),
                onTap: () {
                  context.read<SummaryBloc>().add(ChangeSelectedYear(year));
                  Navigator.pop(modalContext);
                },
              );
            }).toList(),
            const SizedBox(height: AppConstants.spaceLG),
          ],
        ),
      ),
    );
  }
}
