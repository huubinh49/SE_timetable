import 'package:flutter/cupertino.dart';
import '../views/splash_screen.dart';
import 'package:timetable/views/authentication/sign_in_screen.dart';
import 'package:timetable/views/authentication/sign_up_screen.dart';
import 'package:timetable/views/course/course_list_screen.dart';
import 'package:timetable/views/course/course_screen.dart';
import 'package:timetable/views/course/create_course_screen.dart';
import 'package:timetable/views/setting/setting_screen.dart';
import 'package:timetable/views/task/task_list_screen.dart';
import 'package:timetable/views/timetable/timetable_screen.dart';

Map<String,Widget Function(BuildContext)> routeApp = {
  SettingScreen.routeName: (context) => SettingScreen(),
  TaskListScreen.routeName: (context) => TaskListScreen(),
  CourseListScreen.routeName: (context) => CourseListScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  TimetableScreen.routeName: (context) => TimetableScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  CourseScreen.routeName: (context) => CourseScreen(),
  CreateCourseScreen.routeName: (context) => CreateCourseScreen(),
};