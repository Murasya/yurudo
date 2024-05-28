import 'package:flutter/material.dart';

import '../../design/app_color.dart';

class DialogCommon extends StatelessWidget {
  final Widget content;
  final VoidCallback onPressed;
  final String title;

  const DialogCommon({
    super.key,
    required this.content,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close),
              ),
            ],
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppColor.fontColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          content,
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                onPressed();
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  }
}
