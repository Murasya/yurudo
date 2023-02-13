import 'package:flutter/material.dart';

class DisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
