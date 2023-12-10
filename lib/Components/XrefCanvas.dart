import 'package:flutter/cupertino.dart';

class XrefCanvas extends StatelessWidget {
  const XrefCanvas({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      scaleEnabled: true,
      panEnabled: true,
      boundaryMargin: const EdgeInsets.all(256.0),
      child: child,
    );
  }
}
