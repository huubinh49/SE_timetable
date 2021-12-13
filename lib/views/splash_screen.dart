import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timetable/constants/texts.dart';
import '../constants/colors.dart';
import './authentication/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
      // Navigator.of(context).pushNamedAndRemoveUntil(FirebaseAuth.instance.currentUser == null ? LoginScreen.id : MainScreen.id, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Padding(
                padding: EdgeInsets.only(top: 200),
                child: Container(
                    height: 168,
                    width: 168,
                    child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.cover
                    )
                )
            )
            ,
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                    height: 80,
                    child: Text("STUDY LIFE",
                        style: titleText
                    )
                )
            )
            ,
            SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}