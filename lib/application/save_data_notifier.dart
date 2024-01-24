import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xref/application/box_data.dart';
import 'package:xref/application/save_data.dart';
import 'package:xref/application/save_data_repository.dart';

final saveDataNotifierProvider = StateNotifierProvider.autoDispose(
  (ref) {
    var saveData = ref.watch(saveDataRepositoryProvider).first;
    return SaveDataNotifier(saveData);
  },
);

class SaveDataNotifier extends StateNotifier<SaveData> {
  SaveDataNotifier(super.state);

  void addBox(BoxData boxData) {
    final newState = state.copyWith();
    newState.boxes.add(boxData);
    state = newState;
  }

  void deleteBox(int index) {
    final newState = state.copyWith();
    newState.boxes.removeAt(index);
    state = newState;
  }

  void save(Ref ref) =>
      ref.read(saveDataRepositoryProvider.notifier).save(state);
}
