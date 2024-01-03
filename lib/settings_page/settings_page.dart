import 'package:flutter/material.dart';
import 'package:xref/components/switch_platform.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SwitchPlatform(
      innerContent: Scaffold(
        appBar: AppBar(),
      ),
      titleBarColor: Theme.of(context).appBarTheme,
    );
  }
}
