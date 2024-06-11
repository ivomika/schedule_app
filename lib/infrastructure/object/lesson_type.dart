import 'package:flutter/material.dart';

class LessonType{
  final String name;
  final Color Function(BuildContext context) color;

  LessonType({
    required this.name,
    required this.color
  });

  // static final Map<String, LessonType> _types = {
  //   'lecture': LessonType(name: 'Лекция', color: ColorInterface.primaryAccent),
  //   'practice': LessonType(name: 'Практика', color: ColorInterface.primary),
  //   'laboratory': LessonType(name: 'Лабораторная', color: ColorInterface.primary),
  //   'exam': LessonType(name: 'Экзамен', color: ColorInterface.warning),
  //   'test': LessonType(name: 'Зачет', color: ColorInterface.success),
  //   'weekend': LessonType(name: '', color: ColorInterface.error),
  // };

  static final Map<String, LessonType> _types = {
    'lecture': LessonType(name: 'Лекция', color: (context) => Theme.of(context).colorScheme.primaryContainer),
    'practice': LessonType(name: 'Практика', color: (context) => Theme.of(context).colorScheme.primary),
    'laboratory': LessonType(name: 'Лабораторная', color: (context) => Theme.of(context).colorScheme.primary),
    'exam': LessonType(name: 'Экзамен', color: (context) => Theme.of(context).colorScheme.error),
    'test': LessonType(name: 'Зачет', color: (context) => Theme.of(context).colorScheme.error),
    'weekend': LessonType(name: '', color: (context) => Theme.of(context).colorScheme.tertiaryContainer),
  };

  static LessonType byKey(String? key){
    if(_types.containsKey(key)){
      return _types[key]!;

    }

    return LessonType(
        name: key ?? 'Не известно',
        color: (context) => Theme.of(context).colorScheme.error
    );
  }
}

// lecture,
// practice,
// exam,
// test,
// weekend,