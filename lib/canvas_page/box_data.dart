import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class ImageBoxData {
  Rect rect = Rect.zero;
  Flip flip = Flip.none;
  BoxConstraints constraints;

  bool flipRectWhileResizing = true;
  bool constraintsEnabled = false;
  bool resizable = true;
  bool draggable = true;
  Set<HandlePosition> enabledHandles;
  Set<HandlePosition> visibleHandles;

  final File image;

  ImageBoxData({
    required this.image,
    required this.rect,
    this.flip = Flip.none,
    this.constraints = const BoxConstraints(minWidth: 0, minHeight: 0),
    this.flipRectWhileResizing = true,
    this.constraintsEnabled = false,
    this.draggable = true,
    this.resizable = true,
    Set<HandlePosition>? enabledHandles,
    Set<HandlePosition>? visibleHandles,
  })  : enabledHandles = enabledHandles ?? {...HandlePosition.values}
          ..remove(HandlePosition.none),
        visibleHandles = visibleHandles ?? {...HandlePosition.values}
          ..remove(HandlePosition.none);

  ImageBoxData copyWith({
    Rect? rect,
    File? image,
    Flip? flip,
    BoxConstraints? constraints,
    bool? flipRectWhileResizing = true,
    bool? constraintsEnabled = false,
    bool? draggable = true,
    bool? resizable = true,
    Set<HandlePosition>? enabledHandles,
    Set<HandlePosition>? visibleHandles,
  }) =>
      ImageBoxData(
        image: image ?? this.image,
        rect: rect ?? this.rect,
        flip: flip ?? this.flip,
        constraints: constraints ?? this.constraints,
        draggable: draggable ?? this.draggable,
        resizable: resizable ?? this.resizable,
        enabledHandles: enabledHandles ?? this.enabledHandles,
        visibleHandles: visibleHandles ?? this.visibleHandles,
      );
}
