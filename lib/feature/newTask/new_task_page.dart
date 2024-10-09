import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/core/common/categoryDialog/category_dialog.dart';
import 'package:routine_app/core/common/spanDialog/span_dialog.dart';
import 'package:routine_app/core/common/timeDialog/time_dialog.dart';
import 'package:routine_app/core/design/app_color.dart';
import 'package:routine_app/core/design/app_style.dart';
import 'package:routine_app/core/design/app_text_field.dart';
import 'package:routine_app/core/navigation/router.dart';
import 'package:routine_app/core/services/ad_service.dart';
import 'package:routine_app/core/services/notification_service.dart';
import 'package:routine_app/core/utils/contextEx.dart';
import 'package:routine_app/core/utils/date.dart';
import 'package:routine_app/core/utils/int_ex.dart';
import 'package:routine_app/repository/todo/todo_provider.dart';

import 'new_task_page_state.dart';

class NewTaskPage extends ConsumerStatefulWidget {
  const NewTaskPage({super.key});

  @override
  ConsumerState<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends ConsumerState<NewTaskPage> {
  final TextEditingController _spanController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final provider = newTaskPageStateProvider;
  final dateFormat = DateFormat.yMd();
  late final AdService ad;
  late final List<String> titleList;
  late final titleNum = Random().nextInt(titleList.length);

  @override
  void initState() {
    super.initState();
    ad = AdService();
    ad.adLoad(onFinish: () {
      Navigator.popUntil(
        context,
        (route) => route.settings.name == AppRouter.home,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    titleList = [
      context.l10n.titleExample1,
      context.l10n.titleExample2,
      context.l10n.titleExample3,
      context.l10n.titleExample4,
      context.l10n.titleExample5,
      context.l10n.titleExample6,
      context.l10n.titleExample7,
      context.l10n.titleExample8,
      context.l10n.titleExample9,
      context.l10n.titleExample10,
      context.l10n.titleExample11,
      context.l10n.titleExample12,
      context.l10n.titleExample13,
      context.l10n.titleExample14,
      context.l10n.titleExample15,
      context.l10n.titleExample16,
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _spanController.dispose();
    _timeController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    // ref.invalidate(selectCategoryProvider);
  }

  @override
  Widget build(BuildContext context) {
    final NewTaskPageState state = ref.watch(provider);
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondaryColor,
        foregroundColor: AppColor.fontColor,
        title: Text(
          context.l10n.createNewYurudo,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          style: AppStyle.primaryButton.copyWith(
            backgroundColor: const WidgetStatePropertyAll(AppColor.primary),
          ),
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            if (state.name.isEmpty ||
                state.span == null ||
                state.firstDay == null) {
              ref.read(provider.notifier).setHasError(true, context.l10n.noRequired);
              return;
            }
            if (state.firstDay!.isBeforeDay(DateTime.now())) {
              ref
                  .read(provider.notifier)
                  .setHasError(true, context.l10n.cantSelectAfterToday);
              return;
            }
            if (state.remind) {
              ref.watch(notificationServiceProvider).requestPermissions();
            }
            await ref.read(todoProvider.notifier).create(
              name: state.name,
              span: state.span!,
              firstDay: state.firstDay!,
              remind: state.remind,
              categoryId: state.category?.id,
              time: state.time,
            );
            ad.showInterstitial();
            if (!mounted) return;
            Navigator.pop(context);
          },
          child: Text(
            context.l10n.create,
            style: context.textTheme.bodyLarge!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (state.hasError)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(
                        color: AppColor.emphasis,
                      ),
                    ),
                  ),
                AppTextField(
                  label: context.l10n.labelTitle,
                  placeholder: "${context.l10n.example}）${titleList[titleNum]}",
                  isRequired: true,
                  onChanged: (value) {
                    ref.read(provider.notifier).setName(value);
                  },
                  maxLines: null,
                ),
                const SizedBox(height: 38),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: deviceWidth / 2 - 20,
                      child: Column(
                        children: [
                          AppTextField(
                            label: context.l10n.span,
                            placeholder: context.l10n.select,
                            isRequired: true,
                            controller: _spanController,
                            readonly: true,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SpanDialog(
                                        onConfirm: (number, spanType) {
                                      int span = number * spanType.term;
                                      _spanController.text =
                                          span.toSpanString(context);
                                      ref.read(provider.notifier).setSpan(span);
                                    });
                                  });
                            },
                          ),
                          const SizedBox(height: 38),
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
                          const SizedBox(height: 38),
                          AppTextField(
                            label: context.l10n.requireTime,
                            placeholder: context.l10n.select,
                            controller: _timeController,
                            readonly: true,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDialog(
                                  context: context,
                                  builder: (context) => TimeDialog(
                                        onConfirm: (time) {
                                          _timeController.text = time.toTimeString(context);
                                  ref.read(provider.notifier).setTime(time);
                                },
                                      ));
                            },
                          ),
                          const SizedBox(height: 38),
                          AppTextField(
                            label: context.l10n.firstExpectedDate,
                            placeholder: context.l10n.select,
                            isRequired: true,
                            controller: _dateController,
                            readonly: true,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDatePicker(
                                context: context,
                                helpText: context.l10n.setExpectedDate,
                                initialDate: state.firstDay ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 366)),
                              ).then((date) {
                                if (date != null) {
                                  ref.read(provider.notifier).setDate(date);
                                  _dateController.text = dateFormat.format(date);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: deviceWidth / 2 - 20,
                        padding: const EdgeInsets.only(top: 25, left: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            ref
                                .read(provider.notifier)
                                .setRemind(!state.remind);
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
                                child: Text(
                                  context.l10n.remind,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
