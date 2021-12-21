import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/constants/texts.dart';
import 'package:timetable/views/course/course_screen.dart';

/// Example event class.
class Event {
  final String title;
  final String location;
  final DateTime date;
  final TimeOfDay time;
  final int duration;
  const Event(this.title, this.location, this.date, this.time, this.duration);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(40, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}', 'Online', DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5), TimeOfDay.now(), 50)))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1', 'Online', DateTime.now(), TimeOfDay.now(), 50),
      Event('Today\'s Event 2', 'Online', DateTime.now(), TimeOfDay.now(), 50),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class CalendarMonthView extends StatefulWidget {
  @override
  _CalendarMonthViewState createState() => _CalendarMonthViewState();
}
class _CalendarMonthViewState extends State<CalendarMonthView> {
  ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay;
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  static double inputHeight = 30;
  String selectedValue='Semester 2';
  List<String> items = [
    'Semester 1',
    'Semester 2',
    'Semester 3'
  ];

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime start, DateTime end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: inputHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonHeight: inputHeight,
                        itemHeight: inputHeight,
                        buttonWidth: 120,
                        itemWidth: 120,
                        buttonPadding: const EdgeInsets.only(left: 5, right: 5),
                        buttonDecoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        hint: Text(
                          selectedValue,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        items: items
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() =>
                          // week calendar widget
                          {_calendarFormat = CalendarFormat.week}),
                          child: Container(
                              height: inputHeight,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: _calendarFormat == CalendarFormat.week ? Colors.blue : Colors.grey[300],
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey[350], offset: Offset(2, 5), blurRadius: 5.0, spreadRadius: 1.0)
                                  ]
                              ),
                              child: Center(
                                child:Text("Week", style: TextStyle(color: Colors.white),),
                              )
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() =>
                          {_calendarFormat = CalendarFormat.month}),
                          child: Container(
                            height: inputHeight,
                            width: 80,

                            decoration: BoxDecoration(
                                color: _calendarFormat == CalendarFormat.month ? Colors.blue : Colors.grey[300],
                                boxShadow: [
                                  BoxShadow(color: Colors.grey[350], offset: Offset(2, 5), blurRadius: 5.0, spreadRadius: 1.0)
                                ]
                            ),
                            child: Center(
                                child: Text("Month", style: TextStyle(color: Colors.white),)
                            ),
                          ),
                        ),
                      ],
                    )
                  ].map((e) => (Padding(
                    padding:EdgeInsets.only(left: 5, right: 5) ,
                    child: e,
                  ))).toList(),
                )
            ),
            TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                outsideDaysVisible: false,
                markerDecoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.zero
                ),
                markerMargin: const EdgeInsets.only(right: 3),
                canMarkersOverflow: false,
                selectedDecoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.rectangle
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.green
                ),
                withinRangeDecoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.black,width: 1.0, style: BorderStyle.solid)
                ),
                cellPadding: EdgeInsets.zero,
                // cellMargin: EdgeInsets.zero,
                markersMaxCount: 3,
                markersAlignment: Alignment.topLeft,
                markerSize: 10,
                tableBorder: TableBorder.all(color: Colors.black,width: 1.0, style: BorderStyle.solid),
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                titleCentered: true,

              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8.0),
              child: Text(DateFormat('EEEE, d/MM/yyyy').format(_selectedDay)),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed(CourseScreen.routeName);
                          },
                          child: Container(

                            decoration: BoxDecoration(
                              boxShadow : [BoxShadow(color: Colors.grey[300], offset: Offset(5, 5), blurRadius: 1.0, spreadRadius: 1.0)],
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(bottom: 10.0),

                            height: 70,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 8,
                                  color: Colors.deepOrange,
                                ),
                                Expanded(
                                  child:  Container(
                                      padding: EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('${value[index].title}'),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    WidgetSpan(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right: 2.0, left: 0),
                                                        child: Icon(Icons.location_on_outlined, color: Colors.grey[400],),
                                                      ),
                                                    ),
                                                    TextSpan(text: '${value[index].location}', style: tileSecondaryText),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [
                                              Row(
                                                children: [
                                                  Text(DateFormat("EEE").format(value[index].date) + ", ", style: tileSecondaryText,),
                                                  Text(value[index].time.format(context).toString(), style: tileSecondaryText),
                                                ],
                                              ),
                                              Text('${value[index].duration}h', style: tileSecondaryText),
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            ),
                          )
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )
      );

  }
}