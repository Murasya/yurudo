import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/core/common/categoryDialog/category_dialog.dart';
import 'package:routine_app/core/common/dateDialog/date_dialog.dart';
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
  final dateFormat = DateFormat('y年M月d日');
  late final AdService ad;

  static const List<String> titleList = [
    "お風呂で明日やることを考える(1日に1回)",
    "【腹筋重視】筋トレをする(2日に1回)",
    "【必ず】彼氏の誕生日のプランを少し考える(3日に1回)",
    "最低でも20ページ分は〇〇の本を読む(3日に1回)",
    "お風呂掃除をする(5日に1回)",
    "金魚鉢の水換えをする(1週に1回)",
    "【掃除機はマスト】部屋の掃除をする(2週に1回)",
    "コンタクトレンズの交換(2週に1回)",
    "行って見たいお店をインスタで探す(3週に1回)",
    "家族と電話する(1か月に1回)",
    "洗剤の残量確認(1か月に1回)",
    "将来のためにやること検討(1か月に1回)",
    "【国内】行って見たい旅行先を考える(2か月に1回)",
    "温泉に行きたいかどうかを考えてみる(3か月に1回)",
    "サブスクを本当に必要かどうか見直す(4か月に1回)",
    "クローゼットの防虫剤を交換する(6か月に1回)",
  ];
  final titleNum = Random().nextInt(titleList.length);

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
                                          span.toSpanString();
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
                                          _timeController.text = time.toTimeString();
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
                              showDialog(
                                context: context,
                                builder: (context) => DateDialog(
                                  onConfirm: (DateTime date) {
                                    ref.read(provider.notifier).setDate(date);
                                    _dateController.text =
                                        dateFormat.format(date);
                                    Navigator.pop(context);
                                  },
                                  onCancel: () => Navigator.pop(context),
                                ),
                              );
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
