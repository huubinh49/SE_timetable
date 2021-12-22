import 'package:timetable/models/abstract_thing.dart';

abstract class Task extends AbstractThing {
  /// Starting date of the task.
  DateTime startDate = DateTime.now();

  /// Due date.
  DateTime endDate = DateTime.now();

  /// Reminder time.
  DateTime notificationTime;

  /// (unused for now, maybe duplicated with attribute `name`)
  String topic;

  /// Priority of this task.
  int importantLevel;

  /// Whether the task is marked as done.
  bool state;

  /// User's note on this task.
  String note;

  /// ID of the parent course.
  int parentId;

  Task(String id, String name, DateTime startDate, DateTime endDate,
      {this.notificationTime,
      this.topic,
      this.importantLevel = 1,
      this.state = false,
      this.note})
      : assert(startDate.compareTo(endDate) <= 0),
        super(id, name) {
    if (startDate != null) {
      this.startDate = startDate;
    }
    if (endDate != null) {
      this.endDate = endDate;
    }
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'startDate': formatDate(startDate),
        'endDate': formatDate(endDate),
        'notificationTime': notificationTime,
        'topic': topic,
        'note': note,
        'importantLevel': importantLevel,
        'state': state,
      };

  String get type;

  void removeNotificationTime() => notificationTime = null;
}
