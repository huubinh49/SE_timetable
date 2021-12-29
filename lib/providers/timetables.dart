import 'package:timetable/models/timetable.dart';

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Timetables with ChangeNotifier {
  List<Timetable> _items = [];

  String projectUrl = 'https://timetable-app-60033-default-rtdb.firebaseio.com';
  String authToken;
  String userId;
  DateTime previousGetRequestTime;

  Timetables(this.authToken, this.userId, this._items) {
    print('Timetables constructor with auth token $authToken, user id $userId');
  }

  List<Timetable> get items => _items;

  /// Return a URL that references this path. This method assumes that you are in
  /// /users/$userId
  String _makeRef(String path) {
    return '$projectUrl/user/$userId/$path?auth=$authToken';
  }

  bool _okToGo() {
    return authToken != null &&
        authToken != '' &&
        userId != null &&
        userId != '';
  }

  void updateAuth(String newAuthToken, String newUserId) {
    print(
        'Timetables: Updating new authentication ($newAuthToken, $newUserId)');
    if (newAuthToken == authToken && newUserId == userId) {
      return;
    }
    previousGetRequestTime = null;
    _items = [];
    authToken = newAuthToken;
    userId = newUserId;
  }

  /// Check if the data has changed. If it is, download the changes, apply the
  /// changes and notify listeners.
  Future<void> fetch() async {
    log('Timetables: Fetching timetable data...');
    if (!_okToGo()) {
      return;
    }
    final url = Uri.parse(_makeRef('timetables.json'));

    log('Timetables: Fetching from $url');
    try {
      var response;
      print(previousGetRequestTime);
      if (previousGetRequestTime == null) {
        response = await http.get(url);
      } else {
        response = await http.get(url, headers: {
          'If-Modified-Since': previousGetRequestTime.toIso8601String()
        });
      }
      previousGetRequestTime = DateTime.now();

      print(response.statusCode);
      if (response.statusCode == 304) {
        log('Timetable: No change since $previousGetRequestTime');
        return;
      }
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      if (jsonData == null) {
        return;
      }
      final List<Timetable> loadedTimetables = [];
      jsonData.forEach((id, body) {
        print('$id, $body');
        loadedTimetables.add(Timetable.fromMap(id, body));
      });
      _items = loadedTimetables;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addTimetable(Timetable t) async {
    final url = Uri.parse(_makeRef('timetables.json'));
    print(url);
    try {
      final response = await http.post(url, body: json.encode(t.bodyToMap()));
      final newTimetable = Timetable(json.decode(response.body)['name'], t.name,
          startDate: t.startDate, endDate: t.endDate);
      newTimetable.courseIds = t.courseIds;
      _items.insert(0, newTimetable);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateTimetable(String id, Timetable newTimetable) async {
    var idx = items.indexWhere((element) => element.id == id);
    if (idx < 0) {
      return;
    }

    final url = Uri.parse(_makeRef('timetables/$id.json'));
    await http.patch(url, body: json.encode(newTimetable.bodyToMap()));
    items[idx].name = newTimetable.name;
    items[idx].startDate = newTimetable.startDate;
    items[idx].endDate = newTimetable.endDate;
    items[idx].courseIds = newTimetable.courseIds;
    notifyListeners();
  }

  void deleteTimetable(String id) {
    var idx = items.indexWhere((element) => element.id == id);
    if (idx < 0) {
      return;
    }
    final url = Uri.parse(_makeRef('timetables/$id.json'));
    http.delete(url).then((value) {
      items.removeAt(idx);
      notifyListeners();
    });
  }

  Timetable findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> updateWhenCourseDeleted(String courseId) async {
    for (final item in items) {
      int idx = item.courseIds.indexWhere((element) => element == courseId);
      if (idx != -1) {
        item.courseIds.removeAt(idx);
        final url = Uri.parse(_makeRef('timetables/${item.id}.json'));
        await http.patch(url, body: json.encode({'courseIds': item.courseIds}));
      }
    }
    notifyListeners();
  }
}
