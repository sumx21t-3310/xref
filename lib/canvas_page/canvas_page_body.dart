import 'package:flutter/material.dart';
import 'package:xref/application/app_config.dart';

class CanvasPageBody extends StatefulWidget {
  const CanvasPageBody({
    super.key,
    required this.visibleGrid,
    required this.children,
  });

  final List<Widget> children;
  final bool visibleGrid;

  @override
  State<CanvasPageBody> createState() => _CanvasPageBodyState();
}

class _CanvasPageBodyState extends State<CanvasPageBody> {
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();

    _transformationController.value = Matrix4.identity()
      ..translate(
        -AppConfig.viewSize.width / 2,
        -AppConfig.viewSize.height / 2,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          minScale: AppConfig.minScale,
          maxScale: AppConfig.maxScale,
          clipBehavior: Clip.none,
          constrained: false,
          transformationController: _transformationController,
          child: Scrollbar(
            child: Scrollbar(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox.fromSize(
                    size: AppConfig.viewSize,
                    child: GridPaper(
                      color: () {
                        if (Theme.of(context).brightness == Brightness.light) {
                          return Colors.black12;
                        }

                        return Colors.white12;
                      }(),
                    ),
                  ),
                  ...widget.children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
