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

    final newState = state;

    if (index >= 0) {
      delete(saveData);
    }

    state = [...newState, saveData];
  }

  void delete(SaveData saveData) {
    var newState = state;
    newState.removeWhere((s) => saveData.id == s.id);
    state = [...newState];
  }
}
