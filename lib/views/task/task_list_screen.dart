import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/widgets/app_drawer.dart';

class TaskListScreen extends StatelessWidget {
  static String routeName = "task_list_screen";

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Tasks"), //title aof appbar
        backgroundColor: mainColor,
        //background color of appbar
      ),
    );
  }
}
