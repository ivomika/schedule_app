import 'package:flutter/material.dart';
import 'package:schedule_app/ui/base/color/color_interface.dart';

class LessonType{
  final String name;
  final Color color;

  LessonType({
    required this.name,
    required this.color
  });

  static final Map<String, LessonType> _types = {
    'lecture': LessonType(name: 'Лекция', color: ColorInterface.primaryAccent),
    'practice': LessonType(name: 'Практика', color: ColorInterface.primary),
    'laboratory': LessonType(name: 'Лабораторная', color: ColorInterface.primary),
    'exam': LessonType(name: 'Экзамен', color: ColorInterface.warning),
    'test': LessonType(name: 'Зачет', color: ColorInterface.success),
    'weekend': LessonType(name: '', color: ColorInterface.error),
  };

  static LessonType byKey(String? key){
    if(_types.containsKey(key)){
      return _types[key]!;

    }

    return LessonType(
        name: key ?? 'Не известно',
        color: ColorInterface.error
    );
  }
}

// lecture,
// practice,
// exam,
// test,
// weekend,