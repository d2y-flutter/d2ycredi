import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../debt/domain/entities/debt.dart';
import '../repositories/search_repository.dart';

class SearchDebtsUseCase implements UseCase<List<Debt>, SearchDebtsParams> {
  final SearchRepository repository;

  SearchDebtsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Debt>>> call(SearchDebtsParams params) async {
    return await repository.searchDebts(params.query);
  }
}

class SearchDebtsParams extends Equatable {
  final String query;

  const SearchDebtsParams({required this.query});

  @override
  List<Object?> get props => [query];
}