import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grid_toggle_notifier.g.dart';

@Riverpod(keepAlive: true)
class GridToggleNotifier extends _$GridToggleNotifier {
  @override
  bool build() => true;

  void setValue(bool value) => state = !state;
}
