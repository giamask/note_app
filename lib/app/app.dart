import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/core.dart';
import 'package:note_app/features/presentation/blocs/blocs.dart';

import 'provider/app_provider.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppDevice.setStatusBart(context);
    return EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('el', 'GR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: AppProviders(
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              if (state is LoadedTheme) {
                return MaterialApp.router(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  title: 'NS Agenda',
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  themeMode: state.themeMode,
                  routeInformationParser:
                      AppRouter.router.routeInformationParser,
                  routerDelegate: AppRouter.router.routerDelegate,
                  routeInformationProvider:
                      AppRouter.router.routeInformationProvider,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
