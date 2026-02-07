import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/debt.dart';
import '../repositories/debt_repository.dart';

class GetDebtDetailUseCase implements UseCase<Debt, GetDebtDetailParams> {
  final DebtRepository repository;

  GetDebtDetailUseCase(this.repository);

  @override
  Future<Either<Failure, Debt>> call(GetDebtDetailParams params) async {
    final result = await repository.getDebts();
    
    return result.fold(
      (failure) => Left(failure),
      (debts) {
        try {
          final debt = debts.firstWhere((d) => d.id == params.id);
          return Right(debt);
        } catch (e) {
          return const Left(CacheFailure(message: 'Debt not found'));
        }
      },
    );
  }
}

class GetDebtDetailParams extends Equatable {
  final String id;

  const GetDebtDetailParams({required this.id});

  @override
  List<Object?> get props => [id];
}