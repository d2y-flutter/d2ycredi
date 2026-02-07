import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/debt.dart';
import '../repositories/debt_repository.dart';

class MarkAsPaidUseCase implements UseCase<Debt, MarkAsPaidParams> {
  final DebtRepository repository;

  MarkAsPaidUseCase(this.repository);

  @override
  Future<Either<Failure, Debt>> call(MarkAsPaidParams params) async {
    return await repository.markAsPaid(params.id);
  }
}

class MarkAsPaidParams extends Equatable {
  final String id;

  const MarkAsPaidParams({required this.id});

  @override
  List<Object?> get props => [id];
}