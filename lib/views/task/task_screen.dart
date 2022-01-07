import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_date_picker.dart';
import 'package:flutter_material_pickers/helpers/show_swatch_picker.dart';
import 'package:flutter_material_pickers/helpers/show_time_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/models/assignment.dart';
import 'package:timetable/models/exam.dart';
import 'package:timetable/models/course.dart';
import 'package:timetable/models/task.dart';
import 'package:timetable/providers/assignments.dart';
import 'package:timetable/providers/courses.dart';
import 'package:timetable/providers/exams.dart';
import 'package:timetable/views/task/task_list_screen.dart';

import 'create_task_screen.dart';

class TaskScreen extends StatefulWidget {
  static String routeName = "task_screen";

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  double marginH = 15;
  double marginV = 8;

  bool _isInit = true;
  bool _isLoading = false;
  String type;
  var task;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      String id = args['taskId'];
      type = args['type'];
      assert (type == 'assignment' || type == 'exam');

      if (type == 'assignment')
        task = Provider.of<Assignments>(context, listen: false).findById(id);
      else
        task = Provider.of<Exams>(context, listen: false).findById(id);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _deleteTask() async {
    final ok = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text(
            "The deletion cannot be restored"),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              "OK",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context)
                      .primaryColor),
            ),
          ),
        ],
      ),
    );
    if (ok) {
      if (type == 'assignment') {
        Provider.of<Assignments>(context, listen: false)
            .deleteAssignment(task.id);
      }
      else {
        Provider.of<Exams>(context, listen: false)
            .deleteExam(task.id);
      }
      Navigator.of(context).pop();
    }
  }

  void _goToEditTask() async {
    final resultTask = await Navigator.of(context).pushNamed(
        CreateTaskScreen.routeName,
        arguments: {'taskId': task.id, 'type': type}
    );
    setState(() {
      task = resultTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffffcf0),
        appBar: AppBar(
          title: Text(type == 'assignment' ? 'Assignment' : 'Exam'),
          backgroundColor: mainColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.create_rounded, color: Colors.white),
              onPressed: () { _goToEditTask(); },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () { _deleteTask(); },
            ),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : null
    );
  }
}