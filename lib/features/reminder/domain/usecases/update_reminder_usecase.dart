import 'package:d2ycredi/features/debt/domain/entities/debt.dart';
import 'package:d2ycredi/features/debt/domain/repositories/debt_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reminder.dart';

class UpdateReminderUseCase implements UseCase<Debt, UpdateReminderParams> {
  final DebtRepository repository;

  UpdateReminderUseCase(this.repository);

  @override
  Future<Either<Failure, Debt>> call(UpdateReminderParams params) async {
    // Get current debt
    final debtsResult = await repository.getDebts();
    
    return debtsResult.fold(
      (failure) => Left(failure),
      (debts) {
        try {
          final debt = debts.firstWhere((d) => d.id == params.debtId);
          
          final updatedDebt = debt.copyWith(
            reminderEnabled: params.settings.enabled,
            reminderDate: params.settings.reminderDate,
            reminderTime: params.settings.reminderTime,
            reminderFrequency: params.settings.frequency.displayName,
          );
          
          return repository.updateDebt(updatedDebt);
        } catch (e) {
          return const Left(CacheFailure(message: 'Debt not found'));
        }
      },
    );
  }
}

class UpdateReminderParams extends Equatable {
  final String debtId;
  final ReminderSettings settings;

  const UpdateReminderParams({
    required this.debtId,
    required this.settings,
  });

  @override
  List<Object?> get props => [debtId, settings];
}