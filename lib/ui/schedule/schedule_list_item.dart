import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/infrastructure/object/lesson.dart';
import 'package:schedule_app/infrastructure/object/session_day.dart';
import 'package:schedule_app/infrastructure/state/settings_state.dart';
import 'package:schedule_app/ui/schedule/lesson_card.dart';
import 'package:schedule_app/ui/schedule/unformatted_lesson_card.dart';

class ScheduleListItem extends StatelessWidget {
  final SessionDay sessionDay;

  const ScheduleListItem({
    super.key,
    required this.sessionDay
  });

  bool get isPreviousDay => _isPreviousDay();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 3)
            )
          ]
      ),
      child: Consumer<SettingsState>(
        builder: (context, state, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                sessionDay.lessons!.length,
                    (index) {
                        if(sessionDay.lessons!.length == 1){
                          if(state.useFormatting){
                            return LessonCard(
                                part: sessionDay.lessons!.elementAt(index),
                                date: sessionDay.date!,
                                isPreviousDay: isPreviousDay,
                                type: LessonCardType.one,
                            );
                          }

                          return UnformattedLessonCard(
                            part: sessionDay.lessons!.elementAt(index),
                            date: sessionDay.date!,
                            isPreviousDay: isPreviousDay,
                            type: LessonCardType.one,
                          );
                        }

                        if(index == 0){
                          if(state.useFormatting){
                            return LessonCard(
                              part: sessionDay.lessons!.elementAt(index),
                              date: sessionDay.date!,
                              isPreviousDay: isPreviousDay,
                              type: LessonCardType.top,
                            );
                          }

                          return UnformattedLessonCard(
                            part: sessionDay.lessons!.elementAt(index),
                            date: sessionDay.date!,
                            isPreviousDay: isPreviousDay,
                            type: LessonCardType.top,
                          );
                        }

                        if(index == sessionDay.lessons!.length - 1) {
                          if(state.useFormatting){
                            return LessonCard(
                              part: sessionDay.lessons!.elementAt(index),
                              date: sessionDay.date!,
                              isPreviousDay: isPreviousDay,
                              type: LessonCardType.bottom,
                            );
                          }

                          return UnformattedLessonCard(
                            part: sessionDay.lessons!.elementAt(index),
                            date: sessionDay.date!,
                            isPreviousDay: isPreviousDay,
                            type: LessonCardType.bottom,
                          );
                        }

                        if(state.useFormatting){
                          return LessonCard(
                            part: sessionDay.lessons!.elementAt(index),
                            date: sessionDay.date!,
                            isPreviousDay: isPreviousDay,
                            type: LessonCardType.center,
                          );
                        }

                        return UnformattedLessonCard(
                          part: sessionDay.lessons!.elementAt(index),
                          date: sessionDay.date!,
                          isPreviousDay: isPreviousDay,
                          type: LessonCardType.center,
                        );
                    }
            ),
          );
        }
      ),
    );
  }

  bool _isPreviousDay(){
    var currentDate = DateTime.now();
    var date = DateTime.parse(sessionDay.date!);

    return currentDate.difference(date).inDays > 0;
  }
}
