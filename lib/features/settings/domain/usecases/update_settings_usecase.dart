import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class UpdateSettingsUseCase implements UseCase<void, UpdateSettingsParams> {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateSettingsParams params) async {
    return await repository.saveSettings(params.settings);
  }
}

class UpdateSettingsParams extends Equatable {
  final AppSettings settings;

  const UpdateSettingsParams({required this.settings});

  @override
  List<Object?> get props => [settings];
}