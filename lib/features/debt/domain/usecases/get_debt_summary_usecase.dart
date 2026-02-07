import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/debt.dart';
import '../repositories/debt_repository.dart';

class GetDebtSummaryUseCase implements UseCase<DebtSummary, NoParams> {
  final DebtRepository repository;

  GetDebtSummaryUseCase(this.repository);

  @override
  Future<Either<Failure, DebtSummary>> call(NoParams params) async {
    return await repository.getDebtSummary();
  }
}