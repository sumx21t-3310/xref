import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xref/application/save_data.dart';

part 'save_data_repository.g.dart';

@riverpod
class SaveDataRepository extends _$SaveDataRepository {
  @override
  List<SaveData> build() {
    return [];
  }

  void save(SaveData saveData) {
    final index = state.indexWhere((e) => e.id == saveData.id);

    state = [...state, saveData];
  }

  void delete(SaveData saveData) {
    if (state.isEmpty) return;
    var newState = state;

    newState.remove(saveData);
    state = newState;
  }
}
