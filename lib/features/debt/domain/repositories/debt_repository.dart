import 'package:d2ycredi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/debt.dart';

abstract class DebtRepository {
  Future<Either<Failure, List<Debt>>> getDebts();
  Future<Either<Failure, DebtSummary>> getDebtSummary();
  Future<Either<Failure, Debt>> addDebt(Debt debt);
  Future<Either<Failure, Debt>> updateDebt(Debt debt);
  Future<Either<Failure, void>> deleteDebt(String id);
  Future<Either<Failure, Debt>> markAsPaid(String id);
}