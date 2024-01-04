import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatefulWidget {
  const TitleBar({super.key, this.title, this.icon, this.color});

  final Widget? title;
  final Widget? icon;
  final Color? color;

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: widget.icon,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: MoveWindow(
                child: widget.title,
              ),
            ),
          ),
          Row(
            children: [
              MinimizeWindowButton(),
              MaximizeWindowButton(),
              CloseWindowButton(
                colors: WindowButtonColors(mouseOver: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
