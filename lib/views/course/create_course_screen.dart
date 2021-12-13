import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:intl/intl.dart';
class CreateCourseScreen extends StatefulWidget {
  static String id = "create_course_screen";
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController lecturerTextEditingController = TextEditingController();
  TextEditingController locationTextEditingController= TextEditingController();
  TextEditingController durationTextEditingController = TextEditingController();
  TextEditingController noteTextEditingController = TextEditingController();
  String selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  static const double inputHeight = 60;
  static const double inputPadding = 12;
  static const double gap = 15;
  Color swatch = Colors.blue;

  var time = TimeOfDay.now();
  var date = DateTime.now();



  @override
  Widget build(BuildContext context) {
    double inputWidth = MediaQuery.of(context).size.width - 50;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xfffffcf0),
        appBar: AppBar(
          title:Text("Create Course"), //title aof appbar
          backgroundColor: mainColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          //background color of appbar
        ),
        body: SingleChildScrollView(

            child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 50.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: gap),
                        height: inputHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: const Color(0xff0075FF))
                          )
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonHeight: inputHeight,
                            itemHeight: inputHeight,
                            buttonWidth: inputWidth,
                            itemWidth: inputWidth,
                            buttonPadding: const EdgeInsets.only(left: 12, right: 12),
                            buttonDecoration: BoxDecoration(
                              color: Colors.white,

                            ),
                            hint: Text(
                              'Choose Timetable',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            items: items
                                .map((item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                  ),
                                ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: gap),
                        width: inputWidth,
                        height: inputHeight,
                        decoration: BoxDecoration(
                            color: Colors.white,
                        ),
                        child: TextField(
                          controller: titleTextEditingController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.title, color: mainColor,),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: const Color(0xff0075FF), width: 3.0),
                            ),
                            hintText: "Title",
                            hintStyle: TextStyle(fontSize: 14, color: hintText),
                          ),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: gap),
                        width: inputWidth,
                        height: inputHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: lecturerTextEditingController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.supervisor_account, color: mainColor,),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: const Color(0xff0075FF), width: 3.0),
                            ),
                            hintText: "Lecturer",
                            hintStyle: TextStyle(fontSize: 14, color: hintText),
                          ),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: gap),
                        width: inputWidth,
                        height: inputHeight,
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: inputWidth/2,
                              height: inputHeight,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: locationTextEditingController,
                                keyboardType: TextInputType.streetAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.location_on_outlined, color: mainColor,),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: const Color(0xff0075FF), width: 3.0),
                                  ),
                                  hintText: "Location",
                                  hintStyle: TextStyle(fontSize: 14, color: hintText),
                                ),
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                                child:Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5) ,
                                        child: Icon(Icons.color_lens_outlined)
                                      ),
                                      SizedBox(
                                          height: 40,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: swatch,
                                                shape: CircleBorder()// background
                                            ),
                                            onPressed: (){showMaterialSwatchPicker(
                                              context: context,

                                              selectedColor: swatch,
                                              onChanged: (value) => setState(() => swatch = value),
                                            );},
                                          )
                                      )
                                    ]
                                )
                            ),

                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: gap),
                          width: inputWidth,
                          height: inputHeight,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white)
                            ),
                            icon: Icon(Icons.calendar_today_outlined, color:  Colors.black),
                            label: Text(DateFormat("yyyy-MM-dd").format(date), style: TextStyle(color: Colors.black),),
                            onPressed: (){
                              showMaterialDatePicker(
                                firstDate: DateTime.now().subtract(Duration(days: 2021 * 10)),
                                lastDate: DateTime.now().add(Duration(days: 2021 * 10)),
                                context: context,
                                selectedDate: date,
                                onChanged: (value) => setState(() => date = value),
                              );
                            },
                          )
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: gap),
                        width: inputWidth,
                        height: inputHeight,
                        child: Row(
                          children: [
                            SizedBox(
                                width: inputWidth/2,
                                height: 50,
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.redAccent)
                                  ),
                                  icon: Icon(Icons.access_time),
                                  label: Text(time.format(context)),
                                  onPressed: (){
                                    showMaterialTimePicker(
                                      context: context,
                                      selectedTime: time,
                                      onChanged: (value) => setState(() => time = value),
                                    );
                                  },
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20),
                              child:SizedBox(
                                width: inputWidth/2-20,
                                height: 50,
                                child: TextField(
                                  controller: durationTextEditingController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: const Color(0xff0075FF), width: 3.0),
                                    ),
                                    hintText: "Duration (min)",
                                    hintStyle: TextStyle(fontSize: 14, color: hintText),
                                  ),
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              )
                            )
                          ]
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: gap),
                        width: inputWidth,
                        child:TextField(
                          controller: noteTextEditingController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          maxLines: 8,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: const Color(0xff0075FF), width: 3.0),
                            ),
                            hintText: "Add note",
                            hintStyle: TextStyle(fontSize: 14, color: hintText),
                          ),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),

                      )
                  ]),
                )
            ))
    );
  }
}
