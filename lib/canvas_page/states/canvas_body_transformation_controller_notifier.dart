import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xref/application/app_config.dart';

part 'canvas_body_transformation_controller_notifier.g.dart';

@riverpod
class CanvasBodyTransformationControllerNotifier
    extends _$CanvasBodyTransformationControllerNotifier {
  @override
  TransformationController build() {
    var controller = TransformationController();
    controller.value = Matrix4.identity()
      ..translate(
        -AppConfig.viewSize.width / 2,
        -AppConfig.viewSize.height / 2,
      );
    return controller;
  }

  void setInitialPosition() {
    state.value = Matrix4.identity()
      ..translate(
        -AppConfig.viewSize.width / 2,
        -AppConfig.viewSize.height / 2,
      );
  }
}
