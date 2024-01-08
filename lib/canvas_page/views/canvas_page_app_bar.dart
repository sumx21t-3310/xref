// app_bar.dart

import 'package:flutter/material.dart';

class CanvasPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CanvasPageAppBar({
    super.key,
    required this.onSettingsTap,
    required this.onCenterFocusTap,
    required this.visibleGrid,
    required this.onGridToggle,
    required this.canUndo,
    required this.onUndo,
    required this.canRedo,
    required this.onRedo,
  });

  final Function() onSettingsTap;
  final Function() onCenterFocusTap;
  final bool visibleGrid;
  final Function(bool) onGridToggle;
  final bool canUndo;
  final Function() onUndo;
  final bool canRedo;
  final Function() onRedo;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          IconButton(
            onPressed: onSettingsTap,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: onCenterFocusTap,
            icon: const Icon(Icons.center_focus_strong),
          ),
          Switch(
            value: visibleGrid,
            onChanged: onGridToggle,
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: "undo",
          onPressed: canUndo ? onUndo : null,
          icon: const Icon(Icons.undo),
        ),
        IconButton(
          tooltip: "redo",
          onPressed: canRedo ? onRedo : null,
          icon: const Icon(Icons.redo),
        ),
      ],
    );
  }
}
