import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../debt/domain/entities/debt.dart';
import '../../domain/entities/search_history.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_local_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource localDataSource;

  SearchRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Debt>>> searchDebts(String query) async {
    try {
      final results = await localDataSource.searchDebts(query);
      return Right(results);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchHistory>>> getSearchHistory() async {
    try {
      final history = await localDataSource.getSearchHistory();
      return Right(history);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addSearchHistory(String query) async {
    try {
      await localDataSource.addSearchHistory(query);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSearchHistory(String id) async {
    try {
      await localDataSource.deleteSearchHistory(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearSearchHistory() async {
    try {
      await localDataSource.clearSearchHistory();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}