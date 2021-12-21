import 'package:timetable/models/daos/dao.dart';
import 'package:timetable/models/daos/task_dao.dart';
import 'package:timetable/models/daos/timetable_dao.dart';

import 'package:timetable/models/course.dart';

class CourseDao extends Dao<Course> {
  static final CourseDao _instance = CourseDao._internal();
  static CourseDao getInstance() => _instance;
  CourseDao._internal();

  @override
  Course getById(int id) {
    for (int i = 0; i < pool.length; ++i) {
      if (pool[i].id == id) {
        return pool[i];
      }
    }
    return null;
  }

  @override
  List<Course> getAll() => pool;

  /// Create a new `Course` with default value.
  @override
  Course create() {
    ++Dao.idCounter;
    var c = Course(Dao.idCounter - 1, "New course");
    pool.add(c);
    return c;
  }

  /// Associate this course with a timetable
  void updateParent(int id, int timetableId) {
    var course = getById(id);
    var timetable = TimetableDao.getInstance().getById(timetableId);
    if (course != null && timetable != null) {
      course.parentId = timetable.id;
      timetable.courseIds.add(course.id);
    }
  }

  @override
  void delete(int id) {
    for (int i = 0; i < pool.length; ++i) {
      if (pool[i].id == id) {
        // Delete all assignments and exams of this course
        for (final taskId in pool[i].taskIds) {
          TaskDao.getInstance().delete(taskId);
        }
        pool.removeAt(i);
        return;
      }
    }
  }
}
