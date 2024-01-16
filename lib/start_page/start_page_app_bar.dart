import 'package:flutter/material.dart';
import 'package:xref/application/app_config.dart';
import 'package:xref/components/push_page.dart';

class StartPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StartPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          showAboutDialog(
            context: context,
            applicationIcon: const Icon(Icons.image),
            applicationName: AppConfig.appName,
            applicationVersion: 'version-${AppConfig.version}',
            applicationLegalese: '(C) 2024 Nebusoku dev Inc.',
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('ここにアプリの説明、概要などを表示させます。'),
              ),
            ],
          );
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.image), Text("XREF")],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => pushSettingsPage(context),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
