import 'dart:io';

class SaveData {
  SaveData({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.files,
  });

  String id;
  String title;
  String thumbnail;
  List<File> files;

  SaveData copyWith(
          {String? id, String? title, String? thumbnail, List<File>? files}) =>
      SaveData(
        id: id ?? this.id,
        title: title ?? this.title,
        thumbnail: thumbnail ?? this.thumbnail,
        files: files ?? this.files,
      );
}
