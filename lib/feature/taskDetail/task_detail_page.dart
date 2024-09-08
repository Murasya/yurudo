import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/core/design/app_color.dart';
import 'package:routine_app/core/design/app_style.dart';
import 'package:routine_app/core/design/app_text_field.dart';
import 'package:routine_app/feature/taskDetail/task_detail_page_state.dart';
import 'package:routine_app/core/utils/contextEx.dart';
import 'package:routine_app/core/utils/date.dart';
import 'package:routine_app/core/utils/int_ex.dart';
import 'package:routine_app/core/common/dateDialog/date_dialog.dart';
import 'package:routine_app/core/common/spanDialog/span_dialog.dart';
import 'package:routine_app/core/common/timeDialog/time_dialog.dart';

import '../../core/common/categoryDialog/category_dialog.dart';
import '../../repository/todo/todo.dart';
import '../../repository/todo/todo_provider.dart';
import '../../core/services/notification_service.dart';

final isChangedProvider = Provider.autoDispose.family<bool, Todo>((ref, todo) {
  final state = ref.watch(taskDetailPageStateProvider(todo));
  return state.title != todo.name ||
      state.span != todo.span ||
      state.category?.id != todo.categoryId ||
      state.time != todo.time ||
      !state.nextDay.isSameDay(todo.expectedDate) ||
      state.remind != todo.remind;
});

class TaskDetailPage extends ConsumerStatefulWidget {
  final TaskDetailPageArgs args;

  const TaskDetailPage({
    required this.args,
    super.key,
  });

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
  final dateFormat = DateFormat('y/M/d');

  @override
  void initState() {
    provider = taskDetailPageStateProvider(widget.args.todo);
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
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
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SpanDialog(
                                    onConfirm: (number, spanType) {
                                      int span = number * spanType.term;
                                      _spanController.text =
                                          span.toSpanString();
                                      ref.read(provider.notifier).setSpan(span);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          CategoryTextField(
                            category: state.category,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CategoryDialog(
                                    defaultValue: state.category,
                                    onConfirm: (value) {
                                      ref
                                          .read(provider.notifier)
                                          .setCategory(value);
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
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDialog(
                                context: context,
                                builder: (context) => TimeDialog(
                                  onConfirm: (value) {
                                    ref.read(provider.notifier).setTime(value);
                                    _timeController.text = value.toTimeString();
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          AppTextField(
                            label: '実施予定日',
                            controller: _nextDayController,
                            readonly: true,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final orgTodo = ref
                                  .read(todoProvider.notifier)
                                  .getTodoFromId(widget.args.todo.id);
                              if (state.nextDay
                                      .isSameDay(orgTodo.expectedDate) &&
                                  !widget.args.isCompleted) {
                                showDialog(
                                  context: context,
                                  builder: (context) => DateDialog(
                                    onConfirm: (DateTime date) {
                                      ref
                                          .read(provider.notifier)
                                          .setNextDay(date);
                                      _nextDayController.text =
                                          dateFormat.format(date);
                                      Navigator.pop(context);
                                    },
                                    onCancel: () => Navigator.pop(context),
                                  ),
                                );
                              } else {
                                context.showSnackBar(const SnackBar(
                                    content: Text('この実施予定日は変更できません')));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Ink(
                      width: deviceWidth / 2 - 20,
                      padding: const EdgeInsets.only(top: 25, left: 12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          ref.read(provider.notifier).setRemind(!state.remind);
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              value: state.remind,
                              activeColor: AppColor.fontColor2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (value) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                ref
                                    .read(provider.notifier)
                                    .setRemind(value ?? false);
                              },
                            ),
                            Transform.translate(
                              offset: const Offset(-7, 0),
                              child: const Text(
                                'リマインドする',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget finishEditButton() {
    var state = ref.read(provider);
    var isChanged = ref.watch(isChangedProvider(widget.args.todo));

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: AppStyle.primaryButton,
        onPressed: (isChanged)
            ? () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (state.remind) {
                  ref.watch(notificationServiceProvider).requestPermissions();
                }
                Navigator.pop(context);
                ref.read(todoProvider.notifier).update(widget.args.todo, state);
                context.showSnackBar(
                  const SnackBar(
                    content: Text('変更しました'),
                  ),
                );
              }
            : null,
        child: const Text('変更を保存する'),
      ),
    );
  }

  Widget deleteButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: AppStyle.primaryButton.copyWith(
          backgroundColor:
              const WidgetStatePropertyAll(AppColor.secondaryColor),
          foregroundColor: const WidgetStatePropertyAll(AppColor.fontColor2),
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
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
                    '${widget.args.todo.name}\nを本当に削除しますか？',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: AppStyle.primaryButton.copyWith(
                        backgroundColor:
                            const WidgetStatePropertyAll(AppColor.emphasis),
                        textStyle:
                            WidgetStatePropertyAll(context.textTheme.bodyLarge),
                      ),
                      onPressed: () {
                        ref
                            .read(todoProvider.notifier)
                            .delete(widget.args.todo.id!);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        context.showSnackBar(
                          const SnackBar(
                            content: Text('削除しました'),
                          ),
                        );
                      },
                      child: const Text('削除する'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: AppStyle.primaryButton.copyWith(
                        backgroundColor: const WidgetStatePropertyAll(
                            AppColor.secondaryColor),
                        foregroundColor:
                            const WidgetStatePropertyAll(AppColor.fontColor2),
                        textStyle: WidgetStatePropertyAll(
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
