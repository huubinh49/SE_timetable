import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/widgets/course_tile.dart';
import 'package:timetable/providers/courses.dart';
import 'package:timetable/providers/timetables.dart';

class TimeTableEditScreen extends StatefulWidget {
  static const routeName = 'timetable-edit-screen';

  @override
  State<TimeTableEditScreen> createState() => _TimeTableEditScreenState();
}

class _TimeTableEditScreenState extends State<TimeTableEditScreen> {
  final _formKey = new GlobalKey<FormState>();

  bool valueCheckBox1 = false;
  bool valueCheckBox2 = false;
  bool valueCheckBox3 = false;

  bool _isInit;
  String _timetableId;
  Timetable _currentTimetable;
  String _currentName;
  List<String> _selectedCourses;

  @override
  void initState() {
    super.initState();
    _isInit = true;
    _timetableId = null;
    _currentTimetable = null;
    _currentName = '';
    _selectedCourses = [];
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // _timetableId = ModalRoute.of(context).settings.arguments as String;
      _currentTimetable = Provider.of<Timetables>(context)
          .findById(ModalRoute.of(context).settings.arguments as String);
      _currentName = _currentTimetable.name;
      _selectedCourses = _currentTimetable.courseIds;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void _editTimeTable() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    Timetable newTimetable = Timetable('', _currentName);
    newTimetable.courseIds = _selectedCourses;
    Provider.of<Timetables>(context, listen: false)
        .updateTimetable(_currentTimetable.id, newTimetable);
    Navigator.of(context).pop();
  }

  void _deleteTimetable() {
    Provider.of<Timetables>(context, listen: false)
        .deleteTimetable(_currentTimetable.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffffcf0),
        appBar: AppBar(
          title: Text(
            "Edit timetable",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                _editTimeTable();
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
                      initialValue: _currentName,
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
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // Save the value when user type
                        setState(() {
                          _currentName == value;
                        });
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
                  //       startTime: 12 * 60 + 30,
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
                  //       startTime: 10 * 60 + 30,
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
                            value: _selectedCourses.contains(elem.id),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  _selectedCourses.add(elem.id);
                                } else {
                                  _selectedCourses.removeWhere(
                                      (element) => element == elem.id);
                                }
                              });
                            },
                          ),
                        )
                      ],
                    );
                  }).toList(),
                  Divider(),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: FlatButton(
                      onPressed: () {
                        _deleteTimetable();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "DELETE",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC20000),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
