
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/infrastructure/object/session_day.dart';
import 'package:schedule_app/infrastructure/state/schedule_state.dart';
import 'package:schedule_app/ui/base/text/body.dart';
import 'package:schedule_app/ui/schedule/schedule_list_item.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Body();
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleState>(
      builder: (BuildContext context, ScheduleState state, Widget? child) {
        if (state.schedule.isEmpty) {
          return const Center(
            child: BodyText('Добавьте новое расписание'),
          );
        }

        var currentSchedule = state.schedule.where((e) => _isPreviousDay(e) == false);

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: currentSchedule.length,
          separatorBuilder: (_, __) => const SizedBox(
            height: 8,
          ),
          itemBuilder: (context, index) =>
              ScheduleListItem(
                sessionDay: currentSchedule.elementAt(index),
              ),
        );
      },
    );
  }

  bool _isPreviousDay(SessionDay sessionDay){
    var currentDate = DateTime.now();
    var date = DateTime.parse(sessionDay.date!);

    return currentDate.difference(date).inDays > 0;
  }
}