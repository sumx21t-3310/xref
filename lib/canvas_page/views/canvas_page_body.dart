import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xref/application/app_config.dart';
import 'package:xref/canvas_page/states/canvas_body_transformation_controller_notifier.dart';
import 'package:xref/canvas_page/views/scrap_image.dart';

class CanvasPageBody extends ConsumerStatefulWidget {
  const CanvasPageBody({
    super.key,
    required this.children,
    required this.visibleGrid,
  });

  final List<ScrapImage> children;
  final bool visibleGrid;

  @override
  ConsumerState<CanvasPageBody> createState() => _CanvasPageBodyState();
}

class _CanvasPageBodyState extends ConsumerState<CanvasPageBody> {
  @override
  Widget build(BuildContext context) {
    final controller =
        ref.watch(canvasBodyTransformationControllerNotifierProvider);

    var grid = OverflowBox(
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

    final viewBorder = Container(
      color: Colors.black12,
      width: AppConfig.viewSize.width,
      height: AppConfig.viewSize.height,
    );

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            if (widget.visibleGrid) grid,
            InteractiveViewer(
              minScale: AppConfig.minScale,
              maxScale: AppConfig.maxScale,
              clipBehavior: Clip.none,
              constrained: false,
              transformationController: controller,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  viewBorder,
                  ...widget.children,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
