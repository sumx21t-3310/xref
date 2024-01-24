import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xref/application/app_config.dart';
import 'package:xref/canvas_page/image_box.dart';

class CanvasPageBody extends ConsumerWidget {
  const CanvasPageBody({
    super.key,
    required this.children,
    required this.controller,
    required this.visibleGrid,
    this.onTap,
  });

  final List<ImageBox> children;
  final bool visibleGrid;
  final TransformationController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewBorder = SizedBox(
      // color: Colors.black12,
      width: AppConfig.viewSize.width,
      height: AppConfig.viewSize.height,
    );

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            if (visibleGrid) buildGrid(context),
            InteractiveViewer(
              minScale: AppConfig.minScale,
              maxScale: AppConfig.maxScale,
              clipBehavior: Clip.none,
              constrained: false,
              transformationController: controller,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onTap,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [viewBorder, ...children],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGrid(BuildContext context) {
    return OverflowBox(
      child: SizedBox.fromSize(
        size: AppConfig.viewSize,
        child: GridPaper(
          interval: AppConfig.gridSize,
          color: (Theme.of(context).brightness == Brightness.light)
              ? Colors.black26
              : Colors.white24,
        ),
      ),
    );
  }
}
