import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:undo/undo.dart';
import 'package:xref/Components/ScrapImage.dart';
import 'package:xref/Components/GridBackground.dart';

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  var visibleGrid = true;
  var history = ChangeStack(limit: 50);
  var scraps = <Widget>[];

  Future _addScrapFromGallery() async {
    var picker = ImagePicker();
    var xFile = await picker.pickImage(source: ImageSource.gallery);

    if (xFile == null) return;
    var image = FileImage(File(xFile.path));
    _addScrap(image);
  }

  void _addScrapFromURL(String url) {
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
        onTap: () =>
            showDialog(context: context, builder: (context) => urlDialog()),
      ),
      SpeedDialChild(
        label: "Add Images: Pinterest boards",
        onTap: null,
      ),
      SpeedDialChild(
        label: "AddImage: Take Photo",
        onTap: null,
      )
    ];

    return SpeedDial(
      children: options,
      tooltip: "Add Image",
      child: const Icon(Icons.add_photo_alternate),
    );
  }

  AppBar appBar() {
    return AppBar(
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

  AlertDialog urlDialog() {
    return const AlertDialog(
      title: Text("Input URL(https://~)"),
      actions: [
        TextButton(onPressed: null, child: Text("OK")),
        TextButton(onPressed: null, child: Text("Cancel")),
      ],
    );
  }

  Widget body() {
    return Stack(
      children: [
        if (visibleGrid)
          GridBackground(
            borderWidth: 1,
            gridSize: 25,
          ),
        InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(double.infinity),
          minScale: 0.1,
          maxScale: 1.6,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: scraps,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: speedDial(),
      body: body(),
    );
  }
}
