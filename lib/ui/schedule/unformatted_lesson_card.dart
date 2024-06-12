import 'package:schedule_app/ui/schedule/lesson_card.dart';

class UnformattedLessonCard extends LessonCard{
  const UnformattedLessonCard({
    super.key,
    required super.part,
    required super.date,
    required super.type,
  });

  @override
  String get body => '${part.type} - ${part.instructor} ${part.room}';

  @override
  String get caption => '$date ${part.time}';
}