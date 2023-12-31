import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class ScrapImage extends StatefulWidget {
  ScrapImage({super.key, required this.provider});

  ImageProvider provider;

  @override
  State<ScrapImage> createState() => _ScrapImageState();
}

class _ScrapImageState extends State<ScrapImage> {
  var focusNode = FocusNode();
  var controller = TransformableBoxController();
  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  late Rect _rect = _getRectFrom(widget.provider);

  Rect _getRectFrom(ImageProvider provider) {
    return Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 400,
      height: 400,
    );
  }

  @override
  Widget build(BuildContext context) {
    content(BuildContext context, Rect rect, Flip flip) {
      return DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: widget.provider),
        ),
      );
    }

    return TransformableBox(
      rect: _rect,
      onChanged: (result, event) => setState(() => _rect = result.rect),
      contentBuilder: content,
      visibleHandles: const {...HandlePosition.corners},
      resizeModeResolver: () => ResizeMode.scale,
    );
  }
}
