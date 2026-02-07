import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/debt.dart';
import '../../domain/repositories/debt_repository.dart';
import '../datasources/debt_local_datasource.dart';
import '../models/debt_model.dart';

class DebtRepositoryImpl implements DebtRepository {
  final DebtLocalDataSource localDataSource;

  DebtRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Debt>>> getDebts() async {
    try {
      final debts = await localDataSource.getDebts();
      return Right(debts);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DebtSummary>> getDebtSummary() async {
    try {
      final debts = await localDataSource.getDebts();
      
      double totalActive = 0;
      double totalPaid = 0;

      for (var debt in debts) {
        if (debt.status == DebtStatus.belum) {
          totalActive += debt.amount;
        } else {
          totalPaid += debt.amount;
        }
      }

      return Right(DebtSummary(
        totalActive: totalActive,
        totalPaid: totalPaid,
      ));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Debt>> addDebt(Debt debt) async {
    try {
      final debtModel = DebtModel.fromEntity(debt);
      await localDataSource.addDebt(debtModel);
      return Right(debt);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Debt>> updateDebt(Debt debt) async {
    try {
      final debtModel = DebtModel.fromEntity(debt);
      await localDataSource.updateDebt(debtModel);
      return Right(debt);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDebt(String id) async {
    try {
      await localDataSource.deleteDebt(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Debt>> markAsPaid(String id) async {
    try {
      final debts = await localDataSource.getDebts();
      final debt = debts.firstWhere((d) => d.id == id);
      final updatedDebt = debt.copyWith(status: DebtStatus.lunas);
      await localDataSource.updateDebt(DebtModel.fromEntity(updatedDebt));
      return Right(updatedDebt);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}