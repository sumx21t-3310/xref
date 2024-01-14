import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/application/save_data_repository.dart';
import 'package:xref/start_page/start_page_app_bar.dart';

import 'thumbnail_card.dart';

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartPage> {
  void deleteSaveData() {
    setState(() {
      SaveDataRepository().delete(
        SaveData(
          id: const Uuid().v7(),
          title: 'untitled',
          thumbnail: "",
          files: [],
        ),
      );
    });
  }

  void addSaveData() {
    var newData = SaveData(
      title: "untitled",
      id: const Uuid().v7(),
      files: [],
      thumbnail: "",
    );

    ref.read(saveDataRepositoryProvider.notifier).save(newData);
  }

  Widget body() {
    var repository = ref.watch(saveDataRepositoryProvider);

    return GridView.extent(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      children: [
        ...repository.map((saveData) => ThumbnailCard(saveData: saveData))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StartPageAppBar(
        onDeleteTap: deleteSaveData,
        onAddTap: addSaveData,
      ),
      body: body(),
    );
  }
}
