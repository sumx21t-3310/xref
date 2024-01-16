import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xref/application/app_config.dart';

part 'transformation_controller_notifier.g.dart';

@riverpod
class TransformationControllerNotifier
    extends _$TransformationControllerNotifier {
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
