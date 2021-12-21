import 'package:timetable/models/abstract_thing.dart';
import 'package:timetable/models/daos/task_dao.dart';

class Course extends AbstractThing {
  /// Minutes since 00:00.
  int startTime;

  /// Unit: minutes.
  int duration;

  /// The weekday that this course occurs. Must be `"Monday"`, `"Tuesday"`, ...,
  /// `"Sunday"`.
  ///
  /// Note: capitalized weekdays.
  String date;

  /// Name of the lecturer.
  String lecturerName;

  /// Location where this course occurs. Can be arbitrary name or a URL.
  String room;

  /// User's note on this course.
  String note;

  /// HTML color code. Example: `#FF0000`.
  String color;

  /// ID of the parent timetable.
  int parentId;

  /// IDs of tasks that this course has.
  List<int> taskIds = [];

  /// Create a new `Course` object.
  Course(int id, String name,
      {this.date = 'Monday',
      this.startTime = 0,
      this.duration = 0,
      this.lecturerName,
      this.room,
      this.color,
      this.note,
      int timetableId})
      : super(id, name) {
    timetableId = timetableId;
    taskIds = [];
  }

  /// Load the `Course` object from the JSON object in the database (the JSON
  /// must be converted to `Map` beforehand).
  Course.fromMap(Map<String, dynamic> map) : super(map['id'], map['name']) {
    date = map['date'];
    startTime = map['startTime'];
    duration = map['duration'];
    parentId = map['timetableId'];
    taskIds = map['taskIds'];
  }

  /// Return a list of associated assignment IDs.
  List<int> get assignmentIds {
    var result = <int>[];
    for (final id in taskIds) {
      if (TaskDao.getInstance().getById(id).type == 'assignment') {
        result.add(id);
      }
    }
    return result;
  }

  /// Return a list of associated exam IDs.
  List<int> get examIds {
    var result = <int>[];
    for (final id in taskIds) {
      if (TaskDao.getInstance().getById(id).type == 'exam') {
        result.add(id);
      }
    }
    return result;
  }

  @override
  String toString() =>
      'Course(id: $id, name: $name, date: $date, range: ${formatTime(startTime)} -> ${formatTime(startTime + duration)})';

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'date': date,
        'startTime': startTime,
        'duration': duration,
        'lecturerName': lecturerName,
        'room': room,
        'color': color,
        'note': note,
        'timetableId': parentId,
        'taskIds': taskIds
      };
}
