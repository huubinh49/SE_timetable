import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/constants/texts.dart';
import 'package:timetable/views/authentication/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  static String id = "signup_screen";

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();

  void showSnackBar(String message, BuildContext context){
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: mainColor,
        body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                'Sign up',
                style: titleText,
                )
              ),
              Text(
                'Enter the below information to sign up',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: fullNameTextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.info, color: mainColor,),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blueGrey, width: 3.0),
                        ),
                        hintText: "Full Name",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                        height: 10
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail, color: mainColor,),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blueGrey, width: 3.0),
                        ),
                        hintText: "Email Address",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                        height: 10
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: mainColor,),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blueGrey, width: 3.0),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                        height: 10
                    ),
                    TextField(
                      controller: confirmPasswordTextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.shield, color: mainColor,),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blueGrey, width: 3.0),
                        ),
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                        height: 32
                    ),
                    RaisedButton(
                      color: Colors.white,
                      textColor: mainColor,
                      child: Container(
                        height: 60,
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Work-Sans", color: mainColor),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        if(emailTextEditingController.text.isEmpty || passwordTextEditingController.text.isEmpty){
                          showSnackBar('Please enter all of information!', context);
                          return;
                        }
                        if (!emailTextEditingController.text.contains('@')) {
                          showSnackBar(
                              'Please enter a valid email!', context);
                          return;
                        } else if (passwordTextEditingController.text.length <
                            6) {
                          showSnackBar(
                              'Password must be at least 6 characters!',
                              context);
                          return;
                        } else {
                          // loginApp(context);
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child:RichText(
                        text: TextSpan(
                            text: 'Already have an account? ',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                            children: [
                              TextSpan(
                                text: 'Sign in',
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        LoginScreen.id, (route) => false);
                                  },
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ]
          )
        )
      )
    ));
  }
}
