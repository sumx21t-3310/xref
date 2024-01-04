import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(const App());
  desktopEnvSetup();
}

void desktopEnvSetup() {
  if ((Platform.isWindows || Platform.isMacOS) == false) {
    return;
  }
  doWhenWindowReady(() {
    appWindow.size = const Size(600, 400);
    appWindow.minSize = const Size(300, 300);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
