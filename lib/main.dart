import 'package:flutter/material.dart';
import 'package:timetable/views/authentication/signup_screen.dart';
import 'package:timetable/views/course/course_list_screen.dart';
import 'package:timetable/views/course/course_screen.dart';
import 'package:timetable/views/course/create_course_screen.dart';
import 'package:timetable/views/course/edit_course_screen.dart';
import 'package:timetable/views/setting/setting_screen.dart';
import 'package:timetable/views/task/task_list_screen.dart';
import 'views/splash_screen.dart';
import 'views/authentication/login_screen.dart';
import 'views/timetable/timetable_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timetable App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: CourseListScreen.id,
      routes: {
        SettingScreen.id: (context) => SettingScreen(),
        TaskListScreen.id: (context) => TaskListScreen(),
        CourseListScreen.id: (context) => CourseListScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        TimetableScreen.id: (context) => TimetableScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        CourseScreen.id:(context) => CourseScreen(),
        CreateCourseScreen.id: (context) => CreateCourseScreen(),
        EditCourseScreen.id: (context) => EditCourseScreen()
      },
    );
  }
}