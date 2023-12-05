import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key, required this.image});

  final ImageProvider image;

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  bool cropping = false;

  late Rect rect = Rect.fromCenter(
    center: MediaQuery.of(context).size.center(Offset.zero),
    width: 400,
    height: 400,
  );

  late Rect cropRect = cropRect;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        TransformableBox(
          key: const ValueKey('Main TransformableBox'),
          rect: rect,
          onChanged: (result, event) {
            setState(() {
              rect = result.rect;
            });
          },
          contentBuilder: (BuildContext context, Rect rect, Flip flip) {
            return GestureDetector(
                child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                image: const DecorationImage(
                  image: AssetImage('images/image.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ));
          },
          visibleHandles: const {...HandlePosition.corners},
          resizeModeResolver: () => ResizeMode.scale,
          cornerHandleBuilder: (context, handle) => DefaultCornerHandle(
            handle: handle,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 2)),
          ),
        ),
      ],
    );
  }
}
