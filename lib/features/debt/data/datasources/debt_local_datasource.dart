import 'package:sqflite/sqflite.dart';

import '../../../../core/database/app_database.dart';
import '../models/debt_model.dart';

abstract class DebtLocalDataSource {
  Future<List<DebtModel>> getDebts();
  Future<void> addDebt(DebtModel debt);
  Future<void> updateDebt(DebtModel debt);
  Future<void> deleteDebt(String id);
}

class DebtLocalDataSourceImpl implements DebtLocalDataSource {
  final AppDatabase database;

  DebtLocalDataSourceImpl({required this.database});

  static const _table = 'debts';

  @override
  Future<List<DebtModel>> getDebts() async {
    final db = await database.database;
    final result = await db.query(
      _table,
      orderBy: 'due_date DESC',
    );

    if (result.isEmpty) {
      return [];
    }

    return result.map(DebtModel.fromMap).toList();
  }

  @override
  Future<void> addDebt(DebtModel debt) async {
    final db = await database.database;
    await db.insert(
      _table,
      debt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateDebt(DebtModel debt) async {
    final db = await database.database;
    await db.update(
      _table,
      debt.toMap(),
      where: 'id = ?',
      whereArgs: [debt.id],
    );
  }

  @override
  Future<void> deleteDebt(String id) async {
    final db = await database.database;
    await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}