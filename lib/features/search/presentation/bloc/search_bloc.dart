import 'package:d2ycredi/features/search/domain/entities/search_history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/search_debts_usecase.dart';
import '../../domain/usecases/get_search_history_usecase.dart';
import '../../domain/repositories/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchDebtsUseCase searchDebtsUseCase;
  final GetSearchHistoryUseCase getSearchHistoryUseCase;
  final SearchRepository searchRepository;

  SearchBloc({
    required this.searchDebtsUseCase,
    required this.getSearchHistoryUseCase,
    required this.searchRepository,
  }) : super(const SearchState()) {
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<SearchDebts>(_onSearchDebts);
    on<SelectSearchHistory>(_onSelectSearchHistory);
    on<DeleteSearchHistoryItem>(_onDeleteSearchHistoryItem);
    on<ClearAllSearchHistory>(_onClearAllSearchHistory);
    on<FilterByCategory>(_onFilterByCategory);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onLoadSearchHistory(
    LoadSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    final result = await getSearchHistoryUseCase(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (history) => emit(state.copyWith(searchHistory: history)),
    );
  }

  Future<void> _onSearchDebts(
    SearchDebts event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(state.copyWith(
        searchResults: [],
        currentQuery: '',
        isSearching: false,
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      currentQuery: event.query,
      isSearching: true,
    ));

    // Add to search history
    await searchRepository.addSearchHistory(event.query);

    final result = await searchDebtsUseCase(
      SearchDebtsParams(query: event.query),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (results) {
        emit(state.copyWith(
          searchResults: results,
          isLoading: false,
        ));
        // Reload history
        add(LoadSearchHistory());
      },
    );
  }

  Future<void> _onSelectSearchHistory(
    SelectSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    add(SearchDebts(event.query));
  }

  Future<void> _onDeleteSearchHistoryItem(
    DeleteSearchHistoryItem event,
    Emitter<SearchState> emit,
  ) async {
    await searchRepository.deleteSearchHistory(event.id);
    add(LoadSearchHistory());
  }

  Future<void> _onClearAllSearchHistory(
    ClearAllSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    await searchRepository.clearSearchHistory();
    emit(state.copyWith(searchHistory: []));
  }

  void _onFilterByCategory(
    FilterByCategory event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(
      searchResults: [],
      currentQuery: '',
      isSearching: false,
      selectedCategory: SearchCategory.all,
    ));
  }
}