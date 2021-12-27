import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';
import 'package:timetable/providers/courses.dart';
import 'package:timetable/providers/timetables.dart';

class CalendarWeekView extends StatelessWidget {
  final String timetableId;
  CalendarWeekView(this.timetableId);

  @override
  Widget build(BuildContext context) {
    final Courses courses = Provider.of<Courses>(context);
    final courseIds = Provider.of<Timetables>(context, listen: false)
        .findById(timetableId)
        .courseIds;
    return SfCalendar(
      view: CalendarView.week,
      headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center),
      dataSource: MeetingDataSource(getAppointments(courses, courseIds)),
      showCurrentTimeIndicator: false,
    );
  }
}

DateTime _makeDateTime(int time) {
  final today = DateTime.now();
  return DateTime(
      today.year, today.month, today.second, time ~/ 60, time % 60, 0);
}

List<Appointment> getAppointments(Courses courses, List<String> courseIds) {
  List<Appointment> meetings = <Appointment>[];
  // final DateTime today = DateTime.now();
  // start time at 9:0:0 today
  // final DateTime startTime =
  //     DateTime(today.year, today.month, today.day, 9, 0, 0);
  // final DateTime endTime = startTime.add(const Duration(hours: 2));

  if (courseIds != null) {
    for (final id in courseIds) {
      var c = courses.findById(id);
      meetings.add(Appointment(
          startTime: _makeDateTime(c.startTime),
          endTime: _makeDateTime(c.startTime + c.duration),
          subject: c.name,
          color: c.color,
          recurrenceRule: 'FREQ=WEEKLY;BYDAY=WE;INTERVAL=1'));
    }
  }

  // meetings.add(
  //   Appointment(
  //     startTime: startTime,
  //     endTime: endTime,
  //     subject: "OOP",
  //     recurrenceRule: 'FREQ=WEEKLY;BYDAY=WE;INTERVAL=1',
  //     color: Colors.redAccent,
  //   ),
  // );
  // meetings.add(
  //   Appointment(
  //     startTime: startTime.add(Duration(days: 2, hours: 3)),
  //     endTime: endTime.add(Duration(days: 2, hours: 3)),
  //     subject: "Computer Network",
  //     recurrenceRule: 'FREQ=WEEKLY;BYDAY=FR;INTERVAL=1',
  //     color: Colors.green,
  //   ),
  // );
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> data) {
    appointments = data;
  }
}
