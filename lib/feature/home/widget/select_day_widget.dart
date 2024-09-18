import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDayWidget extends StatelessWidget {
  final String label;
  final DateTime selectDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onSelectDate;

  const SelectDayWidget({
    super.key,
    required this.label,
    required this.selectDate,
    required this.firstDate,
    required this.lastDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: TextField(
        controller: TextEditingController(
          text: DateFormat.yMd().format(selectDate),
        ),
        readOnly: true,
        autofocus: true,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          label: Text(label),
          border: const OutlineInputBorder(),
        ),
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: selectDate,
            firstDate: firstDate,
            lastDate: lastDate,
          ).then((value) {
            if (value != null) {
              onSelectDate(value);
            }
          });
        },
      ),
    );
  }
}
