import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:xref/application/app_config.dart';

class ScrapImage extends ConsumerStatefulWidget {
  const ScrapImage({
    super.key,
    required this.file,
  });

  final File file;

  @override
  ConsumerState<ScrapImage> createState() => _ScrapImageState();
}

class _ScrapImageState extends ConsumerState<ScrapImage> {
  var focusNode = FocusNode();
  var controller = TransformableBoxController();
  late Rect _rect = _getRectFromFile(widget.file);

  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus == false) return;
      debugPrint("has focus!");
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  void onFocus(bool hasFocus) {}

  void onChanged(UITransformResult result, DragUpdateDetails event) {
    setState(() => _rect = result.rect);
  }

  Rect _getRectFromFile(File file) {
    final size = ImageSizeGetter.getSize(FileInput(file));
    final width = size.width.toDouble();
    final height = size.height.toDouble();
    final offset = Offset(width * .25, height * .25);
    final center = AppConfig.viewSize.center(offset);

    return Rect.fromCenter(center: center, width: width, height: height);
  }

  @override
  Widget build(BuildContext context) {
    return TransformableBox(
      rect: _rect,
      onChanged: onChanged,
      visibleHandles: {
        if (_hasFocus) ...{...HandlePosition.corners}
      },
      resizeModeResolver: () => ResizeMode.scale,
      contentBuilder: (BuildContext context, Rect rect, Flip flip) {
        return DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(widget.file),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
