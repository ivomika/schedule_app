class Lesson{
  String? time;
  String? type;
  String? subject;
  String? instructor;
  String? room;

  Lesson();

  Lesson.of(
    this.time,
    this.type,
    this.subject,
    this.instructor,
    this.room,
  );

  Lesson.fromJson(Map<String, dynamic> json){
    time = json['time'];
    type = json['type'];
    subject = json['subject'];
    instructor = json['instructor'];
    room = json['room'];
  }

  Map<String, dynamic> toJson(){
    return {
      'time': time,
      'type': type,
      'subject': subject,
      'instructor': instructor,
      'room': room,
    };
  }

  @override
  String toString() {
    return 'Lesson{time: $time, type: $type, subject: $subject, instructor: $instructor, room: $room}';
  }
}



