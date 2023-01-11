import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final Widget? label;
  final TextEditingController? controller;
  final String? placeholder;
  final Function(String)? onChanged;
  final VoidCallback? onTap;

  const AppTextField({
    Key? key,
    this.label,
    this.controller,
    this.placeholder,
    this.onChanged,
    this.onTap,
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
        ),
      ],
    );
  }
}