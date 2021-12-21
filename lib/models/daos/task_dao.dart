import 'package:timetable/models/daos/dao.dart';
import 'package:timetable/models/daos/course_dao.dart';

import 'package:timetable/models/task.dart';
import 'package:timetable/models/assignment.dart';
import 'package:timetable/models/exam.dart';

class TaskDao extends Dao<Task> {
  static final TaskDao _instance = TaskDao._internal();
  static TaskDao getInstance() => _instance;
  TaskDao._internal();

  @override
  Task getById(int id) {
    for (int i = 0; i < pool.length; ++i) {
      if (pool[i].id == id) {
        return pool[i];
      }
    }
    return null;
  }

  @override
  List<Task> getAll() => pool;

  /// Don't use this method. Use `createAssignment()` or `createExam()` instead.
  @override
  Task create({String type = 'assignment'}) {
    ++Dao.idCounter;
    Task t;
    if (type == 'assignment') {
      t = Assignment(
          Dao.idCounter - 1, 'New assignment', DateTime.now(), DateTime.now());
    } else if (type == 'exam') {
      t = Exam(Dao.idCounter - 1, 'New exam', DateTime.now(), DateTime.now());
    }
    pool.add(t);
    return t;
  }

  /// Create a new assignmetn with default values
  Assignment createAssignment() {
    return create(type: 'assignment');
  }

  /// Create a new exam with default values
  Exam createExam() {
    return create(type: 'exam');
  }

  /// Add this task to a parent course
  void updateParent(int id, int courseId) {
    var task = getById(id);
    var course = CourseDao.getInstance().getById(courseId);

    if (task != null && course != null) {
      task.parentId = course.id;
      course.taskIds.add(task.id);
    }
  }

  /// Delete a `Task`.
  @override
  void delete(int id) {
    for (int i = 0; i < pool.length; ++i) {
      if (pool[i].id == id) {
        pool.removeAt(i);
        return;
      }
    }
  }
}
