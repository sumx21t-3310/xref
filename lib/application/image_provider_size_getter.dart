import 'dart:async';

import 'package:flutter/material.dart';

Future<Size> getSizeFromProvider(ImageProvider image) async {
  Completer<Size> completer = Completer<Size>();

  image.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener(
      (imageInfo, synchronousCall) {
        final size = Size(
          imageInfo.image.width.toDouble(),
          imageInfo.image.height.toDouble(),
        );
        completer.complete(size);
      },
    ),
  );

  var result = await completer.future;

  return result;
}
