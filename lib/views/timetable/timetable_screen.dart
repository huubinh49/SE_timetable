import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/widgets/drawer.dart';

class TimetableScreen extends StatelessWidget {
  static String id = "timetable_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Timetable"), //title aof appbar
        backgroundColor: mainColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.pending_outlined,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        //background color of appbar
      ),
    );
  }
}
