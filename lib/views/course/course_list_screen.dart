import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/widgets/course_tile.dart';
import 'package:timetable/widgets/drawer.dart';

import 'course_screen.dart';
import 'create_course_screen.dart';

class CourseListScreen extends StatelessWidget {
  static String id = "course_list_screen";

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title:Text("Courses"), //title aof appbar
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
      body: Container(
        child: Column(
          children: [
            CourseTile(),
            CourseTile(),
            CourseTile(),
          ].map((e) => Padding(padding: EdgeInsets.only(top: 10), child: e)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), //child widget inside this button
        onPressed: (){
          //task to execute when this button is pressed
          Navigator.of(context).pushNamed(CreateCourseScreen.id);
        },
      ),
    );
  }
}
