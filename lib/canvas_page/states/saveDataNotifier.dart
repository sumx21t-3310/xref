import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xref/application/save_data.dart';

part 'saveDataNotifier.g.dart';

@riverpod
class SaveDataNotifier extends _$SaveDataNotifier {
  @override
  SaveData build() {
    ref.onDispose(() {});
    return SaveData();
  }
}
