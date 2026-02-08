import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/monthly_summary.dart';

abstract class SummaryRepository {
  Future<Either<Failure, SummaryStats>> getSummaryStats();
  Future<Either<Failure, List<MonthlySummary>>> getMonthlyHistory({
    required int year,
  });
}