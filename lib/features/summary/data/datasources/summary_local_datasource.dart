import '../../../debt/data/datasources/debt_local_datasource.dart';
import '../../../debt/domain/entities/debt.dart';
import '../../domain/entities/monthly_summary.dart';

abstract class SummaryLocalDataSource {
  Future<SummaryStats> getSummaryStats();
  Future<List<MonthlySummary>> getMonthlyHistory({required int year});
}

class SummaryLocalDataSourceImpl implements SummaryLocalDataSource {
  final DebtLocalDataSource debtLocalDataSource;

  SummaryLocalDataSourceImpl({required this.debtLocalDataSource});

  @override
  Future<SummaryStats> getSummaryStats() async {
    final debts = await debtLocalDataSource.getDebts();

    double totalActive = 0;
    double totalPaid = 0;
    final Set<String> debtors = {};

    for (var debt in debts) {
      debtors.add(debt.borrowerName);
      if (debt.status == DebtStatus.belum) {
        totalActive += debt.amount;
      } else {
        totalPaid += debt.amount;
      }
    }

    // Calculate real percentage change from previous month
    final now = DateTime.now();
    final currentMonthDebts = debts.where((d) {
      final debtDate = d.loanDate ?? d.dueDate;
      return debtDate.year == now.year && 
             debtDate.month == now.month &&
             d.status == DebtStatus.belum;
    }).toList();

    final previousMonthDebts = debts.where((d) {
      final debtDate = d.loanDate ?? d.dueDate;
      final previousMonth = DateTime(now.year, now.month - 1);
      return debtDate.year == previousMonth.year && 
             debtDate.month == previousMonth.month &&
             d.status == DebtStatus.belum;
    }).toList();

    final currentMonthTotal = currentMonthDebts.fold<double>(
      0, 
      (sum, debt) => sum + debt.amount,
    );
    final previousMonthTotal = previousMonthDebts.fold<double>(
      0, 
      (sum, debt) => sum + debt.amount,
    );

    double percentageChange = 0;
    if (previousMonthTotal > 0) {
      percentageChange = ((currentMonthTotal - previousMonthTotal) / 
                         previousMonthTotal) * 100;
    } else if (currentMonthTotal > 0) {
      percentageChange = 100;
    }

    // Get monthly data for current year
    final monthlyData = await getMonthlyHistory(year: now.year);

    return SummaryStats(
      totalActiveDebt: totalActive,
      totalPaidDebt: totalPaid,
      totalDebtors: debtors.length,
      percentageChange: percentageChange,
      monthlyData: monthlyData,
    );
  }

  @override
  Future<List<MonthlySummary>> getMonthlyHistory({required int year}) async {
    final debts = await debtLocalDataSource.getDebts();

    // Group debts by year and month
    final Map<String, Map<String, dynamic>> monthlyGroups = {};

    for (var debt in debts) {
      final debtDate = debt.loanDate ?? debt.dueDate;
      
      // Only include debts from the selected year or the year before
      if (debtDate.year != year && debtDate.year != year - 1) continue;

      final monthKey = '${debtDate.year}-${debtDate.month.toString().padLeft(2, '0')}';

      if (!monthlyGroups.containsKey(monthKey)) {
        monthlyGroups[monthKey] = {
          'year': debtDate.year,
          'month': debtDate.month,
          'newLoans': <Debt>[],
          'payments': <Debt>[],
        };
      }

      // Categorize as new loan or payment
      if (debt.status == DebtStatus.belum) {
        monthlyGroups[monthKey]!['newLoans'].add(debt);
      } else {
        monthlyGroups[monthKey]!['payments'].add(debt);
      }
    }

    // Convert to MonthlySummary list
    final List<MonthlySummary> summaries = [];

    for (var entry in monthlyGroups.entries) {
      final data = entry.value;
      final newLoans = data['newLoans'] as List<Debt>;
      final payments = data['payments'] as List<Debt>;

      final totalNewLoans = newLoans.fold<double>(
        0, 
        (sum, debt) => sum + debt.amount,
      );
      final totalPayments = payments.fold<double>(
        0, 
        (sum, debt) => sum + debt.amount,
      );

      // Determine status
      String status;
      if (payments.isEmpty && newLoans.isNotEmpty) {
        status = 'Meningkat';
      } else if (payments.isNotEmpty && newLoans.isEmpty) {
        status = 'Selesai';
      } else if (totalNewLoans > totalPayments) {
        status = 'Meningkat';
      } else if (totalPayments > totalNewLoans) {
        status = 'Menurun';
      } else {
        status = 'Stabil';
      }

      summaries.add(
        MonthlySummary(
          month: _getMonthName(data['month']),
          year: data['year'],
          totalNewLoans: totalNewLoans,
          newLoansCount: newLoans.length,
          totalPayments: totalPayments,
          paymentsCount: payments.length,
          status: status,
        ),
      );
    }

    // Sort by year and month (descending)
    summaries.sort((a, b) {
      if (a.year != b.year) {
        return b.year.compareTo(a.year);
      }
      return _getMonthNumber(b.month).compareTo(_getMonthNumber(a.month));
    });

    return summaries;
  }

  String _getMonthName(int month) {
    const months = [
      'JANUARI', 'FEBRUARI', 'MARET', 'APRIL', 'MEI', 'JUNI',
      'JULI', 'AGUSTUS', 'SEPTEMBER', 'OKTOBER', 'NOVEMBER', 'DESEMBER'
    ];
    return months[month - 1];
  }

  int _getMonthNumber(String monthName) {
    const months = [
      'JANUARI', 'FEBRUARI', 'MARET', 'APRIL', 'MEI', 'JUNI',
      'JULI', 'AGUSTUS', 'SEPTEMBER', 'OKTOBER', 'NOVEMBER', 'DESEMBER'
    ];
    return months.indexOf(monthName) + 1;
  }
}