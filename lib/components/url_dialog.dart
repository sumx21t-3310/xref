import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class URLDialog extends HookWidget {
  const URLDialog({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final node = useFocusNode();

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          autofocus: true,
          focusNode: node,
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
