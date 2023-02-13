import 'package:flutter/material.dart';
import 'package:routine_app/utils/disable_focus_node.dart';

class AppTextField extends StatelessWidget {
  final Widget? label;
  final TextEditingController? controller;
  final String? placeholder;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readonly;

  const AppTextField({
    Key? key,
    this.label,
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
        TextField(
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            label: label,
          ),
          readOnly: readonly,
          focusNode: readonly ? DisableFocusNode() : null,
        ),
      ],
    );
  }
}