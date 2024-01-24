import 'package:flutter/material.dart';
import 'package:xref/settings_page/settings_page.dart';

void pushPage(BuildContext context, Widget nextPage) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => nextPage));
}

void pushSettingsPage(BuildContext context) {
  pushPage(context, const SettingsPage());
}
