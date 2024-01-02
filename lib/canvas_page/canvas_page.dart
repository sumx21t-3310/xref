import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:undo/undo.dart';
import 'package:xref/canvas_page/canvas_page_body.dart';
import 'package:xref/canvas_page/canvas_page_speed_dial.dart';
import 'package:xref/canvas_page/scrap_image.dart';
import 'package:xref/components/url_dialog.dart';
import 'package:xref/lib/file_download.dart';
import 'package:xref/settings_page/settings_page.dart';

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  var _visibleGrid = true;
  var isPremiumUser = false;
  var isCameraSupport = false;

  String url = "";
  var history = ChangeStack(limit: 50);
  var scraps = <Widget>[];
  var images = <File>[];

  Future _addScrapFromGallery() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.gallery);

    if (xFile == null) return;
    final image = FileImage(File(xFile.path));
    _addScrap(image);
  }

  void _addScrapFromClipBoard() {}

  Future<void> _addScrapFromURL() async {
    url = (await showURLDialog(context, "")) ?? "";

    if (url.isEmpty) return;

    var dir = await getApplicationDocumentsDirectory();
    var file = await downloadFile(Uri.parse(url), dir);

    if (file == null) {
      return;
    }

    images.add(file);
    var image = FileImage(file);

    _addScrap(image);
  }

  void _addScrap(ImageProvider image) {
    history.add(
      Change(
        [...scraps],
        () => setState(() => scraps.add(ScrapImage(provider: image))),
        (oldValue) => setState(() => scraps = [...oldValue]),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  ),
              icon: const Icon(Icons.settings)),
          Switch(
            value: _visibleGrid,
            onChanged: (value) => setState(
              () {
                _visibleGrid = value;
              },
            ),
          )
        ],
      ),
      actions: [
        IconButton(
            tooltip: "undo",
            onPressed: history.canUndo ? history.undo : null,
            icon: const Icon(Icons.undo)),
        IconButton(
            tooltip: "redo",
            onPressed: history.canRedo ? history.redo : null,
            icon: const Icon(Icons.redo)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: CanvasPageBody(),
      floatingActionButton: CanvasPageSpeedDial(
        onGalleryTap: _addScrapFromGallery,
        onClipBoardTap: _addScrapFromClipBoard,
        onURLTap: _addScrapFromURL,
        onPinterestTap: () {},
        isPremiumUser: isPremiumUser,
      ),
    );
  }
}
