import 'package:flutter/material.dart';
import 'package:timetable/constants/texts.dart';
import 'package:timetable/views/course/course_screen.dart';

class CourseTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(CourseScreen.id);
      },
      child: Container(

        decoration: BoxDecoration(
          boxShadow : [BoxShadow(color: Colors.grey[300], offset: Offset(5, 5), blurRadius: 1.0, spreadRadius: 1.0)],
          color: Colors.white,
        ),


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
                          Text("Software Engineering"),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Icons.location_on_outlined, color: Colors.grey[400],),
                                  ),
                                ),
                                TextSpan(text: 'Online', style: tileSecondaryText),
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
                              Text("Thu" + ", ", style: tileSecondaryText,),
                              Text("7:15", style: tileSecondaryText),
                            ],
                          ),
                          Text('2h', style: tileSecondaryText),
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
  }
}
