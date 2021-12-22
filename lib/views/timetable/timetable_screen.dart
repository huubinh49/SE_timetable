import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/views/timetable/timetable_create_screen.dart';
import 'package:timetable/views/timetable/timetable_edit_screen.dart';
import 'package:timetable/widgets/app_drawer.dart';
import 'package:timetable/widgets/calendar_month_view.dart';
import 'package:timetable/widgets/calendar_week_view.dart';

class TimetableScreen extends StatefulWidget {
  static String routeName = "timetable_screen";

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  static double inputHeight = 30;
  String selectedValue = 'Semester 2';
  List<String> items = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
  ];

  bool _isMonthView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Timetable"), //title aof appbar
        backgroundColor: mainColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(TimeTableCreateScreen.routeName);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: inputHeight,
                    color: Color(0xFFF1F1F1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    buttonHeight: inputHeight,
                                    itemHeight: inputHeight,
                                    buttonWidth: 120,
                                    itemWidth: 120,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 15, right: 5),
                                    buttonDecoration: BoxDecoration(
                                      color: Color(0xFFC4C4C4),
                                    ),
                                    hint: Text(
                                      selectedValue,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    items: items
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
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
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(TimeTableEditScreen.routeName);
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() =>
                                    // week calendar widget
                                    {_isMonthView = false});
                              },
                              child: Container(
                                  height: inputHeight,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: _isMonthView == false
                                          ? Colors.blue
                                          : Colors.grey[300],
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[350],
                                            offset: Offset(2, 5),
                                            blurRadius: 5.0,
                                            spreadRadius: 1.0)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      "Week",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                            // Month view calendar
                            GestureDetector(
                              onTap: () =>
                                  setState(() => {_isMonthView = true}),
                              child: Container(
                                height: inputHeight,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: _isMonthView == true
                                        ? Colors.blue
                                        : Colors.grey[300],
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[350],
                                          offset: Offset(2, 5),
                                          blurRadius: 5.0,
                                          spreadRadius: 1.0)
                                    ]),
                                child: Center(
                                    child: Text(
                                  "Month",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ]
                          .map((e) => (Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: e,
                              )))
                          .toList(),
                    ),
                  ),
                  Expanded(child: _isMonthView ? CalendarMonthView() : CalendarWeekView()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
