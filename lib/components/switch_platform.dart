import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'title_bar.dart';

class SwitchPlatform extends StatelessWidget {
  const SwitchPlatform({
    super.key,
    this.titleBarColor,
    this.titleBar,
    this.innerContent,
  });

  final AppBarTheme? titleBarColor;
  final TitleBar? titleBar;
  final Widget? innerContent;

  get disableSwitchPlatform => true;

  @override
  Widget build(BuildContext context) {
    if (disableSwitchPlatform) {
      return innerContent ?? Container();
    }

    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      return innerContent ?? Container();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          child: titleBar,
        ),
      ),
      body: innerContent,
    );
  }
}
