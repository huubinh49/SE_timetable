import 'package:flutter/material.dart';
import '../models/course.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Courses with ChangeNotifier {
  List<Course> _items = [];

  final String authToken;
  final String userId;

  Courses(this.authToken, this.userId, this._items);

  List<Course> get items {
    return [..._items];
  }


  Future<void> fetchAndSetDataCourses() async {
    final url = Uri.parse(
        'https://timetable-app-60033-default-rtdb.firebaseio.com/user/$userId/courses.json?auth=$authToken');
    try {
      final response = await http.get(url);
      // Convert json to flutter data by json.decode()
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Course> loadedCourses = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((courseId, courseData) {
        loadedCourses.add(Course(
          courseId,
          courseData['name'],
          date: DateTime.parse(courseData['date']),
          startTime: courseData['startTime'],
          duration: courseData['duration'],

          lecturerName: courseData['lecturerName'],
          room: courseData['room'],
          color: Color(courseData['color']).withOpacity(1),
          note: courseData['note'],
          taskIds: courseData['taskIds'].split(", ")
        ));
      });
      _items = loadedCourses;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Make this function is Future to show the indicator when the user add new course and wait the response
  Future<void> addCourse(Course course) async {
    final url = Uri.parse(
        'https://timetable-app-60033-default-rtdb.firebaseio.com/user/$userId/courses.json?auth=$authToken');
    try {
      // Define url and kind of data to post in http.post(url, kind data)
      // Convert data to json by json.encode({})
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': course.name,
            'duration': course.duration,
            'color': course.color.value,
            'date': course.date.toIso8601String(),
            'note': course.note,
            'lecturerName': course.lecturerName,
            'room': course.room,
            'startTime': course.startTime,
            'taskIds': course.taskIds.join(", ")
          },
        ),
      );
      // Use async function to wait for post data and get the response => Can get ID from the response
      // ID = json.decode(response.body)['name']
      final newCourse = Course(
        json.decode(response.body)['name'],
        course.name,
        date: course.date,
        startTime: course.startTime,
        duration: course.duration,
        color: course.color,
        room: course.room,
        lecturerName: course.lecturerName,
        note: course.note,
        taskIds: course.taskIds
      );
      debugPrint(newCourse.id);
      _items.insert(0, newCourse);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateCourse(String id, Course newCourse) async {
    final courseIndex = _items.indexWhere((value) => value.id == id);
    if (courseIndex >= 0) {
      final url = Uri.parse(
          'https://timetable-app-60033-default-rtdb.firebaseio.com/user/$userId/courses/$id.json?auth=$authToken');
      final timestamp = newCourse.date;
      await http.patch(url,
          body: json.encode({
            'name': newCourse.name,
            'duration': newCourse.duration,
            'color': newCourse.color.value,
            'date': newCourse.date.toIso8601String(),
            'note': newCourse.note,
            'lecturer': newCourse.lecturerName,
            'room': newCourse.room,
            'startTime': newCourse.startTime,
            "taskIds": newCourse.taskIds.join(", ")
          }));
      _items[courseIndex] = newCourse;
      notifyListeners();
    } else {
      return;
    }
  }

  void deleteCourse(String id) {
    final url = Uri.parse(
        'https://timetable-app-60033-default-rtdb.firebaseio.com/user/$userId/courses/$id.json?auth=$authToken');
    http.delete(url).then((value) {
      _items.removeWhere((course) => course.id == id);
      notifyListeners();
    });
  }

  Course findById(String id) {
    return _items.firstWhere((value) => value.id == id);
  }
}