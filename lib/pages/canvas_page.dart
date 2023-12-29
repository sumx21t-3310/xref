import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:undo/undo.dart';
import 'package:xref/Components/scrap_image.dart';
import 'package:xref/Pages/settings_page.dart';
import 'package:xref/components/url_dialog.dart';
import 'package:xref/lib/switch_platform.dart';

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  var visibleGrid = true;
  var isPremiumUser = false;
  var isCameraSupport = false;

  String url = "";
  var history = ChangeStack(limit: 50);
  var scraps = <Widget>[];
  var images = <File>[];

  Future _addScrapFromGallery() async {
    var picker = ImagePicker();
    var xFile = await picker.pickImage(source: ImageSource.gallery);

    if (xFile == null) return;
    var image = FileImage(File(xFile.path));
    _addScrap(image);
  }

  Future<void> _addScrapFromURL() async {
    url = (await showURLDialog(context, "")) ?? "";

    print("url: $url");

    if (url.isEmpty) return;

    var image = NetworkImage(url);
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

  SpeedDial speedDial() {
    var options = <SpeedDialChild>[
      SpeedDialChild(
        label: "Add Image: Photo Gallery",
        onTap: _addScrapFromGallery,
      ),
      SpeedDialChild(
        label: "Add Image: URL",
        onTap: _addScrapFromURL,
      ),
      if (isPremiumUser || kDebugMode) ...{
        SpeedDialChild(
          label: "Add Images: Pinterest boards",
          onTap: null,
        )
      }
    ];

    return SpeedDial(
      elevation: 0,
      children: options,
      tooltip: "Add Image",
      child: const Icon(Icons.add_photo_alternate),
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
            value: visibleGrid,
            onChanged: (value) => setState(
              () {
                visibleGrid = value;
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

  Widget body() {
    var grid = SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GridPaper(
        color: Theme.of(context).indicatorColor.withOpacity(.2),
        divisions: 1,
        subdivisions: 5,
      ),
    );

    var content = InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      minScale: 0.1,
      maxScale: 3,
      clipBehavior: Clip.none,
      child: OverflowBox(
        maxWidth: 1000,
        maxHeight: 1000,
        child: SizedBox(
          height: 1000,
          width: 1000,
          child: Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ColoredBox(
                  color: Colors.black12,
                ),
              ),
              ...scraps,
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: [
        grid,
        content,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SwitchPlatform(
      innerContent: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: appBar(),
        floatingActionButton: speedDial(),
        body: body(),
      ),
    );
  }
}
