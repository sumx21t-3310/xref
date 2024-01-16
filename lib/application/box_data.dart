import 'dart:io';

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

  final File image;

  BoxData({
    required this.name,
    required this.rect,
    required this.image,
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

  BoxData copyWith({
    String? name,
    Rect? rect,
    File? image,
    Flip? flip,
    Rect? rect2,
    Flip? flip2,
    BoxConstraints? constraints,
    bool? flipRectWhileResizing = true,
    bool? flipChild = true,
    bool? constraintsEnabled = false,
    bool? draggable = true,
    bool? resizable = true,
    Set<HandlePosition>? enabledHandles,
    Set<HandlePosition>? visibleHandles,
  }) =>
      BoxData(
        name: name ?? this.name,
        rect: rect ?? this.rect,
        image: image ?? this.image,
        flip: flip ?? this.flip,
        rect2: rect2 ?? this.rect2,
        flip2: flip2 ?? this.flip2,
        constraints: constraints ?? this.constraints,
        draggable: draggable ?? this.draggable,
        resizable: resizable ?? this.resizable,
        enabledHandles: enabledHandles ?? this.enabledHandles,
        visibleHandles: visibleHandles ?? this.visibleHandles,
      );
}
