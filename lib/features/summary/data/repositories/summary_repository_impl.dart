import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/monthly_summary.dart';
import '../../domain/repositories/summary_repository.dart';
import '../datasources/summary_local_datasource.dart';

class SummaryRepositoryImpl implements SummaryRepository {
  final SummaryLocalDataSource localDataSource;

  SummaryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, SummaryStats>> getSummaryStats() async {
    try {
      final stats = await localDataSource.getSummaryStats();
      return Right(stats);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MonthlySummary>>> getMonthlyHistory({
    required int year,
  }) async {
    try {
      final history = await localDataSource.getMonthlyHistory(year: year);
      return Right(history);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}