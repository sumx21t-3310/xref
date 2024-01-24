import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/application/save_data_notifier.dart';
import 'package:xref/application/save_data_repository.dart';
import 'package:xref/canvas_page/canvas_page.dart';
import 'package:xref/components/push_page.dart';
import 'package:xref/start_page/start_page_app_bar.dart';
import 'package:xref/start_page/start_page_drawer.dart';

import 'thumbnail_card.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

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
              pushPage(
                context,
                ProviderScope(
                  overrides: [
                    saveDataNotifierProvider.overrideWith(
                        (ref) => SaveDataNotifier(repository[index]))
                  ],
                  child: CanvasPage(id: repository[index].id),
                ),
              );
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
        onPressed: ref.read(saveDataRepositoryProvider.notifier).add,
        child: const Icon(Icons.add),
      ),
    );
  }
}
