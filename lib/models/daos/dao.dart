/// Abstract base class for other data access object classes: `TimetableDao`,
/// `CourseDao` and `TaskDao`. This class provides:
/// * A common `idCounter` used throughout the system
/// * Common interface for other DAO classes to implement
/// * Interface to access the database (to be implemented)
abstract class Dao<T> {
  static int idCounter = 0;
  final List<T> pool = <T>[];

  T getById(int id);

  List<T> getAll();

  /// Create an object T with default value
  T create();

  void delete(int id);
}
