import 'package:d2ycredi/core/database/app_database.dart';
import 'package:d2ycredi/features/debt/data/datasources/debt_local_datasource.dart';
import 'package:d2ycredi/features/debt/data/repositories/debt_repository_impl.dart';
import 'package:d2ycredi/features/debt/domain/repositories/debt_repository.dart';
import 'package:d2ycredi/features/debt/domain/usecases/add_debt_usecase.dart';
import 'package:d2ycredi/features/debt/domain/usecases/delete_debt_usecase.dart';
import 'package:d2ycredi/features/debt/domain/usecases/get_debt_detail_usecase.dart';
import 'package:d2ycredi/features/debt/domain/usecases/get_debt_summary_usecase.dart';
import 'package:d2ycredi/features/debt/domain/usecases/get_debts_usecase.dart';
import 'package:d2ycredi/features/debt/domain/usecases/mark_as_paid_usecase.dart';
import 'package:d2ycredi/features/debt/domain/usecases/update_debt_usecase.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/add_debt/add_debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/detail_debt/detail_debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/edit_debt/edit_debt_bloc.dart';
import 'package:d2ycredi/features/reminder/domain/usecases/update_reminder_usecase.dart';
import 'package:d2ycredi/features/reminder/presentation/bloc/reminder/reminder_bloc.dart';
import 'package:d2ycredi/features/search/data/datasources/search_local_datasource.dart';
import 'package:d2ycredi/features/search/data/repositories/search_repository_impl.dart';
import 'package:d2ycredi/features/search/domain/repositories/search_repository.dart';
import 'package:d2ycredi/features/search/domain/usecases/get_search_history_usecase.dart';
import 'package:d2ycredi/features/search/domain/usecases/search_debts_usecase.dart';
import 'package:d2ycredi/features/search/presentation/bloc/search_bloc.dart';
import 'package:d2ycredi/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:d2ycredi/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:d2ycredi/features/settings/domain/repositories/settings_repository.dart';
import 'package:d2ycredi/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:d2ycredi/features/settings/domain/usecases/update_settings_usecase.dart';
import 'package:d2ycredi/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:d2ycredi/features/summary/data/datasources/summary_local_datasource.dart';
import 'package:d2ycredi/features/summary/data/repositories/summary_repository_impl.dart';
import 'package:d2ycredi/features/summary/domain/repositories/summary_repository.dart';
import 'package:d2ycredi/features/summary/domain/usecases/get_summary_stats_usecase.dart';
import 'package:d2ycredi/features/summary/presentation/bloc/summary_bloc.dart';
import 'package:get_it/get_it.dart';
import 'core/services/storage_service.dart';
import 'core/services/language_service.dart';
import 'core/services/permission_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Core Services
  await _registerServices();
  
  await _registerDebt();
  await _registerReminder();
  await _registerSummary();
  await _registerSettings();
  await _registerSearch();
}

Future<void> _registerServices() async {

  final storageService = StorageService();
  getIt.registerSingleton<StorageService>(storageService);

  final databaseService = AppDatabase();
  getIt.registerSingleton<AppDatabase>(databaseService);

  // final notificationService = LocalNotificationService();
  // await notificationService.init();
  // getIt.registerSingleton<LocalNotificationService>(notificationService);

  getIt.registerSingleton<LanguageService>(LanguageService());
  getIt.registerSingleton<PermissionService>(PermissionService());
}

Future<void> _registerDebt() async {
  // Data sources
  getIt.registerLazySingleton<DebtLocalDataSource>(
    () => DebtLocalDataSourceImpl(database: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<DebtRepository>(
    () => DebtRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetDebtsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetDebtSummaryUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteDebtUseCase(getIt()));
  getIt.registerLazySingleton(() => AddDebtUseCase(getIt()));
   getIt.registerLazySingleton(() => UpdateDebtUseCase(getIt()));
  getIt.registerLazySingleton(() => GetDebtDetailUseCase(getIt()));
  getIt.registerLazySingleton(() => MarkAsPaidUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => DebtBloc(
      getDebtsUseCase: getIt(),
      getDebtSummaryUseCase: getIt(),
      deleteDebtUseCase: getIt(),
      debtRepository: getIt(),
    ),
  );
  getIt.registerFactory(
    () => AddDebtBloc(
      addDebtUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => EditDebtBloc(
      getDebtDetailUseCase: getIt(),
      deleteDebtUseCase: getIt(),
      updateDebtUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => DetailDebtBloc(
      getDebtDetailUseCase: getIt(),
      markAsPaidUseCase: getIt(),
    ),
  );
}

Future<void> _registerSummary() async {
  // Data sources
  getIt.registerLazySingleton<SummaryLocalDataSource>(
    () => SummaryLocalDataSourceImpl(debtLocalDataSource: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<SummaryRepository>(
    () => SummaryRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetSummaryStatsUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => SummaryBloc(getSummaryStatsUseCase: getIt(),summaryRepository: getIt()),
  );
}

Future<void> _registerReminder() async {
  // Use cases
  getIt.registerLazySingleton(() => UpdateReminderUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => ReminderBloc(getDebtDetailUseCase: getIt(), updateReminderUseCase: getIt()),
  );
}

Future<void> _registerSettings() async {
  // Data sources
  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(storageService: getIt(), debtLocalDataSource: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetSettingsUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateSettingsUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => SettingsBloc(
      getSettingsUseCase: getIt(),
      updateSettingsUseCase: getIt(),
      settingsRepository: getIt(),
    ),
  );
}

Future<void> _registerSearch() async {
  // Data sources
  getIt.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(
      debtLocalDataSource: getIt(),
      storageService: getIt(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => SearchDebtsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSearchHistoryUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => SearchBloc(
      searchDebtsUseCase: getIt(),
      getSearchHistoryUseCase: getIt(),
      searchRepository: getIt(),
    ),
  );
}