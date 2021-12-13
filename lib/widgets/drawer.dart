import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/views/authentication/login_screen.dart';
import 'package:timetable/views/course/course_list_screen.dart';
import 'package:timetable/views/course/course_screen.dart';
import 'package:timetable/views/setting/setting_screen.dart';
import 'package:timetable/views/task/task_list_screen.dart';
import 'package:timetable/views/timetable/timetable_screen.dart';


class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 250,
          child:DrawerHeader(

            decoration: BoxDecoration(
              color: lightblack,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50,
                  ),
                  SizedBox(height: 25),
                  Text("Nam Mai", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 5),
                  Text("mdnam2410@gmail.com", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                ]
            ),
          ),
        ),

        ListTile(
          leading: Icon(Icons.calendar_today, color: lightblack,),
          title: const Text('Calendar'),
          onTap: () {
            // Update the state of the app

            // Then close the drawer
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, TimetableScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.school_outlined, color: lightblack,),
          title: const Text('Courses'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, CourseListScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.task_outlined, color: lightblack,),
          title: const Text('Tasks'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, TaskListScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, color: lightblack,),
          title: const Text('Setting'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, SettingScreen.id);
          },
        ),
        ListTile(
          leading: Icon(Icons.logout, color: lightblack,),
          title: const Text('Logout'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          },
        ),
      ],
    ));
  }
}
