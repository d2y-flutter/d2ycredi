import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/debt_repository.dart';

class DeleteDebtUseCase implements UseCase<void, DeleteDebtParams> {
  final DebtRepository repository;

  DeleteDebtUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteDebtParams params) async {
    return await repository.deleteDebt(params.id);
  }
}

class DeleteDebtParams extends Equatable {
  final String id;

  const DeleteDebtParams({required this.id});

  @override
  List<Object?> get props => [id];
}