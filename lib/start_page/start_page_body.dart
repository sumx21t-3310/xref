import 'package:flutter/material.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/start_page/thumbnail_card.dart';

class StartPageBody extends StatelessWidget {
  const StartPageBody({
    super.key,
    required this.saveDataList,
  });

  final List<SaveData> saveDataList;

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      children: saveDataList
          .map((saveData) => ThumbnailCard(saveData: saveData))
          .toList(),
    );
  }
}
