import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWeekView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center),
      dataSource: MeetingDataSource(getAppointments()),
      showCurrentTimeIndicator: false,
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  // start time at 9:0:0 today
  final DateTime startTime = DateTime(
      today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(
    Appointment(startTime: startTime,
    endTime: endTime,
    subject: "OOP",
    recurrenceRule: 'FREQ=WEEKLY;BYDAY=WE;INTERVAL=1',
    color: Colors.redAccent,),
  );
  meetings.add(
    Appointment(startTime: startTime.add(Duration(days: 2, hours: 3)),
      endTime: endTime.add(Duration(days: 2, hours: 3)),
      subject: "Computer Network",
      recurrenceRule: 'FREQ=WEEKLY;BYDAY=FR;INTERVAL=1',
      color: Colors.green,),
  );
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> data) {
    appointments = data;
  }
}