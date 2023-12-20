import 'package:flutter/material.dart';

class URLDialog extends StatefulWidget {
  const URLDialog({super.key, this.url, Function? onEdited});

  final String? url;

  @override
  State<StatefulWidget> createState() => _URLDialogState();
}

class _URLDialogState extends State<URLDialog> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.text = widget.url ?? "";

    focusNode.addListener(() {
      if (focusNode.hasFocus) return;
      controller.selection =
          TextSelection(baseOffset: 0, extentOffset: controller.text.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextFormField(
        autofocus: true,
      ),
    );
  }
}
