import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/design/app_assets.dart';
import 'package:routine_app/design/app_style.dart';
import 'package:routine_app/pages/home/widget/next_schedule/next_schedule_state.dart';
import 'package:routine_app/pages/home/widget/next_schedule_close.dart';
import 'package:routine_app/pages/home/widget/next_schedule_complete/next_schedule_complete.dart';
import 'package:routine_app/utils/contextEx.dart';
import 'package:routine_app/utils/date.dart';

import '../../../../design/app_color.dart';
import '../../../../viewModel/todo_provider.dart';

class NextSchedule extends ConsumerStatefulWidget {
  final NextScheduleArgs args;

  const NextSchedule({
    required this.args,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _NextScheduleState();
}

class _NextScheduleState extends ConsumerState<NextSchedule> {
  static const double _width = 185;
  late final AutoDisposeStateNotifierProvider<NextScheduleStateNotifier,
      NextScheduleState> provider;

  @override
  void initState() {
    provider = nextScheduleStateProvider(widget.args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          surfaceTintColor: Colors.transparent,
          content: Stack(
            alignment: Alignment.topCenter,
            children: [
              Transform.translate(
                offset: const Offset(0, -70),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned(
                      bottom: 10,
                      child: CustomPaint(
                        painter: HalfCircle(width: _width),
                      ),
                    ),
                    SvgPicture.asset(
                      AppAssets.uncheck,
                      width: 90,
                    ),
                    const Text(
                      'Congratulations!',
                      style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.translate(
                        offset: const Offset(10, 0),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () async {
                            bool? finish = await showDialog(
                              context: context,
                              builder: (_) => const NextScheduleClose(),
                            );
                            if (finish != null && finish) {
                              ref.read(todoProvider.notifier).complete(
                                    todo: widget.args.todo,
                                    completeDay: widget.args.completeDay,
                                    nextDay: null,
                                  );
                              if (!mounted) return;
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'ゆるDOを1つ達成しました！',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColor.emphasisColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '次の実施予定日を設定してください',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => NextScheduleComplete(
                          args: widget.args,
                        ),
                      );
                    },
                    child: Text(
                      '達成日を今日以外に変更する',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColor.fontColor3,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  calendar(),
                  if (ref.watch(provider).hasError)
                    Text(
                      ref.watch(provider).errorMessage,
                      style: const TextStyle(
                        color: AppColor.emphasisColor,
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: AppStyle.button,
                      onPressed: () {
                        if (!ref
                            .read(provider)
                            .selectDay
                            .isAfterDay(widget.args.completeDay)) {
                          ref
                              .read(provider.notifier)
                              .setError(true, msg: '達成日以降の日付しか選べません');
                          return;
                        }
                        ref.read(todoProvider.notifier).complete(
                              todo: widget.args.todo,
                              completeDay: widget.args.completeDay,
                              nextDay: ref.read(provider).selectDay,
                            );
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColor.emphasisColor,
              textStyle: context.textTheme.bodyMedium!.copyWith(
                fontSize: 13,
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('チェックを元に戻す'),
          ),
        ),
      ],
    );
  }

  Widget calendar() {
    const list = ['月', '火', '水', '木', '金', '土', '日'];
    final state = ref.watch(provider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () =>
                  ref.read(provider.notifier).changeMonth(isBefore: true),
            ),
            Text(
              DateFormat('y年M月').format(state.displayMonth),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => ref.read(provider.notifier).changeMonth(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (String day in list)
              Text(
                day,
                style: const TextStyle(
                  color: AppColor.disableColor,
                  fontSize: 15,
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            for (int week = 0; week < state.displayMonth.weekInMonth; week++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int day = 1; day <= 7; day++) _dayWidget(week, day),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget _dayWidget(int week, int weekDay) {
    final state = ref.watch(provider);
    int intDay =
        (week * 7 + weekDay - state.displayMonth.firstDayOfMonth.weekday + 1);
    if (intDay <= 0 || intDay > state.displayMonth.lastDayOfMonth) {
      return Container(
        width: 20,
      );
    }
    DateTime day =
        DateTime(state.displayMonth.year, state.displayMonth.month, intDay);
    Color backColor = state.selectDay.isSameDay(day)
        ? AppColor.primary
        : widget.args.completeDay.isSameDay(day)
            ? AppColor.secondaryColor
            : Colors.transparent;

    return GestureDetector(
      onTap: () {
        ref.read(provider.notifier).changeDate(day);
      },
      child: Container(
        width: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backColor,
        ),
        child: Text(
          intDay.toString(),
          textAlign: TextAlign.center,
          style: GoogleFonts.harmattan(
            color: (state.selectDay.isSameDay(day))
                ? Colors.white
                : AppColor.fontColor,
            fontSize: 21,
          ),
        ),
      ),
    );
  }
}

class HalfCircle extends CustomPainter {
  final double width;

  const HalfCircle({required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final Rect rect = Offset(width / -2, width / -2) & Size(width, width);
    canvas.drawArc(rect, pi, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
