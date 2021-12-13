
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:timetable/constants/colors.dart';
import 'package:timetable/constants/texts.dart';
import 'package:timetable/views/authentication/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  static String id = "login_screen";
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
                      'Sign in',
                      style: titleText,
                    )
                )
                ,
                Text(
                  'Login to your account',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
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
                      Align(
                          alignment: Alignment.centerRight,
                       child: Padding(
                         padding: EdgeInsets.only(top: 20, bottom: 20),
                         child: Text("Forgot Password?", style: TextStyle(
                             decoration: TextDecoration.underline,
                             color: Colors.white,
                             fontSize: 12
                         )),
                       )
                      )
                      ,
                      RaisedButton(
                        color: Colors.white,
                        textColor: mainColor,
                        child: Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              'SIGN IN',
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
                              text: 'Don\'t have an account? ',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                              children: [
                                TextSpan(
                                  text: 'Sign up',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          SignUpScreen.id, (route) => false);
                                    },
                                )
                              ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child:Row(
                            children: <Widget>[
                              Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    height: 10,
                                    thickness: 1,
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text("OR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)
                              ),
                              Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    height: 10,
                                    thickness: 1,
                                  )
                              ),

                            ]),
                      ),

                      RaisedButton(
                        color: Colors.white,
                        textColor: mainColor,
                        child: Container(
                          height: 60,
                          child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(Icons.facebook, size: 36,)
                                ),
                                SizedBox(
                                  width: 15
                                ),
                                Text(
                                    'LOGIN WITH FACEBOOK',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Work-Sans", color: mainColor),
                                  ),
                              ])
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          showSnackBar(
                              'Login with FB', context);
                        },
                      ),
                      SizedBox(
                        height: 15
                      )
                      ,RaisedButton(
                        color: Color(0xffE75A4C),
                        textColor: Colors.white,
                        child: Container(
                            height: 60,
                            child:Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Image.asset("assets/google.png", height: 32,)
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'LOGIN WITH GOOGLE',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Work-Sans", color: Colors.white),
                                  ),
                                ])
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          showSnackBar(
                              'Login with GG', context);
                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

