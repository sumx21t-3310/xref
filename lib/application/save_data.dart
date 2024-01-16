import 'dart:io';

import 'package:xref/application/box_data.dart';

class SaveData {
  SaveData({
    required this.id,
    required this.title,
    this.thumbnail,
    required this.boxes,
  });

  String id;
  String title;
  File? thumbnail;
  List<BoxData> boxes;

  SaveData copyWith({
    String? id,
    String? title,
    File? thumbnail,
    List<BoxData>? boxes,
  }) {
    return SaveData(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      boxes: boxes ?? this.boxes,
    );
  }
}
