import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:undo/undo.dart';
import 'package:xref/application/file_download.dart';
import 'package:xref/canvas_page/canvas_page_app_bar.dart';
import 'package:xref/canvas_page/canvas_page_body.dart';
import 'package:xref/canvas_page/canvas_page_speed_dial.dart';
import 'package:xref/canvas_page/scrap_image.dart';
import 'package:xref/components/url_dialog.dart';
import 'package:xref/settings_page/settings_page.dart';

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  var _visibleGrid = true;
  final isPremiumUser = false;
  final isCameraSupported = false;

  String url = "";
  final _history = ChangeStack(limit: 50);
  var _scraps = <Widget>[];
  final _images = <File>[];

  Future _addScrapFromGallery() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.gallery);

    if (xFile == null) return;

    final file = File(xFile.path);
    final image = FileImage(File(xFile.path));
    _addScrap(image);
  }

  Future _addScrapFromClipBoard() async {}

  Future _addScrapFromPinterestBoard() async {}

  Future _addScrapTakePhoto() async {}

  Future _addScrapFromURL() async {
    url = (await showURLDialog(context, "")) ?? "";

    if (url.isEmpty) return;

    var dir = await getApplicationDocumentsDirectory();
    var file = await downloadFile(Uri.parse(url), dir);

    if (file == null) {
      return;
    }

    var image = FileImage(file);

    _addScrap(image);
  }

  Future _addScrap(ImageProvider image) async {
    var directory = await getApplicationDocumentsDirectory();

    _history.addGroup(
      [
        Change(
          [..._scraps],
          () => setState(() => _scraps.add(ScrapImage(provider: image))),
          (oldValue) => setState(() => _scraps = [...oldValue]),
        ),
      ],
    );
  }

  void routeSettingsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CanvasPageAppBar(
        onSettingsTap: routeSettingsPage,
        visibleGrid: _visibleGrid,
        onGridToggle: (changeValue) {
          setState(() => _visibleGrid = changeValue);
        },
        canUndo: _history.canUndo,
        onUndo: _history.undo,
        canRedo: _history.canRedo,
        onRedo: _history.redo,
      ),
      body: CanvasPageBody(
        visibleGrid: _visibleGrid,
        children: _scraps,
      ),
      floatingActionButton: CanvasPageSpeedDial(
        onGalleryTap: _addScrapFromGallery,
        onClipBoardTap: _addScrapFromClipBoard,
        onURLTap: _addScrapFromURL,
        onPinterestTap: _addScrapFromPinterestBoard,
        onTakePhoto: _addScrapTakePhoto,
        isPremiumUser: isPremiumUser,
        isCameraSupported: isCameraSupported,
      ),
    );
  }
}
