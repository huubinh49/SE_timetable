import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:timetable/models/assignment.dart';
import 'package:timetable/models/exam.dart';
import 'package:timetable/providers/assignments.dart';
import 'package:timetable/providers/exams.dart';
import 'package:timetable/views/task/task_list_screen.dart';

class CreateTaskScreen extends StatefulWidget {
  static String routeName = "create_task_screen";

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  static const double inputHeight = 60;
  static const double gap = 15;
  var _isInit = true;
  var _isLoading = false;
  final _formKey = new GlobalKey<FormState>();
  String taskId;
  DateTime _startDate;
  DateTime _endDate;
  var _attributes = {
    'id': '',
    'name': '',
    'startDate': '', //DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
    'endDate': '', //DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
    'notificationTime': '',//DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
    'topic': '',
    'importantLevel': 1,
    'state': false,
    'note': '',
    'parentId': '',
    'progress': 0,
    'isGroupProject': false,
    'room': '',
    'type': '',
  };

  void updateDateAttributes() {
    _attributes['startDate'] = DateFormat('yyyy-MM-dd HH:mm').format(_startDate);
    _attributes['endDate'] = DateFormat('yyyy-MM-dd HH:mm').format(_endDate);
    _attributes['notificationTime'] = DateFormat('yyyy-MM-dd HH:mm').format(_endDate);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      taskId = args['taskId'];
      assert (args['type'] == 'assignment' || args['type'] == 'exam');
      _attributes['type'] = args['type'];
      if (taskId != null) {
        if (_attributes['type'] == 'assignment') {
          var assignment = Provider.of<Assignments>(context, listen: false).findById(taskId);
          _attributes.addAll(assignment.toMap());
        }
        else {
          var exam = Provider.of<Exams>(context, listen: false).findById(taskId);
          _attributes.addAll(exam.toMap());
        }
        _startDate = DateTime.parse(_attributes['startDate']);
        _endDate = DateTime.parse(_attributes['endDate']);
      }
      else {
        _startDate = DateTime.now();
        _endDate = DateTime.now();
        updateDateAttributes();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveTask() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    setState(() { _isLoading = true; });

    updateDateAttributes();
    var task = _attributes['type'] == 'assignment' ?
      Assignment.fromMap(_attributes) : Exam.fromMap(_attributes);

    if (taskId != null) {
      if (_attributes['type'] == 'assignment') {
        await Provider.of<Assignments>(context, listen: false)
          .updateAssignment(taskId, task);
      }
      else {
        await Provider.of<Assignments>(context, listen: false)
            .updateAssignment(taskId, task);
      }
    }
    else {
      try {
        if (_attributes['type'] == 'assignment') {
          await Provider.of<Assignments>(context, listen: false)
            .addAssignment(task);
        }
        else {
          await Provider.of<Exams>(context, listen: false)
            .addExam(task);
        }
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).errorColor),
            ),
            content:
            Text('Something went wrong!\nPlease try it later! ${error}'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    // Navigator.of(context).popAndPushNamed(TaskListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffcf0),
      appBar: AppBar(
        title: Text((taskId == null ? 'Create ' : 'Edit ') + _attributes['type']),
        backgroundColor: mainColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () { _saveTask(); },
          )
        ],
      ),
      body: _isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 50.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Enter name
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.white,
                        child: TextFormField(
                          initialValue: _attributes['name'],
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.title,
                              color: mainColor,
                            ),
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: const Color(0xff0075FF), width: 3.0),
                            ),
                            hintText: "Title",
                            hintStyle:
                            TextStyle(fontSize: 14, color: hintText),
                          ),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter the title!";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _attributes['name'] = value;
                          },
                        ),
                      ),

                    ],
                  )
                ),
              )
            )
        )
    );
  }
}
