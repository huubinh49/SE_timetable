import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/constants/texts.dart';
import 'package:intl/intl.dart';
import 'edit_course_screen.dart';

class CourseScreen extends StatelessWidget {
  static String id = "course_screen";

  String title = "Computer Network";
  String lecturer = "Cuong Do";
  DateTime date = DateTime.now();
  var duration = 180;
  var startTime = TimeOfDay.now();
  var endTime = TimeOfDay.now();
  String address = "F102";
  String note = "Interesting course!";
  Color theme =  Colors.red;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  TimeOfDay getEndTime(TimeOfDay startTimeOfDay, int minutes) {
    DateTime today = DateTime.now();
    DateTime customDateTime = DateTime(today.year, today.month, today.day, startTimeOfDay.hour, startTimeOfDay.minute);
    return TimeOfDay.fromDateTime(customDateTime.add(Duration(minutes: minutes)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: theme,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.create_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(EditCourseScreen.id);
              },
            )
          ],
          //background color of appbar
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(20.0),
                        width: MediaQuery.of(context).size.width,
                        height: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          boxShadow : [
                            BoxShadow(color: Colors.grey[400], offset: Offset(5, 5), blurRadius: 5.0, spreadRadius: 1.0)
                          ],
                          color: theme,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(title, style: primaryText),
                            ),
                            Text(lecturer, style: normalText)
                          ],
                        )
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 32,),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat('EEEE').format(date), style: TextStyle(color: Colors.black, fontSize: 18),),
                                SizedBox(height:5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${startTime.hour}:${startTime.minute}',
                                        style: TextStyle(color: Colors.black, fontSize: 18)
                                      ),
                                      WidgetSpan(
                                        child: Icon(Icons.arrow_right, size: 14),
                                      ),
                                      TextSpan(
                                        text: '${endTime.hour}:${endTime.minute}',
                                          style: TextStyle(color: Colors.black, fontSize: 18)
                                      ),
                                      TextSpan(
                                        text: '  (${duration/60} hours)',
                                          style: TextStyle(color: Colors.black, fontSize: 18)
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 32,),
                            SizedBox(width: 20,),
                            Text(address, style: TextStyle(color: Colors.black, fontSize: 18))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.note_outlined, size: 32,),
                            SizedBox(width: 20,),
                            Text(note,style: TextStyle(color: Colors.black, fontSize: 18))
                          ],
                        )
                      ].map((c) => Container(
                        padding: EdgeInsets.all(20.0),
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        child: c
                      )).toList()
                    )]),
                )
            ),
        );
  }
}
