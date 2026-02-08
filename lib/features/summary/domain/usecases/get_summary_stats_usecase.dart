import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/monthly_summary.dart';
import '../repositories/summary_repository.dart';

class GetSummaryStatsUseCase implements UseCase<SummaryStats, NoParams> {
  final SummaryRepository repository;

  GetSummaryStatsUseCase(this.repository);

  @override
  Future<Either<Failure, SummaryStats>> call(NoParams params) async {
    return await repository.getSummaryStats();
  }
}