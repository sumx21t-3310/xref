import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  const app = App();
  runApp(const ProviderScope(child: app));
  desktopEnvSetup();
}

void desktopEnvSetup() {
  if ((Platform.isWindows || Platform.isMacOS) == false) {
    return;
  }
  doWhenWindowReady(() {
    appWindow.size = const Size(600, 400);
    appWindow.minSize = const Size(400, 300);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
