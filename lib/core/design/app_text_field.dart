import 'package:flutter/material.dart';
import 'package:routine_app/core/design/app_color.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController? controller;
  final String? placeholder;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readonly;
  final int? maxLines;

  const AppTextField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.controller,
    this.placeholder,
    this.onChanged,
    this.onTap,
    this.readonly = false,
    this.maxLines = 1,
  });

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
                    color: AppColor.emphasis,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 12),

        if (readonly)
          InkWell(
            onTap: onTap,
            child: TextField(
              onTap: onTap,
              onChanged: onChanged,
              controller: controller,
              enableInteractiveSelection: !readonly,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColor.disableColor,
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppColor.fontColor,
              ),
              maxLines: maxLines,
              readOnly: readonly,
              focusNode: readonly ? DisableFocusNode() : null,
            ),
          ),

        if (!readonly)
          TextField(
            onTap: onTap,
            onChanged: onChanged,
            controller: controller,
            enableInteractiveSelection: !readonly,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: AppColor.disableColor,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.fontColor,
            ),
            maxLines: maxLines,
            readOnly: readonly,
            focusNode: readonly ? DisableFocusNode() : null,
          ),

        const Divider(
          thickness: 0.5,
          height: 0.5,
          color: AppColor.fontColor,
        )
      ],
    );
  }
}

class DisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
