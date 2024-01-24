// app_bar.dart

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xref/canvas_page/canvas_page_leading_button.dart';
import 'package:xref/components/title_bar.dart';

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
    required this.onCloseCanvasTap,
  });

  final Function() onSettingsTap;
  final Function() onCenterFocusTap;
  final bool visibleGrid;
  final Function(bool) onGridToggle;
  final bool canUndo;
  final Function() onUndo;
  final bool canRedo;
  final Function() onRedo;
  final VoidCallback onCloseCanvasTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleBar(
          color: Theme.of(context).colorScheme.surface,
        ),
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              IconButton(
                onPressed: onCenterFocusTap,
                icon: const Icon(Icons.center_focus_strong),
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
          leading: CanvasPageLeadingButton(
            onCloseCanvas: onCloseCanvasTap,
            onSettings: onSettingsTap,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    if (kIsWeb || Platform.isIOS || Platform.isAndroid) {
      return const Size.fromHeight(kToolbarHeight);
    }

    return const Size.fromHeight(kToolbarHeight + 32);
  }
}
