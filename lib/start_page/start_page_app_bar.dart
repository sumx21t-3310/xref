import 'package:flutter/material.dart';
import 'package:xref/settings_page/settings_page.dart';

class StartPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StartPageAppBar({
    super.key,
    required this.onDeleteTap,
    required this.onAddTap,
  });

  final Function() onDeleteTap;
  final Function() onAddTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SettingsPage(),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onDeleteTap,
          icon: const Icon(Icons.delete),
        ),
        IconButton(
          onPressed: onAddTap,
          icon: const Icon(Icons.add),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
