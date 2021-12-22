import 'package:timetable/models/timetable.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Timetables with ChangeNotifier {
  List<Timetable> _items = [];

  String projectUrl =
      'https://timetable-app-60033-default-rtdb.firebaseio.com/';
  final String authToken;
  final String userId;

  Timetables(this.authToken, this.userId, this._items);

  List<Timetable> get items => _items;

  /// Return a URL that references this path. This method assumes that you are in
  /// /users/$userId
  String _makeRef(String path) {
    return '$projectUrl/user/$userId/$path?auth=$authToken';
  }

  Future<void> fetchAndSetDataTimetables() async {
    final url = Uri.parse(_makeRef('timetables.json'));
    try {
      final response = await http.get(url);
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      if (jsonData == null) {
        return;
      }

      final List<Timetable> loadedTimetables = [];
      jsonData.forEach((id, body) {
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
    try {
      final response = await http.post(url, body: json.encode(t.bodyToMap()));
      final newTimetable = Timetable(json.decode(response.body)['name'], t.name,
          startDate: t.startDate, endDate: t.endDate);
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
    await http.post(url, body: json.encode(newTimetable.bodyToMap()));
    items[idx] = newTimetable;
    notifyListeners();
  }

  void deleteCourse(String id) {
    var idx = items.indexWhere((element) => element.id == id);
    if (idx < 0) {
      return;
    }
    final url = Uri.parse(_makeRef('timetables/$id'));
    http.delete(url).then((value) {
      items.removeAt(idx);
      notifyListeners();
    });
  }

  Timetable findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
