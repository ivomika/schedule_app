class Month{
  String get january => byMonthNumber(1);
  String get february => byMonthNumber(2);
  String get march => byMonthNumber(3);
  String get april => byMonthNumber(4);
  String get may => byMonthNumber(5);
  String get june => byMonthNumber(6);
  String get july => byMonthNumber(7);
  String get august => byMonthNumber(8);
  String get september => byMonthNumber(9);
  String get october => byMonthNumber(10);
  String get november => byMonthNumber(11);
  String get december => byMonthNumber(12);

  static final Map<int, String> _month = {
    1: 'Январь',
    2: 'Февраль',
    3: 'Март',
    4: 'Апрель',
    5: 'Май',
    6: 'Июнь',
    7: 'Июль',
    8: 'Август',
    9: 'Сентябрь',
    10: 'Октябрь',
    11: 'Ноябрь',
    12: 'Декабрь',
  };

  static String byMonthNumber(int number){
    if(number < 1 || number > 12){
      throw ArgumentError('number out of range');
    }

    return _month[number]!;
  }
}