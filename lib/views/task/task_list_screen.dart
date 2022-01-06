import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/models/assignment.dart';
import 'package:timetable/models/task.dart';
import 'package:timetable/providers/assignments.dart';
import 'package:timetable/providers/exams.dart';
import 'package:timetable/widgets/app_drawer.dart';
import 'package:timetable/widgets/task_tile.dart';

import 'create_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  static String routeName = "task_list_screen";
  @override
  State<StatefulWidget> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<Assignments>(context).fetchAndSetDataAssignments().catchError((error) => {
      }).whenComplete(() => {
        setState(() {
          _isLoading = false;
        })
      });
      Provider.of<Exams>(context).fetchAndSetDataExams().catchError((error) => {
      }).whenComplete(() => {
        setState(() {
          _isLoading = false;
        })
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final assignmentData = Provider.of<Assignments>(context);
    final examData = Provider.of<Exams>(context);
    final List<Task> taskData = assignmentData.items.cast();
    taskData.addAll(examData.items.cast());
    taskData.sort((a,b) {
      return a.endDate.compareTo(b.endDate);
    });
    assignmentData.items.sort((a,b) {
    return a.endDate.compareTo(b.endDate);
    });
    examData.items.sort((a,b) {
    return a.endDate.compareTo(b.endDate);
    });
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Tasks"), //title aof appbar
          backgroundColor: mainColor,
          //background color of appbar
          bottom: TabBar(
              tabs: [
                Tab(text: 'Task',
                    icon: Icon(Icons.library_add_check_outlined)),
                Tab(text: 'Assignment',
                    icon: Icon(Icons.check_box_outlined)),
                Tab(text: 'Exam', icon: Icon(Icons.fact_check_outlined)),
              ]
          ),
        ),
        body: TabBarView(
          children: [
            _isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
              padding: EdgeInsets.all(8),
              child: taskData.isEmpty ? Center(child: Text('You not add task yet!', style: TextStyle(fontSize: 20),),) : ListView.builder(
                itemBuilder: (ctx, i) => Column(
                  children: [
                    TaskTile(
                      id: taskData[i].id,
                      name: taskData[i].name,
                      endDate: taskData[i].endDate,
                      state: taskData[i].state,
                      color: taskData[i].color,
                      parentId: taskData[i].parentId,
                    ),
                    Divider(),
                  ],
                ),
              itemCount: taskData.length,
              ),
            ),
            _isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
              padding: EdgeInsets.all(8),
              child: assignmentData.items.isEmpty ? Center(child: Text('You not add task yet!', style: TextStyle(fontSize: 20),),) : ListView.builder(
                itemBuilder: (ctx, i) => Column(
                  children: [
                    TaskTile(
                      id: assignmentData.items[i].id,
                      name: assignmentData.items[i].name,
                      endDate: assignmentData.items[i].endDate,
                      state: assignmentData.items[i].state,
                      color: assignmentData.items[i].color,
                      parentId: assignmentData.items[i].parentId,
                    ),
                    Divider(),
                  ],
                ),
                itemCount: assignmentData.items.length,
              ),
            ),
            _isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
              padding: EdgeInsets.all(8),
              child: examData.items.isEmpty ? Center(child: Text('You not add task yet!', style: TextStyle(fontSize: 20),),) : ListView.builder(
                itemBuilder: (ctx, i) => Column(
                  children: [
                    TaskTile(
                      id: examData.items[i].id,
                      name: examData.items[i].name,
                      endDate: examData.items[i].endDate,
                      state: examData.items[i].state,
                      color: examData.items[i].color,
                      parentId: examData.items[i].parentId,
                    ),
                    Divider(),
                  ],
                ),
                itemCount: examData.items.length,
              ),
            ),
        ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), //child widget inside this button
          onPressed: (){
            //task to execute when this button is pressed
            Navigator.of(context).pushNamed(CreateTaskScreen.routeName);
          },
        ),
      ),
    );
  }
}
