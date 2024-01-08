import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/start_page/start_page_app_bar.dart';

import 'thumbnail_card.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late List<SaveData> saveDataList = [];

  @override
  void initState() async {
    super.initState();
  }

  Future<List<SaveData>> findSaveData() async {
    List<SaveData> result = [];
    var dir = await getApplicationDocumentsDirectory();

    return result;
  }

  void deleteThumbnail() {
    if (saveDataList.isEmpty) return;

    setState(() {
      saveDataList.removeAt(0);
    });
  }

  void addThumbnail() {
    setState(
      () => saveDataList.add(SaveData()),
    );
  }

  Widget body() {
    return GridView.extent(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      children: saveDataList
          .map(
            (saveData) => ThumbnailCard(saveData: saveData),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StartPageAppBar(
        onDeleteTap: deleteThumbnail,
        onAddTap: addThumbnail,
      ),
      body: body(),
    );
  }
}
