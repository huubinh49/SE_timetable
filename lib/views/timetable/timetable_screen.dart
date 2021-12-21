import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/widgets/app_drawer.dart';
import 'package:timetable/widgets/month_view_calendar.dart';

class TimetableScreen extends StatelessWidget {
  static String routeName = "timetable_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Timetable"), //title aof appbar
        backgroundColor: mainColor,
        //background color of appbar
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
          child: Center(child: Column(children: [CalendarMonthView()]))),
    );
  }
}
