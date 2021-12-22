import 'package:timetable/models/abstract_thing.dart';

class Timetable extends AbstractThing {
  /// The starting date of the timetable (the time part is not used).
  DateTime startDate = DateTime.now();

  /// The date on which the timetable ends (should be >= `startDate`).
  DateTime endDate = DateTime.now();

  /// IDs of courses associated to this timetable.
  List<String> courseIds = [];

  /// Create a new `Timetable` object
  ///
  /// `startDate` and `endDate` are default to `DateTime.now()` if not supplied
  Timetable(String id, String name, {DateTime startDate, DateTime endDate})
      : assert(startDate.compareTo(endDate) < 0),
        super(id, name) {
    if (startDate != null) {
      this.startDate = startDate;
    }
    if (endDate != null) {
      this.endDate = endDate;
    }
  }

  /// Load the `Timetable` object from the JSON object in the database (the JSON
  /// must be converted to `Map` beforehand).
  @override
  Timetable.fromMap(Map<String, dynamic> map) : super(map['id'], map['name']) {
    name = map['name'];
    startDate = DateTime.parse(map['startDate']);
    endDate = DateTime.parse(map['endDate']);
    courseIds = List<String>.from(map['courseIds']);
  }

  @override
  String toString() =>
      'Timetable(id: $id, name: $name, range: ${formatDate(startDate)} -> ${formatDate(endDate)})';

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startDate': formatDate(startDate),
      'endDate': formatDate(endDate),
      'courseIds': List.from(courseIds)
    };
  }
}
