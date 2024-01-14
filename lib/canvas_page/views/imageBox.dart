import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:image_size_getter/image_size_getter.dart';

class ImageBox extends StatefulWidget {
  const ImageBox({
    super.key,
    required this.file,
    this.isSelect,
    this.onSelect,
    this.onChanged,
  });

  final File file;
  final bool? isSelect;
  final VoidCallback? onSelect;
  final Function(TransformResult<Rect, Offset, Size>)? onChanged;

  @override
  State<ImageBox> createState() => _ScrapImageState();
}

class _ScrapImageState extends State<ImageBox> {
  late Rect _rect;

  @override
  Widget build(BuildContext context) {
    return TransformableBox(
      rect: _rect,
      visibleHandles: const {...HandlePosition.corners},
      resizeModeResolver: () => ResizeMode.scale,
      onChanged: (result) => widget.onChanged?.call(result),
      contentBuilder: (BuildContext context, Rect rect, Flip flip) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.onSelect,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(widget.file),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}
