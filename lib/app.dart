import 'package:flutter/material.dart';
import 'package:xref/pages/start_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: createTheme(Brightness.light),
      darkTheme: createTheme(Brightness.dark),
      home: const StartPage(),
    );
  }
}

ThemeData createTheme(Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: brightness,
    ),
  );
}
