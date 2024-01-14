import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xref/application/app_config.dart';
import 'package:xref/canvas_page/states/canvas_body_transformation_controller_notifier.dart';
import 'package:xref/canvas_page/states/grid_toggle_notifier.dart';
import 'package:xref/canvas_page/views/imageBox.dart';

class CanvasPageBody extends ConsumerWidget {
  const CanvasPageBody({
    super.key,
    required this.children,
  });

  final List<ImageBox> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(transformationControllerNotifierProvider);
    final viewBorder = Container(
      color: Colors.black12,
      width: AppConfig.viewSize.width,
      height: AppConfig.viewSize.height,
    );

    var visibleGrid = ref.watch(gridToggleNotifierProvider);

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
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  viewBorder,
                  ...children,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  OverflowBox buildGrid(BuildContext context) {
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
