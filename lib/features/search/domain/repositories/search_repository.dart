import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../debt/domain/entities/debt.dart';
import '../entities/search_history.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Debt>>> searchDebts(String query);
  Future<Either<Failure, List<SearchHistory>>> getSearchHistory();
  Future<Either<Failure, void>> addSearchHistory(String query);
  Future<Either<Failure, void>> deleteSearchHistory(String id);
  Future<Either<Failure, void>> clearSearchHistory();
}