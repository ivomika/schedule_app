import 'package:schedule_app/infrastructure/object/lesson.dart';

class SessionDay{
  String? date;
  List<Lesson>? lessons;

  SessionDay();

  SessionDay.fromJson(Map<String, dynamic> json){
    date = json['date'];
    lessons = json['lessons'] != null
      ? (json['lessons'] as List).map((e) => Lesson.fromJson(e)).toList()
      : [];
  }

  Map<String, dynamic> toJson(){
    return {
      'date': date,
      'lessons': lessons?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'SessionDay{date: $date, lessons: $lessons}';
  }
}