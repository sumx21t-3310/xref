import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/application/save_data_repository.dart';
import 'package:xref/canvas_page/canvas_page.dart';
import 'package:xref/components/push_page.dart';
import 'package:xref/start_page/start_page_app_bar.dart';
import 'package:xref/start_page/start_page_drawer.dart';

import 'thumbnail_card.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  void addSaveData(WidgetRef ref) {
    var newData = SaveData(
      title: "untitled",
      id: const Uuid().v7(),
      boxes: [],
    );

    ref.read(saveDataRepositoryProvider.notifier).save(newData);
  }

  void deleteData(WidgetRef ref, SaveData saveData) {
    ref.read(saveDataRepositoryProvider.notifier).delete(saveData);
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    var repository = ref.watch(saveDataRepositoryProvider);

    return GridView.extent(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      children: [
        for (var index = 0; index < repository.length; index++) ...{
          ThumbnailCard(
            title: repository[index].title,
            image: const NetworkImage('https://placehold.jp/150x150.png'),
            onTap: () {
              pushPage(context, CanvasPage(id: repository[index].id));
            },
            onDelete: () => ref
                .read(saveDataRepositoryProvider.notifier)
                .delete(repository[index]),
          )
        },
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const StartPageAppBar(),
      body: buildBody(context, ref),
      drawer: const StartPageDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => addSaveData(ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
