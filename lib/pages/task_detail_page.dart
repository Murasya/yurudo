import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_app/design/app_text_field.dart';
import 'package:routine_app/pages/widget/date_dialog.dart';
import 'package:routine_app/pages/widget/span_dialog.dart';
import 'package:routine_app/pages/widget/time_dialog.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/viewModel/category_provider.dart';
import 'package:routine_app/viewModel/todo_provider.dart';

import '../model/category.dart';
import '../model/todo.dart';
import 'widget/category_dialog.dart';

class TaskDetailPage extends ConsumerStatefulWidget {
  final Todo todo;

  const TaskDetailPage({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends ConsumerState<TaskDetailPage> {
  late int _span;
  late bool _remind;
  late int _time;
  late Category _selectCategory;
  late DateTime _nextDay;
  late final TextEditingController _titleController;
  late final TextEditingController _spanController;
  late final TextEditingController _categoryController;
  late final TextEditingController _timeController;
  late final TextEditingController _nextDayController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.name);
    _span = widget.todo.span;
    _spanController = TextEditingController(text: '$_span日に1回');
    _remind = widget.todo.remind;
    _time = widget.todo.time;
    _timeController = TextEditingController(text: '$_time分');
    _nextDay = widget.todo.date;
    _nextDayController = TextEditingController(
        text: '${_nextDay.year}年${_nextDay.month}月${_nextDay.day}日');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final categoryList = ref.watch(categoryProvider);
    _selectCategory = categoryList.firstWhere(
        (category) => category.categoryId == widget.todo.categoryId.first);
    _categoryController = TextEditingController(text: _selectCategory.name);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _spanController.dispose();
    _categoryController.dispose();
    _timeController.dispose();
    _nextDayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('編集画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextField(
              label: const Text('タイトル'),
              controller: _titleController,
            ),
            AppTextField(
              label: const Text('スパン'),
              controller: _spanController,
              onTap: () {
                SpanDialog(
                  onConfirm: (picker, value) {
                    var ans = picker.getSelectedValues();
                    _spanController.text = '${ans[0]}${ans[1]}に一回';
                    switch (value[1]) {
                      case 1:
                        _span = ans[0] * 7;
                        break;
                      default:
                        _span = ans[0];
                        break;
                    }
                  },
                ).showDialog(context);
              },
            ),
            CheckboxListTile(
              value: _remind,
              title: const Text('リマインドする'),
              onChanged: (value) {
                setState(() => _remind = value!);
              },
            ),
            AppTextField(
              label: const Text('分類'),
              controller: _categoryController,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CategoryDialog(
                      defaultValue: _selectCategory,
                      onConfirm: (value) {
                        _selectCategory = value;
                        _categoryController.text = value.name;
                      },
                    );
                  },
                );
              },
            ),
            AppTextField(
              label: const Text('要する時間'),
              controller: _timeController,
              onTap: () {
                TimeDialog(
                  onConfirm: (picker, value) {
                    var ans = picker.getSelectedValues();
                    switch (ans[1]) {
                      case 1:
                        _time = ans[0] * 60;
                        break;
                      default:
                        _time = ans[0];
                        break;
                    }
                    _timeController.text = '${ans[0]}${ans[1]}';
                  },
                ).showDialog(context);
              },
            ),
            AppTextField(
              label: const Text('次回実施日'),
              controller: _nextDayController,
              onTap: () {
                DateDialog(
                  onConfirm: (picker, value) {
                    _nextDay = (picker.adapter as DateTimePickerAdapter).value!;
                    _nextDayController.text =
                        '${_nextDay.year}年${_nextDay.month}月${_nextDay.day}日';
                  },
                ).showDialog(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                deleteButton(),
                finishEditButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget finishEditButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        Todo newTodo = widget.todo.copyWith(
          name: _titleController.text,
          span: _span,
          remind: _remind,
          categoryId: [_selectCategory.categoryId],
          time: _time,
          date: _nextDay,
        );
        ref.read(todoProvider.notifier).update(newTodo);
      },
      child: const Text('編集終了'),
    );
  }

  Widget deleteButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.error),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('本当に削除しますか？'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(AppRouter.home),
                  );
                  ref.read(todoProvider.notifier).delete(widget.todo.id!);
                },
                child: const Text('削除する'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('削除しない'),
              ),
            ],
          ),
        );
      },
      child: const Text('削除する'),
    );
  }
}
