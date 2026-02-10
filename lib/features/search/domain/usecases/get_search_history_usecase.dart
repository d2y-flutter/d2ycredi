import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/search_history.dart';
import '../repositories/search_repository.dart';

class GetSearchHistoryUseCase implements UseCase<List<SearchHistory>, NoParams> {
  final SearchRepository repository;

  GetSearchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<SearchHistory>>> call(NoParams params) async {
    return await repository.getSearchHistory();
  }
}