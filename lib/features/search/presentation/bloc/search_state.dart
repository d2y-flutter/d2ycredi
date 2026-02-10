import 'package:equatable/equatable.dart';
import '../../../debt/domain/entities/debt.dart';
import '../../domain/entities/search_history.dart';

class SearchState extends Equatable {
  final List<Debt> searchResults;
  final List<SearchHistory> searchHistory;
  final String currentQuery;
  final SearchCategory selectedCategory;
  final bool isSearching;
  final bool isLoading;
  final String? errorMessage;

  const SearchState({
    this.searchResults = const [],
    this.searchHistory = const [],
    this.currentQuery = '',
    this.selectedCategory = SearchCategory.all,
    this.isSearching = false,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        searchResults,
        searchHistory,
        currentQuery,
        selectedCategory,
        isSearching,
        isLoading,
        errorMessage,
      ];

  SearchState copyWith({
    List<Debt>? searchResults,
    List<SearchHistory>? searchHistory,
    String? currentQuery,
    SearchCategory? selectedCategory,
    bool? isSearching,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SearchState(
      searchResults: searchResults ?? this.searchResults,
      searchHistory: searchHistory ?? this.searchHistory,
      currentQuery: currentQuery ?? this.currentQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isSearching: isSearching ?? this.isSearching,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  List<Debt> get filteredResults {
    if (selectedCategory == SearchCategory.all) {
      return searchResults;
    }

    return searchResults.where((debt) {
      switch (selectedCategory) {
        case SearchCategory.jatuhTempo:
          return debt.status == DebtStatus.belum &&
                 debt.dueDate.isBefore(DateTime.now().add(const Duration(days: 7)));
        case SearchCategory.lunas:
          return debt.status == DebtStatus.lunas;
        default:
          return true;
      }
    }).toList();
  }
}