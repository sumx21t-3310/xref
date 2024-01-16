import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AppConfig {
  static const String appName = "XREF";
  static const String version = "1.0.0-beta";
  static const Size viewSize = Size.square(100000);
  static const double minScale = 1 / 16;
  static const double maxScale = 10;
  static const double gridSize = 200;
  static const int undoLimit = 50;

  static bool get isCameraSupported =>
      kIsWeb == false && ImagePicker().supportsImageSource(ImageSource.camera);
}
