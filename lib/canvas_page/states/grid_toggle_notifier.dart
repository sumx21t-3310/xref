import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grid_toggle_notifier.g.dart';

@riverpod
class GridToggleNotifier extends _$GridToggleNotifier {
  @override
  bool build() {
    return false;
  }

  void toggle(bool value) {
    state = value;
  }
}
