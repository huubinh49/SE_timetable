import 'package:flutter/material.dart';
import '../models/course.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// DateTime.parse(orderData['date']
// Color(colorItem).withOpacity(1)

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
        'https://timetable-app-60033-default-rtdb.firebaseio.com/courses.json?auth=$authToken&orderBy="userID"&equalTo="$userId"');
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
          id: courseId,
          timeMinute: courseData['minutes'],
          timeHour: courseData['hours'],
          note: courseData['note'],
          colorItem: Color(courseData['colorItem']).withOpacity(1),
          lecturer: courseData['lecturer'],
          room: courseData['room'],
          date: DateTime.parse(courseData['date']),
          duration: courseData['duration'],
          title: courseData['title'],
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
        'https://timetable-app-60033-default-rtdb.firebaseio.com/courses.json?auth=$authToken');
    final timestamp = course.date;
    try {
      // Define url and kind of data to post in http.post(url, kind data)
      // Convert data to json by json.encode({})
      final response = await http.post(
        url,
        body: json.encode(
          {
            'userID': userId,
            'title': course.title,
            'duration': course.duration,
            'colorItem': course.colorItem.value,
            'date': timestamp.toIso8601String(),
            'note': course.note,
            'lecturer': course.lecturer,
            'room': course.room,
            'hours': course.timeHour,
            'minutes': course.timeMinute,
          },
        ),
      );
      // Use async function to wait for post data and get the response => Can get ID from the response
      // ID = json.decode(response.body)['name']
      final newCourse = Course(
        id: json.decode(response.body)['name'],
        title: course.title,
        timeHour: course.timeHour,
        timeMinute: course.timeMinute,
        duration: course.duration,
        colorItem: course.colorItem,
        date: timestamp,
        room: course.room,
        lecturer: course.lecturer,
        note: course.note,
      );
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
          'https://timetable-app-60033-default-rtdb.firebaseio.com/courses/$id.json?auth=$authToken');
      final timestamp = newCourse.date;
      await http.patch(url,
          body: json.encode({
            'title': newCourse.title,
            'duration': newCourse.duration,
            'colorItem': newCourse.colorItem.value,
            'date': timestamp.toIso8601String(),
            'note': newCourse.note,
            'lecturer': newCourse.lecturer,
            'room': newCourse.room,
            'hours': newCourse.timeHour,
            'minutes': newCourse.timeMinute,
          }));
      _items[courseIndex] = newCourse;
      notifyListeners();
    } else {
      return;
    }
  }

  void deleteCourse(String id) {
    final url = Uri.parse(
        'https://timetable-app-60033-default-rtdb.firebaseio.com/courses/$id.json?auth=$authToken');
    http.delete(url).then((value) {
      _items.removeWhere((course) => course.id == id);
      notifyListeners();
    });
  }

  Course findById(String id) {
    return _items.firstWhere((value) => value.id == id);
  }


}
