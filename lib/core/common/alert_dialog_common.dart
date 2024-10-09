import 'package:flutter/material.dart';

class AlertDialogCommon extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onPositiveButton;
  final VoidCallback onNegativeButton;

  const AlertDialogCommon({
    super.key,
    required this.title,
    required this.content,
    required this.onPositiveButton,
    required this.onNegativeButton,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            onNegativeButton();
            Navigator.pop(context);
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            onPositiveButton();
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
