import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/widgets/course_tile.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/providers/timetables.dart';
import 'package:timetable/providers/courses.dart';

class TimeTableCreateScreen extends StatefulWidget {
  static const routeName = 'timetable-create-screen';

  @override
  State<TimeTableCreateScreen> createState() => _TimeTableCreateScreenState();
}

class _TimeTableCreateScreenState extends State<TimeTableCreateScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool valueCheckBox1 = false;
  bool valueCheckBox2 = false;
  bool valueCheckBox3 = false;

  String name;
  List<String> selectedCourses = [];

  void _createTimeTable() {
    print('TimetableCreateScreen::_createTimeTable');
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    print('Creating timetable $name...');
    Timetable t = Timetable("", name);
    t.courseIds = selectedCourses;
    Provider.of<Timetables>(context, listen: false).addTimetable(t);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "New Timetable",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                _createTimeTable();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(right: 50),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                              color: const Color(0xff0075FF), width: 3.0),
                        ),
                        hintText: "Title",
                        hintStyle: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the title!";
                        } else if (Provider.of<Timetables>(context,
                                listen: false)
                            .items
                            .map((e) => e.name)
                            .toList()
                            .contains(value)) {
                          return "\"$value\" already existed. Please choose another name.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // Save the value when user type
                        print('TextFormField onSaved');
                        name = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Pick some courses",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: CourseTile(
                  //       name: 'OOP',
                  //       color: Colors.redAccent,
                  //       room: 'F102',
                  //       date: DateTime.now(),
                  //       startTime: 7 * 60 + 30,
                  //       id: DateTime.now().toString(),
                  //       duration: 120,
                  //     )),
                  //     SizedBox(width: 10), //SizedBox
                  //     Transform.scale(
                  //       scale: 1.5,
                  //       child: Checkbox(
                  //         value: valueCheckBox1,
                  //         side: BorderSide(color: Colors.blue),
                  //         onChanged: (bool value) {
                  //           setState(() {
                  //             valueCheckBox1 = value;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Divider(),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: CourseTile(
                  //       name: 'Computer Network',
                  //       color: Colors.green,
                  //       room: 'F102',
                  //       date: DateTime.now(),
                  //       startTime: 10 * 60 + 30,
                  //       id: DateTime.now().toString(),
                  //       duration: 120,
                  //     )),
                  //     SizedBox(width: 10), //SizedBox
                  //     Transform.scale(
                  //       scale: 1.5,
                  //       child: Checkbox(
                  //         value: valueCheckBox2,
                  //         side: BorderSide(color: Colors.blue),
                  //         onChanged: (bool value) {
                  //           setState(() {
                  //             valueCheckBox2 = value;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Divider(),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: CourseTile(
                  //       name: 'Math',
                  //       color: Colors.deepPurple,
                  //       room: 'F102',
                  //       date: DateTime.now(),
                  //       startTime: 10 * 30,
                  //       id: DateTime.now().toString(),
                  //       duration: 120,
                  //     )),
                  //     SizedBox(width: 10), //SizedBox
                  //     Transform.scale(
                  //       scale: 1.5,
                  //       child: Checkbox(
                  //         value: valueCheckBox3,
                  //         side: BorderSide(color: Colors.blue),
                  //         onChanged: (bool value) {
                  //           setState(() {
                  //             valueCheckBox3 = value;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Divider(),
                  ...Provider.of<Courses>(context).items.map((elem) {
                    return Row(
                      children: [
                        Expanded(
                          child: CourseTile(
                            id: elem.id,
                            name: elem.name,
                            color: elem.color,
                            room: elem.room,
                            date: DateTime.now(),
                            startTime: elem.startTime,
                            duration: elem.duration,
                          ),
                        ),
                        SizedBox(width: 10),
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            side: BorderSide(color: Colors.blue),
                            value: selectedCourses.contains(elem.id),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  selectedCourses.add(elem.id);
                                } else {
                                  selectedCourses.removeWhere(
                                      (element) => element == elem.id);
                                }
                              });
                            },
                          ),
                        )
                      ],
                    );
                  }).toList(),
                  // SizedBox(
                  //   height: 40,
                  // ),
                  // Center(
                  //   child: FlatButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       "DELETE",
                  //       style: TextStyle(
                  //         fontSize: 25,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xFFC20000),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
