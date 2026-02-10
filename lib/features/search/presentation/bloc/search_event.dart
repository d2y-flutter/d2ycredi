import 'package:equatable/equatable.dart';
import '../../domain/entities/search_history.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class LoadSearchHistory extends SearchEvent {}

class SearchDebts extends SearchEvent {
  final String query;

  const SearchDebts(this.query);

  @override
  List<Object?> get props => [query];
}

class SelectSearchHistory extends SearchEvent {
  final String query;

  const SelectSearchHistory(this.query);

  @override
  List<Object?> get props => [query];
}

class DeleteSearchHistoryItem extends SearchEvent {
  final String id;

  const DeleteSearchHistoryItem(this.id);

  @override
  List<Object?> get props => [id];
}

class ClearAllSearchHistory extends SearchEvent {}

class FilterByCategory extends SearchEvent {
  final SearchCategory category;

  const FilterByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class ClearSearch extends SearchEvent {}