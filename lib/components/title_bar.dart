import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container();
    }
    if (Platform.isAndroid || Platform.isIOS) {
      return SafeArea(child: Container());
    }

    var titleBar = [moveHandle(), windowButtons()];

    return Container(
      color: color,
      child: WindowTitleBarBox(
        child: Row(
          children: titleBar,
        ),
      ),
    );
  }

  Widget moveHandle() => Expanded(child: MoveWindow());

  Widget windowButtons() => Row(
        children: [
          MinimizeWindowButton(),
          MaximizeWindowButton(),
          CloseWindowButton(),
        ],
      );
}
