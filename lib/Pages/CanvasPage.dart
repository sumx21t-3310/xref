import 'package:flutter/material.dart';
import 'package:xref/Components/ScrapImage.dart';

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  var scraps = <Widget>[];

  void addScrap() {
    scraps.add(
        ScrapImage(provider: NetworkImage("https://placehold.jp/200x200.png")));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() => addScrap());
          },
          child: const Icon(Icons.add),
        ),
        body: Stack(
          children: [
            // gridBackGround(10),
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
        ));
  }
}
