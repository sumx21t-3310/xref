import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class ScrapImage extends StatefulWidget {
  ScrapImage({super.key, required this.provider});

  ImageProvider provider;

  @override
  State<ScrapImage> createState() => _ScrapImageState();
}

class _ScrapImageState extends State<ScrapImage> {
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => isFocus = _focusNode.hasFocus);
  }

  var isFocus = false;

  final FocusNode _focusNode = FocusNode();
  late Rect rect = _getRectFrom(widget.provider);

  Rect _getRectFrom(ImageProvider provider) {
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
        onChanged: (result, event) => setState(() => rect = result.rect),
        contentBuilder: (BuildContext context, Rect rect, Flip flip) =>
            DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: provider,
            ),
          ),
        ),
        visibleHandles: const {...HandlePosition.corners},
        resizeModeResolver: () => ResizeMode.scale,
      );

  @override
  Widget build(BuildContext context) =>
      _createImage(widget.provider, Colors.blue, 2);
}
