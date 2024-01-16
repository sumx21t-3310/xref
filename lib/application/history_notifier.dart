import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:undo/undo.dart';
import 'package:xref/application/app_config.dart';

part 'history_notifier.g.dart';

@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  @override
  ChangeStack build() {
    return ChangeStack(limit: AppConfig.undoLimit);
  }

  void add(List<Change> changeGroup) => state.addGroup(changeGroup);

  void undo() => state.undo();

  void redo() => state.redo();
}
