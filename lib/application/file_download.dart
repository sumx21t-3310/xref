import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

Future<File?> downloadFile(Uri url, Directory directory,
    {String? fileName}) async {
  final res = await get(url);

  final contentType = res.headers["content-type"];
  final extension =
      contentType != null ? extensionFromMime(contentType) : "temp";

  final contentFileName = _getFileNameFromContentDisposition(res);
  final fallbackFileName = "${const Uuid().v7()}.$extension";

  final file = File("${directory.path}/${contentFileName ?? fallbackFileName}");
  return await file.writeAsBytes(res.bodyBytes);
}

String? _getFileNameFromContentDisposition(Response res) {
  final contentDisposition = res.headers["content-disposition"] ?? "";

  if (contentDisposition.isEmpty) return null;

  final regExp = RegExp(r'filename="?([^"]+)"?');
  final match = regExp.firstMatch(contentDisposition) as Match;

  if (match.groupCount != 1) return null;

  return match.group(1);
}

Future<File> copyToDirectory(File file, Directory directory) async {
  var ext = extension(file.path);
  const uuid = Uuid();
  var fileName = uuid.v7();
  var copyPath = "${directory.path}/$fileName$ext";

  debugPrint(copyPath);

  return await file.copy(copyPath);
}
