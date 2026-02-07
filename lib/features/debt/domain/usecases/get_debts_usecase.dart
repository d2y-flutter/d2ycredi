import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/debt.dart';
import '../repositories/debt_repository.dart';

class GetDebtsUseCase implements UseCase<List<Debt>, NoParams> {
  final DebtRepository repository;

  GetDebtsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Debt>>> call(NoParams params) async {
    return await repository.getDebts();
  }
}