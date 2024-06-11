import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/infrastructure/object/month.dart';
import 'package:schedule_app/infrastructure/object/lesson.dart';
import 'package:schedule_app/infrastructure/object/lesson_time.dart';
import 'package:schedule_app/infrastructure/object/lesson_type.dart';
import 'package:schedule_app/ui/base/text/body.dart';
import 'package:schedule_app/ui/base/text/caption.dart';

enum LessonCardType{
  top(BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
  center(BorderRadius.zero),
  bottom(BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
  one(BorderRadius.all(Radius.circular(8)));

  const LessonCardType(this.borderRadius);

  final BorderRadius borderRadius;
}

class LessonCard extends StatelessWidget {
  final Lesson part;
  final String date;
  final bool isPreviousDay;
  final LessonCardType type;

  const LessonCard({
    super.key,
    required this.part,
    required this.date,
    required this.isPreviousDay,
    required this.type,
  });

  String get caption => _caption();
  String get body => _body();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.maxFinite,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: type.borderRadius,
        color: isPreviousDay
          ? Theme.of(context).colorScheme.surface.lighten(15)
          : Theme.of(context).colorScheme.surface.lighten(4)
      ),

      child: Row(
        children: [
          Container(
            width: 20,
            height: double.maxFinite,
            color: LessonType.byKey(part.type).color(context),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 8,
                top: 8,
                bottom: 8
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BodyText(
                    part.subject!,
                    decoration: isPreviousDay
                      ? TextDecoration.lineThrough
                      : null,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(body),
                      CaptionText(
                          caption,
                          color: Theme.of(context).hintColor,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String _caption() => '${_parseDate(date)} ${_parseTime(part.time)}';
  String _body(){
    var type = LessonType.byKey(part.type).name;
    var instructor = part.instructor ?? '';
    var room = part.room ?? '';

    return '$type - $instructor $room';
  }


  String _parseDate(String date){
    var dateTime = DateTime.parse(date);

    return '${Month.byMonthNumber(dateTime.month)} ${dateTime.day}';
  }

  String _parseTime(String? time){
    if(time == null) return '';

    return LessonTime.parseFromSchedule(time);
  }
}
