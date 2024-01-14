import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class BoxData {
  final String name;
  Rect rect = Rect.zero;
  Flip flip = Flip.none;
  Rect rect2 = Rect.zero;
  Flip flip2 = Flip.none;
  BoxConstraints constraints;

  bool flipRectWhileResizing = true;
  bool flipChild = true;
  bool constraintsEnabled = false;
  bool resizable = true;
  bool draggable = true;
  Set<HandlePosition> enabledHandles;
  Set<HandlePosition> visibleHandles;

  final Path imagePath;

  BoxData({
    required this.name,
    required this.rect,
    required this.imagePath,
    this.flip = Flip.none,
    this.rect2 = Rect.zero,
    this.flip2 = Flip.none,
    this.constraints = const BoxConstraints(minWidth: 0, minHeight: 0),
    this.flipRectWhileResizing = true,
    this.flipChild = true,
    this.constraintsEnabled = false,
    this.draggable = true,
    this.resizable = true,
    Set<HandlePosition>? enabledHandles,
    Set<HandlePosition>? visibleHandles,
  })  : enabledHandles = enabledHandles ?? {...HandlePosition.values}
          ..remove(HandlePosition.none),
        visibleHandles = visibleHandles ?? {...HandlePosition.values}
          ..remove(HandlePosition.none);
}
