import 'package:equatable/equatable.dart';

class MonthlySummary extends Equatable {
  final String month;
  final int year;
  final double totalNewLoans;
  final int newLoansCount;
  final double totalPayments;
  final int paymentsCount;
  final String status; // 'Meningkat', 'Stabil', 'Menurun'

  const MonthlySummary({
    required this.month,
    required this.year,
    required this.totalNewLoans,
    required this.newLoansCount,
    required this.totalPayments,
    required this.paymentsCount,
    required this.status,
  });

  @override
  List<Object?> get props => [
        month,
        year,
        totalNewLoans,
        newLoansCount,
        totalPayments,
        paymentsCount,
        status,
      ];
}

class SummaryStats extends Equatable {
  final double totalActiveDebt;
  final double totalPaidDebt;
  final int totalDebtors;
  final double percentageChange;
  final List<MonthlySummary> monthlyData;

  const SummaryStats({
    required this.totalActiveDebt,
    required this.totalPaidDebt,
    required this.totalDebtors,
    required this.percentageChange,
    required this.monthlyData,
  });

  @override
  List<Object?> get props => [
        totalActiveDebt,
        totalPaidDebt,
        totalDebtors,
        percentageChange,
        monthlyData,
      ];
}