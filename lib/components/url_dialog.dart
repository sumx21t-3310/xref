import 'package:flutter/material.dart';

class URLDialog extends StatefulWidget {
  const URLDialog({Key? key, this.text}) : super(key: key);
  final String? text;

  @override
  _URLDialogState createState() => _URLDialogState();
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
    controller.text = widget.text ?? "";
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          controller.selection = TextSelection(
              baseOffset: 0, extentOffset: controller.text.length);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          autofocus: true,
          focusNode: focusNode,
          controller: controller,
          onFieldSubmitted: (_) => Navigator.of(context).pop(controller.text),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter image url',
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: const Text("OK"),
        ),
      ],
    );
  }
}

Future<String?> showURLDialog(BuildContext context, String text) async {
  return showDialog<String?>(
    context: context,
    builder: (context) => URLDialog(text: text),
  );
}
