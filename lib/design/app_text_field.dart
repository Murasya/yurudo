import 'package:flutter/material.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/utils/disable_focus_node.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController? controller;
  final String? placeholder;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readonly;

  const AppTextField({
    Key? key,
    required this.label,
    this.isRequired = false,
    this.controller,
    this.placeholder,
    this.onChanged,
    this.onTap,
    this.readonly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColor.fontColor,
                fontSize: 14,
              ),
            ),
            if (isRequired)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  '※必須',
                  style: TextStyle(
                    color: AppColor.emphasisColor,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          enableInteractiveSelection: !readonly,
          decoration: InputDecoration(
              hintText: placeholder,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.fontColor),
              )),
          style: const TextStyle(
            fontSize: 14,
            color: AppColor.fontColor,
          ),
          readOnly: readonly,
          focusNode: readonly ? DisableFocusNode() : null,
        ),
      ],
    );
  }
}