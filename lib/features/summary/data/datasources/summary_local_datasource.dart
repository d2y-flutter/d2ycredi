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

    // Calculate percentage change (dummy calculation)
    final percentageChange = totalActive > 0 ? 15.24 : -2.0;

    // Get monthly data
    final monthlyData = await getMonthlyHistory(year: DateTime.now().year);

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

    // Group debts by month
    final Map<int, List<dynamic>> monthlyDebts = {};

    for (var debt in debts) {
      if (debt.loanDate?.year == year || debt.dueDate.year == year) {
        final month = debt.loanDate?.month ?? debt.dueDate.month;
        if (!monthlyDebts.containsKey(month)) {
          monthlyDebts[month] = [];
        }
        monthlyDebts[month]!.add(debt);
      }
    }

    // Generate monthly summaries
    final List<MonthlySummary> summaries = [];

    // Add some dummy data for demo
    summaries.add(
      const MonthlySummary(
        month: 'JANUARI',
        year: 2024,
        totalNewLoans: 1200000,
        newLoansCount: 4,
        totalPayments: 0,
        paymentsCount: 0,
        status: 'Meningkat',
      ),
    );

    summaries.add(
      const MonthlySummary(
        month: 'DESEMBER',
        year: 2023,
        totalNewLoans: 2100000,
        newLoansCount: 6,
        totalPayments: 1500000,
        paymentsCount: 5,
        status: 'Selesai',
      ),
    );

    return summaries;
  }
}