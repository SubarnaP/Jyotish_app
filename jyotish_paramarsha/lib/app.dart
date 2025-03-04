import 'package:flutter/material.dart';
import 'package:jyotish_paramarsha/l10n/app_localizations.dart';  // Updated import path
import 'package:provider/provider.dart';
import 'core/router.dart';
import 'core/theme.dart';
import 'state_management/auth_provider.dart';
import 'state_management/locale_provider.dart';

class JyotishApp extends StatelessWidget {
  const JyotishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Jyotish Paramarsha',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: appRouter,
            locale: localeProvider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appName),  // Removed ?.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text(
          AppLocalizations.of(context).welcome,  // Removed ?.
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
