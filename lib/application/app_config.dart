import 'dart:ui';

import 'package:image_picker/image_picker.dart';

class AppConfig {
  static const Size viewSize = Size.square(100000);
  static const double minScale = 0.125;
  static const double maxScale = 3;
  static const double gridSize = 200;
  static const int undoLimit = 50;

  static bool get isCameraSupported =>
      ImagePicker.platform.supportsImageSource(ImageSource.camera);
}
