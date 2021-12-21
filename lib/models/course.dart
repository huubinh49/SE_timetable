import 'package:flutter/material.dart';

class Course {
  final String id;
  final String title;
  final String lecturer;
  final String room;
  final DateTime date;
  final int timeHour;
  final int timeMinute;
  final String note;
  final int duration;
  final Color colorItem;

  Course(
      {this.id,
      this.title,
      this.lecturer,
      this.room,
      this.date,
      this.timeHour,
      this.timeMinute,
      this.duration,
      this.note,
      this.colorItem});
}
