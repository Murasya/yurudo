// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:routine_app/utils/date.dart';

void main() {
  DateTime d1 = DateTime(2000, 1, 1, 12, 30);
  DateTime d2 = DateTime(2000, 1, 4, 15, 00);

  expect(d1.dateDiff(d2), 3);
}
