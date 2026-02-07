import 'package:d2ycredi/features/debt/domain/entities/update_debt.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/debt.dart';
import '../repositories/debt_repository.dart';

class UpdateDebtUseCase implements UseCase<Debt, UpdateDebt> {
  final DebtRepository repository;

  UpdateDebtUseCase(this.repository);

  @override
  Future<Either<Failure, Debt>> call(UpdateDebt params) async {
    final debt = Debt(
      id: params.id,
      borrowerName: params.borrowerName,
      borrowerAvatar: params.borrowerAvatar,
      amount: params.amount,
      dueDate: params.dueDate,
      status: params.status,
      note: params.note,
    );

    return await repository.updateDebt(debt);
  }
}
