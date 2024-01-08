import 'dart:io';

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

  void addFile(File file) {
    state.addGroup([]);
  }
}
