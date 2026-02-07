import 'package:d2ycredi/features/debt/domain/entities/debt.dart';
import 'package:equatable/equatable.dart';

abstract class DebtState extends Equatable {
  const DebtState();

  @override
  List<Object?> get props => [];
}

class DebtInitial extends DebtState {}

class DebtLoading extends DebtState {}

class DebtLoaded extends DebtState {
  final List<Debt> debts;
  final DebtSummary summary;
  final DebtStatus? filterStatus;

  const DebtLoaded({
    required this.debts,
    required this.summary,
    this.filterStatus,
  });

  List<Debt> get filteredDebts {
    if (filterStatus == null) return debts;
    return debts.where((debt) => debt.status == filterStatus).toList();
  }

  @override
  List<Object?> get props => [debts, summary, filterStatus];

  DebtLoaded copyWith({
    List<Debt>? debts,
    DebtSummary? summary,
    DebtStatus? filterStatus,
    bool clearFilter = false,
  }) {
    return DebtLoaded(
      debts: debts ?? this.debts,
      summary: summary ?? this.summary,
      filterStatus: clearFilter ? null : (filterStatus ?? this.filterStatus),
    );
  }
}

class DebtError extends DebtState {
  final String message;

  const DebtError(this.message);

  @override
  List<Object?> get props => [message];
}

class DebtActionSuccess extends DebtState {
  final String message;

  const DebtActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}