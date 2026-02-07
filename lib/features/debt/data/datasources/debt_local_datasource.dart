import 'package:d2ycredi/features/debt/domain/entities/debt.dart';
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
      await _seedInitialData(db);
      return getDebts();
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

  Future<void> _seedInitialData(Database db) async {
    final defaultDebts = [
      DebtModel(
        id: '1',
        borrowerName: 'Budi Santoso',
        borrowerAvatar: 'https://i.pravatar.cc/150?img=1',
        amount: 1500000,
        dueDate: DateTime(2023, 10, 25),
        status: DebtStatus.belum,
        note: 'Pinjaman untuk modal usaha',
      ),
      DebtModel(
        id: '2',
        borrowerName: 'Siti Aminah',
        borrowerAvatar: 'https://i.pravatar.cc/150?img=5',
        amount: 500000,
        dueDate: DateTime(2023, 10, 10),
        status: DebtStatus.lunas,
        note: 'Sudah lunas',
      ),
    ];

    for (final debt in defaultDebts) {
      await db.insert(_table, debt.toMap());
    }
  }
}