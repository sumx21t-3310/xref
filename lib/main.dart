import 'package:flutter/material.dart';
import 'package:xref/Pages/CanvasPage.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'xref',
        debugShowCheckedModeBanner: true,
        theme: AppThemeData.create(Brightness.light),
        darkTheme: AppThemeData.create(Brightness.dark),
        home: const CanvasPage());
  }
}

class AppThemeData {
  static ThemeData create(Brightness brightness) => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: brightness));
}
