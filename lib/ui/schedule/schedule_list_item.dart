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


  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 8,
                spreadRadius: -5,
                offset: const Offset(0, 3)
            )
          ]
      ),
      child: Consumer<SettingsState>(
        builder: (context, state, child) {
          var lessonList = _generateLessonCard(state);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: lessonList
          );
        }
      ),
    );
  }

  List<Widget> _generateLessonCard(SettingsState state){
    if(sessionDay.lessons!.length == 1) return [_lessonCardByType(sessionDay.lessons!.first, state)];

    var lessonCards = <Widget>[];

    lessonCards.add(_lessonCardByType(sessionDay.lessons!.first, state, LessonCardType.top));

    for(int i = 1; i < sessionDay.lessons!.length - 1; i++){
      lessonCards.add(_lessonCardByType(sessionDay.lessons!.elementAt(i), state, LessonCardType.center));
    }

    lessonCards.add(_lessonCardByType(sessionDay.lessons!.last, state, LessonCardType.bottom));

    return lessonCards;
  }

  Widget _lessonCardByType(Lesson lesson, SettingsState state, [LessonCardType type = LessonCardType.one]){
    if(state.useFormatting){
      return LessonCard(
        part: lesson,
        date: sessionDay.date!,
        type: type,
      );
    }

    return UnformattedLessonCard(
      part: lesson,
      date: sessionDay.date!,
      type: type,
    );
  }
}
