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
import 'package:routine_app/pages/home/widget/my_drawer.dart';
import 'package:routine_app/pages/home/widget/page_widget.dart';
import 'package:routine_app/router.dart';
import 'package:routine_app/services/notification_service.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/utils/date.dart';

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
  final _pageController = PageController(initialPage: 100);

  @override
  void initState() {
    initializeDateFormatting('ja');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    NotificationService().setNotifications(state.todoList);
    if (!state.today.isSameDay(DateTime.now())) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouter.home,
        (_) => false,
      );
    }

    final DateTime weekEnd = state.pageDate.add(const Duration(days: 6));
    String month =
        (state.pageDate.month != weekEnd.month) ? '${weekEnd.month}/' : '';

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease),
                    child: Row(
                      children: [
                        if (state.displayTerm == TermType.day)
                          Text(
                            dateFormat.format(state.pageDate
                                .subtract(const Duration(days: 1))),
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
                      ],
                    ),
                  ),
                  Container(
                    width: 144,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.primaryColor,
                    ),
                    child: Transform.translate(
                      offset: const Offset(0, -2),
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
                              '${DateFormat('M/d').format(state.pageDate)}~$month${weekEnd.day}',
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
                  ),
                  GestureDetector(
                    onTap: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease),
                    child: Row(
                      children: [
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
                            dateFormat.format(
                                state.pageDate.add(const Duration(days: 1))),
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
      drawer: const MyDrawer(),
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
              Text(
                '新しいゆるDOを作成',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              ref.read(provider.notifier).changeDay(index - 100);
            },
            itemBuilder: (context, index) {
              return PageWidget(index: index - 100);
            },
          ),
          IgnorePointer(
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
