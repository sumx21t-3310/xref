import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xref/application/grid_toggle_notifier.dart';
import 'package:xref/application/theme_mode_notifier.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  Widget buildTile(String title, Widget control, {String? description}) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: description?.isNotEmpty ?? false ? Text(description!) : null,
        trailing: control,
      ),
    );
  }

  List<Widget> buildSettings(WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);

    return [
      buildTile(
        "Visible Grid",
        Switch(
          value: ref.watch(gridToggleNotifierProvider),
          onChanged: ref.read(gridToggleNotifierProvider.notifier).setValue,
        ),
      ),
      buildTile(
        "Theme Mode",
        IconButton(
          onPressed: ref.read(themeModeNotifierProvider.notifier).toggleMode,
          icon: Icon(() {
            return switch (themeMode) {
              ThemeMode.system => Icons.brightness_auto,
              ThemeMode.light => Icons.light_mode,
              ThemeMode.dark => Icons.dark_mode,
            };
          }()),
        ),
      ),
      buildTile(
        "Window on the top",
        Switch(value: false, onChanged: (value) {}),
      )
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.settings), Text("SETTINGS")],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: buildSettings(ref),
        ),
      ),
    );
  }
}
