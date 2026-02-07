import 'package:d2ycredi/features/debt/domain/entities/add_debt.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/debt.dart';
import '../repositories/debt_repository.dart';

class AddDebtUseCase implements UseCase<Debt, AddDebt> {
  final DebtRepository repository;

  AddDebtUseCase(this.repository);

  @override
  Future<Either<Failure, Debt>> call(AddDebt params) async {
    final debt = Debt(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      borrowerName: params.borrowerName,
      borrowerAvatar: params.borrowerAvatar,
      amount: params.amount,
      dueDate: params.dueDate,
      status: DebtStatus.belum,
      note: params.note,
    );

    return await repository.addDebt(debt);
  }
}
