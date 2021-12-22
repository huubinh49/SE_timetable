import 'package:flutter/material.dart';
import 'package:timetable/widgets/course_tile.dart';

class TimeTableCreateScreen extends StatefulWidget {
  static const routeName = 'timetable-create-screen';

  @override
  State<TimeTableCreateScreen> createState() => _TimeTableCreateScreenState();
}

class _TimeTableCreateScreenState extends State<TimeTableCreateScreen> {
  final _formKey = new GlobalKey<FormState>();

  bool valueCheckBox1 = false;
  bool valueCheckBox2 = false;
  bool valueCheckBox3 = false;

  void _createTimeTable(){
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffcf0),
      appBar: AppBar(
        title: Text(
          "New Calendar",
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
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // Save the value when user type
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
                Row(
                  children: [
                    Expanded(
                        child: CourseTile(
                          title: 'OOP',
                          colorItem: Colors.redAccent,
                          room: 'F102',
                          date: DateTime.now(),
                          hour: 12,
                          minute: 30,
                          id: DateTime.now().toString(),
                          duration: 120,
                        )),
                    SizedBox(width: 10), //SizedBox
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        value: valueCheckBox1,
                        side: BorderSide(color: Colors.blue),
                        onChanged: (bool value) {
                          setState(() {
                            valueCheckBox1 = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                        child: CourseTile(
                          title: 'Computer Network',
                          colorItem: Colors.green,
                          room: 'F102',
                          date: DateTime.now(),
                          hour: 10,
                          minute: 30,
                          id: DateTime.now().toString(),
                          duration: 120,
                        )),
                    SizedBox(width: 10), //SizedBox
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        value: valueCheckBox2,
                        side: BorderSide(color: Colors.blue),
                        onChanged: (bool value) {
                          setState(() {
                            valueCheckBox2 = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                        child: CourseTile(
                          title: 'Math',
                          colorItem: Colors.deepPurple,
                          room: 'F102',
                          date: DateTime.now(),
                          hour: 10,
                          minute: 30,
                          id: DateTime.now().toString(),
                          duration: 120,
                        )),
                    SizedBox(width: 10), //SizedBox
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        value: valueCheckBox3,
                        side: BorderSide(color: Colors.blue),
                        onChanged: (bool value) {
                          setState(() {
                            valueCheckBox3 = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 40,
                ),
                Center(child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    "DELETE",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC20000),
                    ),
                  ),
                ),),
              ],
            ),
          ),
        ),
      )
    );
  }
}
