import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_constants.dart';
import '../../../../core/config/app_text_styles.dart';
import '../../../../core/widgets/d2y_avatar.dart';
import '../../../../core/widgets/d2y_chip.dart';
import '../../../../core/widgets/d2y_loading.dart';
import '../../../../core/widgets/d2y_no_data.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../injection_container.dart';
import '../../../debt/domain/entities/debt.dart';
import '../../domain/entities/search_history.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/search_history_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        searchDebtsUseCase: getIt(),
        getSearchHistoryUseCase: getIt(),
        searchRepository: getIt(),
      )..add(LoadSearchHistory()),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

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
          'Cari Debitur',
          style: AppTextStyles.h5.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.searchHistory.isEmpty) return const SizedBox(width: 48);

              return PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: AppColor.textPrimary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      context.read<SearchBloc>().add(ClearAllSearchHistory());
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline, size: 20),
                        const SizedBox(width: AppConstants.spaceMD),
                        Text(
                          'Hapus Semua',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: AppColor.white,
            padding: const EdgeInsets.all(AppConstants.paddingLG),
            child: Column(
              children: [
                // Search Field
                TextField(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  decoration: InputDecoration(
                    hintText: 'Budi',
                    prefixIcon: const Icon(Icons.search, color: AppColor.textSecondary),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: AppColor.textSecondary),
                            onPressed: () {
                              _searchController.clear();
                              context.read<SearchBloc>().add(ClearSearch());
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppColor.grey100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingLG,
                      vertical: AppConstants.paddingMD,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                    if (value.isNotEmpty) {
                      context.read<SearchBloc>().add(SearchDebts(value));
                    } else {
                      context.read<SearchBloc>().add(ClearSearch());
                    }
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      context.read<SearchBloc>().add(SearchDebts(value));
                    }
                  },
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return D2YLoading.center(message: 'Mencari...');
                }

                if (state.isSearching) {
                  return _buildSearchResults(state);
                }

                return _buildSearchHistory(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHistory(SearchState state) {
    if (state.searchHistory.isEmpty) {
      return D2YNoData.search(
        message: 'Belum ada riwayat pencarian',
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.spaceLG),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLG,
            ),
            child: Text(
              'PENCARIAN TERAKHIR',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColor.textSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),

          const SizedBox(height: AppConstants.spaceMD),

          ...state.searchHistory.map((history) {
            return SearchHistoryItem(
              history: history,
              onTap: () {
                _searchController.text = history.query;
                context.read<SearchBloc>().add(SelectSearchHistory(history.query));
              },
              onDelete: () {
                context.read<SearchBloc>().add(DeleteSearchHistoryItem(history.id));
              },
            );
          }).toList(),

          const SizedBox(height: AppConstants.spaceXL),
        ],
      ),
    );
  }

  Widget _buildSearchResults(SearchState state) {
    return Column(
      children: [
        // Category Filter
        Container(
          color: AppColor.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLG,
            vertical: AppConstants.paddingMD,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'KATEGORI POPULER',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColor.textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    'Hapus Semua',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spaceMD),
              Row(
                children: SearchCategory.values.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppConstants.spaceSM),
                    child: D2YChip(
                      label: category.displayName,
                      selected: state.selectedCategory == category,
                      onTap: () {
                        context.read<SearchBloc>().add(FilterByCategory(category));
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppConstants.spaceMD),

        // Results
        Expanded(
          child: state.filteredResults.isEmpty
              ? D2YNoData.search(
                  message: 'Tidak ada hasil untuk "${state.currentQuery}"',
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLG,
                  ),
                  itemCount: state.filteredResults.length,
                  itemBuilder: (context, index) {
                    final debt = state.filteredResults[index];
                    return _buildDebtItem(debt);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDebtItem(Debt debt) {
    final isLunas = debt.status == DebtStatus.lunas;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spaceMD),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        border: Border.all(color: AppColor.border, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.push('/debt/detail/${debt.id}');
          },
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLG),
            child: Row(
              children: [
                // Avatar
                D2YAvatar(
                  imageUrl: debt.borrowerAvatar,
                  name: debt.borrowerName,
                  size: 48,
                ),

                const SizedBox(width: AppConstants.spaceMD),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        debt.borrowerName,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spaceXS),
                      Text(
                        'Jatuh tempo: ${DateFormat('dd MMM yyyy', 'id').format(debt.dueDate)}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Amount & Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Formatters.currency(debt.amount, symbol: 'Rp ', decimalDigits: 0),
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: isLunas ? AppColor.statusLunas : AppColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spaceXS),
                    Icon(
                      Icons.close,
                      color: AppColor.textSecondary,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}