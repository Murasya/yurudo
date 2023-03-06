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
  Category? _selectCategory;
  final dateFormat = DateFormat('y年M月d日');

  @override
  void initState() {
    provider = taskDetailPageStateProvider(widget.todo);
    final TaskDetailPageState state = ref.read(provider);
    _titleController = TextEditingController(text: state.title);
    if (state.span < 7) {
      _spanController = TextEditingController(text: '${state.span}日に1回');
    } else {
      _spanController = TextEditingController(text: '${state.span ~/ 7}週に1回');
    }
    _timeController = TextEditingController(text: '${state.time}分');

    // 次回実施日が昨日以前だった場合は今日にする
    if (state.nextDay != null) {
      _nextDayController =
          TextEditingController(text: dateFormat.format(state.nextDay!));
    } else {
      _nextDayController = TextEditingController(text: '');
    }
    _categoryController =
        TextEditingController(text: state.category?.name ?? '');

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
                ref.read(provider.notifier).setName(value);
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
                    ref.read(provider.notifier).setSpan(span);
                  },
                ).showDialog(context);
              },
            ),
            CheckboxListTile(
              value: state.remind,
              title: const Text('リマインドする'),
              onChanged: (value) {
                ref.read(provider.notifier).setRemind(value ?? false);
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
                        ref
                            .read(provider.notifier)
                            .setCategory(_selectCategory);
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
                    ref.read(provider.notifier).setTime(time);
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
                    final day =
                        (picker.adapter as DateTimePickerAdapter).value!;
                    ref.read(provider.notifier).setNextDay(day);
                    _nextDayController.text = dateFormat.format(day);
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
