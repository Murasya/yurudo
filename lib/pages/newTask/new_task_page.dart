import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/design/app_text_field.dart';
import 'package:routine_app/model/category.dart';
import 'package:routine_app/pages/newTask/new_task_page_state.dart';
import 'package:routine_app/pages/widget/date_dialog.dart';
import 'package:routine_app/pages/widget/span_dialog.dart';
import 'package:routine_app/pages/widget/time_dialog.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/services/notification_service.dart';
import 'package:routine_app/viewModel/todo_provider.dart';

import '../widget/categoryDialog/category_dialog.dart';

class NewTaskPage extends ConsumerStatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends ConsumerState<NewTaskPage> {
  Category? selectCategory;
  final TextEditingController _spanController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  NotificationService ns = NotificationService();
  final provider = newTaskPageStateProvider;
  final dateFormat = DateFormat('y年M月d日');
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    ns.initializeNotification();
    adLoad();
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
        title: const Text(
          '新しいゆるDOを作成',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextField(
              label: 'タイトル',
              placeholder: '入力してください',
              isRequired: true,
              onChanged: (value) {
                final todo = state.todo.copyWith(name: value);
                ref.read(provider.notifier).updateTodo(todo);
              },
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
                        label: 'スパン',
                        placeholder: '選択してください',
                        isRequired: true,
                        controller: _spanController,
                        readonly: true,
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
                      const SizedBox(height: 38),
                      AppTextField(
                        label: '分類',
                        placeholder: '選択してください',
                        controller: _categoryController,
                        readonly: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => CategoryDialog(
                                defaultValue: selectCategory,
                                onConfirm: (value) {
                                  selectCategory = value;
                                  _categoryController.text = value.name;
                                  final todo = state.todo.copyWith(
                                    categoryId: [selectCategory!.categoryId],
                                  );
                                  ref.read(provider.notifier).updateTodo(todo);
                                }),
                          );
                        },
                      ),
                      const SizedBox(height: 38),
                      AppTextField(
                        label: '必要時間',
                        placeholder: '選択してください',
                        controller: _timeController,
                        readonly: true,
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
                              _timeController.text = '${ans[0]}${ans[1]}';
                              final todo = state.todo.copyWith(time: time);
                              ref.read(provider.notifier).updateTodo(todo);
                            },
                          ).showDialog(context);
                        },
                      ),
                      const SizedBox(height: 38),
                      AppTextField(
                        label: '最初の実施予定日',
                        placeholder: '選択してください',
                        isRequired: true,
                        controller: _dateController,
                        readonly: true,
                        onTap: () {
                          DateDialog(
                            onConfirm: (picker, value) {
                              DateTime date =
                                  DateTime.parse(picker.adapter.toString());
                              final todo = state.todo.copyWith(date: date);
                              ref.read(provider.notifier).updateTodo(todo);
                              _dateController.text = dateFormat.format(date);
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
                    value: state.todo.remind,
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
                      final todo = state.todo.copyWith(remind: value);
                      ref.read(provider.notifier).updateTodo(todo);
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 40),
                  backgroundColor: AppColor.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (state.todo.name.isEmpty ||
                      state.todo.span == 0 ||
                      state.todo.date == null) {
                    return;
                  }
                  ref.read(todoProvider.notifier).add(state.todo);
                  if (state.todo.remind) {
                    ns.requestPermissions();
                    // ns.registerMessage(
                    //     day: state.todo.date,
                    //     message: '${state.todo.name}をやりましょう！');
                  }
                  _interstitialAd?.show();
                  Navigator.popUntil(
                    context,
                    (route) => route.settings.name == AppRouter.home,
                  );
                },
                child: const Text(
                  '作成',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void adLoad() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) =>
                debugPrint('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              debugPrint('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              Navigator.popUntil(
                context,
                (route) => route.settings.name == AppRouter.home,
              );
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (InterstitialAd ad) =>
                debugPrint('$ad impression occurred.'),
          );
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }
}
