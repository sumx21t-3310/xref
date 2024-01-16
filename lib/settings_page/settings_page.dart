import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xref/application/grid_toggle_notifier.dart';
import 'package:xref/application/theme_mode_notifier.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  Widget settingCard(String title, Widget control) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: control,
      ),
    );
  }

  List<Widget> buildSettings(WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final visibleGrid = ref.watch(gridToggleNotifierProvider);

    return [
      settingCard(
        "Visible Grid",
        Switch(
            value: visibleGrid,
            onChanged: ref.read(gridToggleNotifierProvider.notifier).setValue),
      ),
      settingCard(
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
