import 'package:timetable/models/course.dart';
import 'package:timetable/models/daos/dao.dart';
import 'package:timetable/models/daos/course_dao.dart';
import 'package:timetable/models/timetable.dart';

class TimetableDao extends Dao<Timetable> {
  static final TimetableDao _instance = TimetableDao._internal();
  static TimetableDao getInstance() => _instance;
  TimetableDao._internal();

  /// Retrieve a Timetable object by `id`.
  @override
  Timetable getById(int id) {
    for (int i = 0; i < pool.length; ++i) {
      if (pool[i].id == id) {
        return pool[i];
      }
    }
    return null;
  }

  @override
  List<Timetable> getAll() => pool;

  /// Create a new timetable with default value
  @override
  Timetable create() {
    ++Dao.idCounter;
    var t = Timetable(Dao.idCounter - 1, "New timetable");
    pool.add(t);
    return t;
  }

  /// Delete a `Timetable`. Note that deleting a timetable will also delete all
  /// courses in this timetable, and all tasks that these courses have.
  @override
  void delete(int id) {
    var courseDao = CourseDao.getInstance();

    for (int i = 0; i < pool.length; ++i) {
      if (pool[i].id == id) {
        for (final courseId in pool[i].courseIds) {
          courseDao.delete(courseId);
        }
        pool.removeAt(i);
      }
    }
  }
}
