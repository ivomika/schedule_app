class LessonTime{
  static final Map<int, Time> _time = {
    1: Time('8:30', '9:15'),
    2: Time('9:20', '10:00'),
    3: Time('10:10', '10:55'),
    4: Time('11:00', '11:40'),
    5: Time('11:50', '12:35'),
    6: Time('12:40', '13:20'),
    7: Time('13:40', '14:25'),
    8: Time('14:30', '15:10'),
    9: Time('15:20', '16:05'),
    10: Time('16:10', '16:50'),
    11: Time('17:00', '17:45'),
    12: Time('17:50', '18:30'),
    13: Time('18:35', '20:00'),
    14: Time('18:35', '20:00'),
    15: Time('20:05', '21:30'),
    16: Time('20:05', '21:30'),
  };

  static Time byNumber(int number){
    if(number < 1 || number > 16){
      throw ArgumentError('number out of range');
    }

    return _time[number]!;
  }

  static String parseFromSchedule(String time){
    var split = time.split('-').map((e) => int.parse(e));

    return '${byNumber(split.elementAt(0)).startTime} - ${byNumber(split.elementAt(1)).endTime}';

  }
}

class Time{
  final String startTime;
  final String endTime;

  Time(this.startTime, this.endTime);
}