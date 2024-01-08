import 'dart:io';

class SaveData {
  SaveData({this.title, this.files});

  String? title;
  String? fileName;

  List<File>? files;
}
