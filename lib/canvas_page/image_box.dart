import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:xref/canvas_page/box_data.dart';

class ImageBox extends StatefulWidget {
  const ImageBox({
    super.key,
    this.isSelect,
    this.onSelect,
    this.onChanged,
    required this.boxData,
  });

  final ImageBoxData boxData;
  final bool? isSelect;
  final VoidCallback? onSelect;
  final Function(TransformResult<Rect, Offset, Size> result,
      DragUpdateDetails details)? onChanged;

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  late Rect rect = widget.boxData.rect;

  @override
  Widget build(BuildContext context) {
    return TransformableBox(
      rect: widget.boxData.rect,
      visibleHandles: {
        if (widget.isSelect ?? true) ...widget.boxData.visibleHandles,
      },
      enabledHandles: {
        if (widget.isSelect ?? true) ...widget.boxData.visibleHandles,
      },
      resizeModeResolver: () => ResizeMode.scale,
      onChanged: (result, details) {
        setState(() {
          widget.onChanged;
        });
      },
      contentBuilder: (BuildContext context, Rect rect, Flip flip) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.onSelect,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: (widget.isSelect ?? true)
                  ? Border.all(
                      color: Colors.blue,
                      width: 4,
                    )
                  : null,
              image: DecorationImage(
                image: FileImage(widget.boxData.image),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}
