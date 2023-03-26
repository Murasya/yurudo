import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/design/app_assets.dart';
import 'package:routine_app/design/app_color.dart';
import 'package:routine_app/pages/home/home_page_state.dart';
import 'package:routine_app/pages/home/widget/page_widget.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/services/notification_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final dateFormat = DateFormat('M/d');
  final provider = homePageStateProvider;

  @override
  void initState() {
    initializeDateFormatting('ja');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    NotificationService().setNotifications(state.todoList);
    ref.watch(provider.notifier).updateToday();

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.displayTerm == TermType.day)
                    Text(
                      dateFormat.format(
                          state.pageDate.subtract(const Duration(days: 1))),
                      style: GoogleFonts.harmattan(
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  if (state.displayTerm != TermType.day)
                    Text(
                      '前の${state.displayTerm.displayName}',
                      style: const TextStyle(
                        color: AppColor.fontColor,
                        fontSize: 14,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 24),
                    child: SvgPicture.asset(
                      AppAssets.triangle,
                      width: 14,
                    ),
                  ),
                  Container(
                    width: 144,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (state.displayTerm == TermType.day) ...[
                          Text(
                            dateFormat.format(state.pageDate),
                            style: GoogleFonts.harmattan(
                              color: AppColor.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          Text(
                            '(${DateFormat.E('ja').format(state.pageDate)})',
                            style: const TextStyle(
                              color: AppColor.backgroundColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                        if (state.displayTerm == TermType.week) ...[
                          Text(
                            '${DateFormat('M/d').format(state.pageDate)}~${state.pageDate.add(const Duration(days: 7)).day}',
                            style: GoogleFonts.harmattan(
                              color: AppColor.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ],
                        // if (state.displayTerm == TermType.month) ...[
                        //   Text(
                        //     DateFormat('y/M').format(state.pageDate),
                        //     style: GoogleFonts.harmattan(
                        //       color: AppColor.backgroundColor,
                        //       fontSize: 24,
                        //     ),
                        //   ),
                        // ],
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 16),
                    child: Transform.rotate(
                      angle: pi,
                      child: SvgPicture.asset(
                        AppAssets.triangle,
                        width: 14,
                      ),
                    ),
                  ),
                  if (state.displayTerm == TermType.day)
                    Text(
                      dateFormat
                          .format(state.pageDate.add(const Duration(days: 1))),
                      style: GoogleFonts.harmattan(
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  if (state.displayTerm != TermType.day)
                    Text(
                      '次の${state.displayTerm.displayName}',
                      style: const TextStyle(
                        color: AppColor.fontColor,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              const Divider(
                height: 0.4,
                color: AppColor.lineColor,
              ),
            ],
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            displayChangeButton(
              term: TermType.day,
              isActive: state.displayTerm == TermType.day,
            ),
            const SizedBox(width: 12),
            displayChangeButton(
              term: TermType.week,
              isActive: state.displayTerm == TermType.week,
            ),
            // const SizedBox(width: 12),
            // displayChangeButton(
            //   term: TermType.month,
            //   isActive: state.displayTerm == TermType.month,
            // ),
          ],
        ),
        iconTheme: const IconThemeData(color: AppColor.fontColor),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 50),
              child: Column(
                children: [
                  drawerItem(text: '利用規約', hasIcon: true),
                  drawerItem(text: 'プライバシーポリシー', hasIcon: true),
                  drawerItem(
                    text: 'フィードバック / お問い合わせ',
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.feedback),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.newTask);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.plus,
              ),
              const SizedBox(width: 16),
              const Text(
                '新しいゆるDOを作成',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      body: PageView.builder(
        controller: PageController(initialPage: 100),
        onPageChanged: (index) {
          ref.read(provider.notifier).changeDay(index - 100);
        },
        itemBuilder: (context, index) {
          return PageWidget(index: index - 100);
        },
      ),
    );
  }

  Widget drawerItem({
    required String text,
    bool hasIcon = false,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(text),
              const SizedBox(width: 4),
              if (hasIcon) const Icon(Icons.open_in_new),
            ],
          ),
        ),
        const SizedBox(height: 35),
      ],
    );
  }

  Widget displayChangeButton({
    required TermType term,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(provider.notifier).changeTerm(term);
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColor.primaryColor : AppColor.secondaryColor,
        ),
        child: Center(
          child: Text(
            term.displayName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color:
                  isActive ? AppColor.backgroundColor : AppColor.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
