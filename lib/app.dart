import 'package:d2ycredi/core/routes/app_routes.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/add_debt/add_debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/debt/debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/detail_debt/detail_debt_bloc.dart';
import 'package:d2ycredi/features/debt/presentation/bloc/edit_debt/edit_debt_bloc.dart';
import 'package:d2ycredi/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide RouterConfig;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/config/app_config.dart';
import 'core/config/app_theme.dart';
import 'core/routes/router_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = RouterConfig.createRouter(AppRoutes.splash);
  }
   
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<DebtBloc>()),
        BlocProvider(create: (_) => getIt<AddDebtBloc>()),
        BlocProvider(create: (_) => getIt<EditDebtBloc>()),
        BlocProvider(create: (_) => getIt<DetailDebtBloc>()),
      ],
     child: MaterialApp.router(
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        routerConfig: _router,
      ),
    );
  }
}