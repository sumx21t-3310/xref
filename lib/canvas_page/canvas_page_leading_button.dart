import 'package:flutter/material.dart';

class CanvasPageLeadingButton extends StatelessWidget {
  const CanvasPageLeadingButton({
    super.key,
    this.onCloseCanvas,
    this.onSettings,
  });

  final VoidCallback? onCloseCanvas;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          onPressed: controller.isOpen ? controller.close : controller.open,
          icon: const Icon(Icons.more_vert),
        );
      },
      menuChildren: [
        MenuItemButton(
          child: Text("Close Canvas"),
          onPressed: onCloseCanvas,
        ),
        MenuItemButton(
          child: Text("Settings"),
          onPressed: onSettings,
        )
      ],
    );
  }
}
