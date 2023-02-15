import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/design/app_text_field.dart';
import 'package:routine_app/pages/taskDetail/task_detail_page_state.dart';
import 'package:routine_app/pages/widget/date_dialog.dart';
import 'package:routine_app/pages/widget/span_dialog.dart';
import 'package:routine_app/pages/widget/time_dialog.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/viewModel/category_provider.dart';
import 'package:routine_app/viewModel/todo_provider.dart';

import '../../model/category.dart';
import '../../model/todo.dart';
import '../widget/categoryDialog/category_dialog.dart';

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
  late final TextEditingController _titleController;
  late final TextEditingController _spanController;
  late final TextEditingController _categoryController;
  late final TextEditingController _timeController;
  late final TextEditingController _nextDayController;
  late final provider;
  late Category _selectCategory;
  final dateFormat = DateFormat('y年M月d日');

  @override
  void initState() {
    provider = taskDetailPageStateProvider(widget.todo);
    final state = ref.read(provider);
    final todo = state.todo;
    _titleController = TextEditingController(text: todo.name);
    if (todo.span < 7) {
      _spanController = TextEditingController(text: '${todo.span}日に1回');
    } else {
      _spanController =
          TextEditingController(text: '${(todo.span / 7).toInt()}週に1回');
    }
    _timeController = TextEditingController(text: '${todo.time}分');

    // 次回実施日が昨日以前だった場合は今日にする
    if (DateTime.now().isBefore(todo.date)) {
      _nextDayController =
          TextEditingController(text: dateFormat.format(todo.date));
    } else {
      _nextDayController =
          TextEditingController(text: dateFormat.format(DateTime.now()));
    }

    final categoryList = ref.read(categoryProvider);
    _selectCategory = categoryList.firstWhere(
        (category) => category.categoryId == widget.todo.categoryId.first);
    _categoryController = TextEditingController(text: _selectCategory.name);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    final TaskDetailPageState state = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('編集画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextField(
              label: 'タイトル',
              controller: _titleController,
              onChanged: (value) {
                final todo = state.todo.copyWith(
                  name: value,
                );
                ref.read(provider.notifier).updateTodo(todo);
              },
            ),
            AppTextField(
              label: 'スパン',
              readonly: true,
              controller: _spanController,
              onTap: () {
                SpanDialog(
                  onConfirm: (picker, value) {
                    var ans = picker.getSelectedValues();
                    _spanController.text = '${ans[0]}${ans[1]}に1回';
                    int span;
                    switch (value[1]) {
                      case 1:
                        span = ans[0] * 7;
                        break;
                      default:
                        span = ans[0];
                        break;
                    }
                    final todo = state.todo.copyWith(span: span);
                    ref.read(provider.notifier).updateTodo(todo);
                  },
                ).showDialog(context);
              },
            ),
            CheckboxListTile(
              value: state.todo.remind,
              title: const Text('リマインドする'),
              onChanged: (value) {
                final todo = state.todo.copyWith(remind: value);
                ref.read(provider.notifier).updateTodo(todo);
              },
            ),
            AppTextField(
              label: '分類',
              readonly: true,
              controller: _categoryController,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CategoryDialog(
                      defaultValue: _selectCategory,
                      onConfirm: (value) {
                        final todo =
                            state.todo.copyWith(categoryId: [value.categoryId]);
                        ref.read(provider.notifier).updateTodo(todo);
                        _selectCategory = value;
                        _categoryController.text = value.name;
                      },
                    );
                  },
                );
              },
            ),
            AppTextField(
              label: '時間',
              readonly: true,
              controller: _timeController,
              onTap: () {
                TimeDialog(
                  onConfirm: (picker, value) {
                    var ans = picker.getSelectedValues();
                    int time;
                    switch (ans[1]) {
                      case 1:
                        time = ans[0] * 60;
                        break;
                      default:
                        time = ans[0];
                        break;
                    }
                    final todo = state.todo.copyWith(time: time);
                    ref.read(provider.notifier).updateTodo(todo);
                    _timeController.text = '${ans[0]}${ans[1]}';
                  },
                ).showDialog(context);
              },
            ),
            AppTextField(
              label: '実施予定日',
              controller: _nextDayController,
              readonly: true,
              onTap: () {
                DateDialog(
                  onConfirm: (picker, value) {
                    final todo = state.todo.copyWith(
                        date: (picker.adapter as DateTimePickerAdapter).value!);
                    ref.read(provider.notifier).updateTodo(todo);
                    _nextDayController.text = dateFormat.format(todo.date!);
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
    var state = ref.read(provider);
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        ref.read(todoProvider.notifier).update(state.todo);
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
