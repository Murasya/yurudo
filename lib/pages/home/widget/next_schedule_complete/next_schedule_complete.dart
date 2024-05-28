import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:routine_app/design/app_assets.dart';
import 'package:routine_app/design/app_style.dart';
import 'package:routine_app/pages/home/widget/next_schedule/next_schedule_state.dart';
import 'package:routine_app/pages/home/widget/next_schedule_next/next_schedule_next.dart';
import 'package:routine_app/utils/date.dart';

import '../../../../design/app_color.dart';
import 'next_schedule_complete_state.dart';

class NextScheduleComplete extends ConsumerStatefulWidget {
  final NextScheduleArgs args;

  const NextScheduleComplete({
    required this.args,
    super.key,
  });

  @override
  ConsumerState createState() => _NextScheduleCompleteState();
}

class _NextScheduleCompleteState extends ConsumerState<NextScheduleComplete> {
  static const double _width = 185;
  late final AutoDisposeStateNotifierProvider<NextScheduleCompleteStateNotifier,
      NextScheduleState> provider;

  @override
  void initState() {
    provider = nextScheduleCompleteStateProvider(widget.args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: IntrinsicWidth(
        child: Stack(
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
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'タスクの達成日を選択してください',
                  style: Theme.of(context).textTheme.bodyMedium,
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
                      if (ref
                          .read(provider)
                          .selectDay
                          .isAfterDay(DateTime.now())) {
                        ref
                            .read(provider.notifier)
                            .setError(true, msg: '明日以降は選択できません');
                        return;
                      }
                      if (widget.args.todo.completeDate.isNotEmpty) {
                        final lastCompleteDate =
                            widget.args.todo.completeDate.last;
                        final lastCompDateStr =
                            DateFormat("y/M/d").format(lastCompleteDate);
                        if (ref.read(provider).selectDay.isBeforeDay(
                            lastCompleteDate.add(const Duration(days: 1)))) {
                          ref.read(provider.notifier).setError(true,
                              msg: '前回の実施日以降しか選択できません（前回の実施日$lastCompDateStr）');
                          return;
                        }
                      }
                      ref.read(provider.notifier).setError(false);
                      showDialog(
                        context: context,
                        builder: (_) => NextScheduleNext(
                          args: NextScheduleArgs(
                            todo: widget.args.todo,
                            completeDay: ref.read(provider).selectDay,
                          ),
                        ),
                      );
                    },
                    child: const Text('次へ'),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: AppStyle.button.copyWith(
                      backgroundColor:
                          const WidgetStatePropertyAll(AppColor.secondaryColor),
                      foregroundColor:
                          const WidgetStatePropertyAll(AppColor.fontColor2),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('戻る'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
    Color backColor = state.selectDay.isSameDay(day) ? AppColor.primary : Colors.transparent;

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
