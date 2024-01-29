import 'dart:io';

import 'package:xref/canvas_page/box_data.dart';

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
  List<ImageBoxData> boxes;

  SaveData copyWith({
    String? id,
    String? title,
    File? thumbnail,
    List<ImageBoxData>? boxes,
  }) {
    return SaveData(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      boxes: boxes ?? this.boxes,
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title};
  }
}
