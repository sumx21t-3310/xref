import 'package:flutter/material.dart';
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

  void addScrap() {
    var provider = NetworkImage("https://placehold.jp/200x200.png");

    history.add(Change(
        [...scraps],
        () => setState(() => scraps.add(ScrapImage(provider: provider))),
        (oldValue) => setState(() => scraps = [...oldValue])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => history.undo(),
                color: history.canUndo ? Colors.blueAccent : Colors.black12,
                icon: const Icon(Icons.undo)),
            IconButton(
                onPressed: () => history.redo(),
                color: history.canRedo ? Colors.blueAccent : Colors.black12,
                icon: const Icon(Icons.redo)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addScrap(),
          child: const Icon(Icons.add),
        ),
        body: (Stack(
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
        )));
  }
}
