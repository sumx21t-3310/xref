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
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple, brightness: Brightness.dark),
            useMaterial3: true),
        home: const CanvasPage());
  }
}
