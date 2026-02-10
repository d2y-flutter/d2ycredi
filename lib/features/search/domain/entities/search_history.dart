import 'package:equatable/equatable.dart';

class SearchHistory extends Equatable {
  final String id;
  final String query;
  final DateTime timestamp;

  const SearchHistory({
    required this.id,
    required this.query,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, query, timestamp];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'query': query,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory SearchHistory.fromMap(Map<String, dynamic> map) {
    return SearchHistory(
      id: map['id'],
      query: map['query'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

enum SearchCategory {
  all,
  jatuhTempo,
  lunas,
}

extension SearchCategoryExtension on SearchCategory {
  String get displayName {
    switch (this) {
      case SearchCategory.all:
        return 'Semua';
      case SearchCategory.jatuhTempo:
        return 'Jatuh Tempo';
      case SearchCategory.lunas:
        return 'Lunas';
    }
  }
}