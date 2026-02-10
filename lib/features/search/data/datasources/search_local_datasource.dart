import 'dart:convert';
import '../../../../core/services/storage_service.dart';
import '../../../debt/data/datasources/debt_local_datasource.dart';
import '../../../debt/domain/entities/debt.dart';
import '../../domain/entities/search_history.dart';

abstract class SearchLocalDataSource {
  Future<List<Debt>> searchDebts(String query);
  Future<List<SearchHistory>> getSearchHistory();
  Future<void> addSearchHistory(String query);
  Future<void> deleteSearchHistory(String id);
  Future<void> clearSearchHistory();
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final DebtLocalDataSource debtLocalDataSource;
  final StorageService storageService;
  static const String _historyKey = 'search_history';

  SearchLocalDataSourceImpl({
    required this.debtLocalDataSource,
    required this.storageService,
  });

  @override
  Future<List<Debt>> searchDebts(String query) async {
    final debts = await debtLocalDataSource.getDebts();
    
    if (query.isEmpty) return debts;

    final lowercaseQuery = query.toLowerCase();
    
    return debts.where((debt) {
      final nameMatch = debt.borrowerName.toLowerCase().contains(lowercaseQuery);
      final noteMatch = debt.note?.toLowerCase().contains(lowercaseQuery) ?? false;
      final amountMatch = debt.amount.toString().contains(lowercaseQuery);
      
      return nameMatch || noteMatch || amountMatch;
    }).toList();
  }

  @override
  Future<List<SearchHistory>> getSearchHistory() async {
    try {
      final historyJson = await storageService.readString(_historyKey);
      
      if (historyJson == null) return [];

      final List<dynamic> historyList = json.decode(historyJson);
      final histories = historyList
          .map((json) => SearchHistory.fromMap(json))
          .toList();

      // Sort by timestamp descending
      histories.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return histories;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addSearchHistory(String query) async {
    if (query.trim().isEmpty) return;

    final histories = await getSearchHistory();
    
    // Remove duplicate if exists
    histories.removeWhere((h) => h.query.toLowerCase() == query.toLowerCase());

    // Add new history at the beginning
    final newHistory = SearchHistory(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      query: query,
      timestamp: DateTime.now(),
    );

    histories.insert(0, newHistory);

    // Keep only last 10 items
    if (histories.length > 10) {
      histories.removeRange(10, histories.length);
    }

    await _saveHistory(histories);
  }

  @override
  Future<void> deleteSearchHistory(String id) async {
    final histories = await getSearchHistory();
    histories.removeWhere((h) => h.id == id);
    await _saveHistory(histories);
  }

  @override
  Future<void> clearSearchHistory() async {
    await storageService.delete(_historyKey);
  }

  Future<void> _saveHistory(List<SearchHistory> histories) async {
    final historyJson = json.encode(
      histories.map((h) => h.toMap()).toList(),
    );
    await storageService.writeString(_historyKey, historyJson);
  }
}