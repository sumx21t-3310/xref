import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class Clip extends StatefulWidget {
  Clip({super.key, required this.provider});

  ImageProvider provider;

  @override
  State<Clip> createState() => _ClipState();
}

class _ClipState extends State<Clip> {
  late Rect rect;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    rect = _getRectTo(widget.provider);
  }

  Rect _getRectTo(ImageProvider provider) {
    return Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 400,
      height: 400,
    );
  }

  TransformableBox _createImage(
          ImageProvider provider, Color borderColor, int borderWidth) =>
      TransformableBox(
        key: const ValueKey('Clip'),
        rect: rect,
        onChanged: (result, event) {
          setState(() => rect = result.rect);
        },
        contentBuilder: (BuildContext context, Rect rect, Flip flip) {
          return DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: provider,
              ),
            ),
          );
        },
        visibleHandles: const {...HandlePosition.corners},
        resizeModeResolver: () => ResizeMode.scale,
        cornerHandleBuilder: (context, handle) => DefaultCornerHandle(
          handle: handle,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 2)),
        ),
      );

  @override
  Widget build(BuildContext context) => _createImage(widget.provider);
}
