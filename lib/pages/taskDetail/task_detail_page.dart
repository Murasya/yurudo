import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/design/app_style.dart';
import 'package:routine_app/design/app_text_field.dart';
import 'package:routine_app/pages/taskDetail/task_detail_page_state.dart';
import 'package:routine_app/pages/widget/date_dialog.dart';
import 'package:routine_app/pages/widget/span_dialog.dart';
import 'package:routine_app/pages/widget/time_dialog.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/utils/int_ex.dart';
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
  late final TextEditingController _timeController;
  late final TextEditingController _nextDayController;
  late final AutoDisposeStateNotifierProvider<TaskDetailPageStateNotifier,
      TaskDetailPageState> provider;
  Category? _selectCategory;
  final dateFormat = DateFormat('y/M/d');

  @override
  void initState() {
    provider = taskDetailPageStateProvider(widget.todo);
    final TaskDetailPageState state = ref.read(provider);
    _titleController = TextEditingController(text: state.title);
    _spanController = TextEditingController(text: state.span.toSpanString());
    _timeController = TextEditingController(text: state.time.toTimeString());

    // 次回実施日が昨日以前だった場合は今日にする
    if (state.nextDay != null) {
      _nextDayController =
          TextEditingController(text: dateFormat.format(state.nextDay!));
    } else {
      _nextDayController = TextEditingController(text: '');
    }
    _selectCategory = state.category;

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
    _timeController.dispose();
    _nextDayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TaskDetailPageState state = ref.watch(provider);
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondaryColor,
        foregroundColor: AppColor.fontColor,
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ゆるDOの詳細',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            finishEditButton(),
            const SizedBox(height: 12),
            deleteButton(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTextField(
                label: 'タイトル',
                controller: _titleController,
                onChanged: (value) {
                  ref.read(provider.notifier).setName(value);
                },
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: deviceWidth / 2 - 20,
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'スパン',
                          readonly: true,
                          controller: _spanController,
                          onTap: () {
                            SpanDialog(
                              onConfirm: (picker, value) {
                                var ans = picker.getSelectedValues();
                                int span;
                                switch (value[1]) {
                                  case 1:
                                    span = ans[0] * 7;
                                    break;
                                  case 2:
                                    span = ans[0] * 30;
                                    break;
                                  default:
                                    span = ans[0];
                                    break;
                                }
                                _spanController.text = span.toSpanString();
                                ref.read(provider.notifier).setSpan(span);
                              },
                            ).showDialog(context);
                          },
                        ),
                        const SizedBox(height: 30),
                        CategoryTextField(
                          category: _selectCategory,
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
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        AppTextField(
                          label: '必要時間',
                          readonly: true,
                          controller: _timeController,
                          onTap: () {
                            TimeDialog(
                              onConfirm: (picker, value) {
                                var ans = picker.getSelectedValues();
                                int time = ans[0];
                                ref.read(provider.notifier).setTime(time);
                                _timeController.text = time.toTimeString();
                              },
                            ).showDialog(context);
                          },
                        ),
                        const SizedBox(height: 30),
                        AppTextField(
                          label: '実施予定日',
                          controller: _nextDayController,
                          readonly: true,
                          onTap: () {
                            DateDialog(
                              onConfirm: (picker, value) {
                                final day =
                                    (picker.adapter as DateTimePickerAdapter)
                                        .value!;
                                ref.read(provider.notifier).setNextDay(day);
                                _nextDayController.text =
                                    dateFormat.format(day);
                              },
                            ).showDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: deviceWidth / 2 - 20,
                    padding: const EdgeInsets.only(top: 25),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: state.remind,
                      activeColor: AppColor.fontColor2,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      title: Transform.translate(
                        offset: const Offset(-20, 0),
                        child: const Text(
                          'リマインドする',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        ref.read(provider.notifier).setRemind(value ?? false);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget finishEditButton() {
    var state = ref.read(provider);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: AppStyle.button.copyWith(
          backgroundColor:
              const MaterialStatePropertyAll(AppColor.disableColor),
        ),
        onPressed: () {
          Navigator.pop(context);
          ref.read(todoProvider.notifier).update(widget.todo, state);
        },
        child: const Text('変更を保存する'),
      ),
    );
  }

  Widget deleteButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: AppStyle.button.copyWith(
          backgroundColor:
              const MaterialStatePropertyAll(AppColor.secondaryColor),
          foregroundColor: const MaterialStatePropertyAll(AppColor.fontColor2),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  Text(
                    '${widget.todo.name}\nを本当に削除しますか？',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: AppStyle.button.copyWith(
                        backgroundColor: const MaterialStatePropertyAll(
                            AppColor.emphasisColor),
                        textStyle: MaterialStatePropertyAll(
                            context.textTheme.bodyLarge),
                      ),
                      onPressed: () {
                        ref.read(todoProvider.notifier).delete(widget.todo.id!);
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName(AppRouter.home),
                        );
                      },
                      child: const Text('削除する'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: AppStyle.button.copyWith(
                        backgroundColor: const MaterialStatePropertyAll(
                            AppColor.secondaryColor),
                        foregroundColor:
                            const MaterialStatePropertyAll(AppColor.fontColor2),
                        textStyle: MaterialStatePropertyAll(
                          context.textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('削除しない'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Text('削除する'),
      ),
    );
  }
}
