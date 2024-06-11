import 'package:flutter/material.dart';

class LessonType{
  final String name;
  final Color Function(BuildContext context) color;

  LessonType({
    required this.name,
    required this.color
  });

  static final Map<String, LessonType> _types = {
    'lecture': LessonType(name: 'Лекция', color: (context) => Theme.of(context).colorScheme.primaryContainer),
    'practice': LessonType(name: 'Практика', color: (context) => Theme.of(context).colorScheme.primary),
    'laboratory': LessonType(name: 'Лабораторная', color: (context) => Theme.of(context).colorScheme.primary),
    'exam': LessonType(name: 'Экзамен', color: (context) => Theme.of(context).colorScheme.error),
    'test': LessonType(name: 'Зачет', color: (context) => Theme.of(context).colorScheme.errorContainer),
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