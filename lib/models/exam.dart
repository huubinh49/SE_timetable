import 'package:timetable/models/task.dart';

class Exam extends Task {
  String room;

  Exam(String id, String name, DateTime startDate, DateTime endDate,
      {DateTime notificationTime,
      String topic,
      int importantLevel,
      bool state,
      String note,
      this.room})
      : super(id, name, startDate, endDate,
            notificationTime: notificationTime,
            topic: topic,
            importantLevel: importantLevel,
            state: state,
            note: note);

  @override
  String get type => 'exam';

  @override
  String toString() => 'Exam(id: $id, name: $name)';

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map.addAll({'type': 'exam', 'room': room});
    return map;
  }
}
