import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xref/app_theme.dart';
import 'package:xref/application/theme_mode_notifier.dart';
import 'package:xref/start_page/start_page.dart';

import 'generated/l10n.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Brightness.light.theme,
      darkTheme: Brightness.dark.theme,
      themeMode: themeMode,
      home: const StartPage(),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
