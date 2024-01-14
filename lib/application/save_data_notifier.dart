import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/application/save_data_repository.dart';

part 'save_data_notifier.g.dart';

@riverpod
class SaveDataNotifier extends _$SaveDataNotifier {
  @override
  SaveData build() {
    ref.onDispose(
        () => ref.read(saveDataRepositoryProvider.notifier).save(state));

    return SaveData(id: "", title: "", thumbnail: "", files: []);
  }

  void init(SaveData saveData) {
    var newState = state;
    newState.files = saveData.files;
    newState.id = saveData.id;
    newState.thumbnail = saveData.thumbnail;
    newState.files = saveData.files;
    state = newState;
  }

  void addFile(File file) {
    state = state.copyWith(files: [...state.files, file]);
  }
}
