import 'package:flutter/material.dart';
import 'package:touchwoodapp/screens/mainpage.dart' as dashboard;
import 'package:touchwoodapp/repository/assigncolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
//import 'dashboard_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};
// void main() => runApp(LoginScreen());

// class LoginScreen extends StatelessWidget {
//   static const BASE_URL = "http://posmmapi.suninfotechnologies.in/api";
//   Duration get loginTime => Duration(milliseconds: 2250);

//   Future<String> _authUser(LoginData data) {
//     print('Name: ${data.name}, Password: ${data.password}');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(data.name)) {
//         return 'Username not exists';
//       }
//       if (users[data.name] != data.password) {
//         return 'Password does not match';
//       }
//       return null;
//     });
//   }

//   Future<String> _recoverPassword(String name) {
//     print('Name: $name');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(name)) {
//         return 'Username not exists';
//       }
//       return null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: 'ECORP',
//       logo: 'assets/images/ecorp-lightblue.png',
//       onLogin: _authUser,
//       onSignup: _authUser,
//       onSubmitAnimationCompleted: () {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => dashboard.MyApp(),
//         ));
//       },
//       onRecoverPassword: _recoverPassword,
//     );
//   }
// }
void main() => runApp(SignInBase());

class MyHome extends StatelessWidget {
  static const BASE_URL = "http://posmmapi.suninfotechnologies.in/api";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
            child: FractionallySizedBox(
          //widthFactor: 0.9,
          heightFactor: 1,
          child: Container(
            //width: MediaQuery.of(context).size.width,5
            margin: EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                var upheight = constraints.maxHeight / 20;
                var maxwidth = constraints.maxWidth;
                return Center(
                    child: Container(
                        color: Colors.white,
                        height: constraints.maxHeight,
                        width: maxwidth,
                        child: Container(
                          color: Colors.white,
                          //  height: 700,
                          //   width: 500,
                          child: Column(
                            children: <Widget>[
                              // SizedBox(
                              //   height:
                              //       (constraints.maxHeight - (upheight * 2)) / 4,
                              // ),
                              Spacer(),
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: 200,
                                  maxWidth: 380,
                                ),
                                //padding: EdgeInsets.,
                                width: maxwidth / 3,
                                //  height:300
                                // height: constraints.maxWidth * 0.,
                                color: Color(0xfff5f5f5),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SFUIDisplay'),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Username',
                                      prefixIcon: Icon(Icons.person_outline),
                                      labelStyle: TextStyle(fontSize: 15)),
                                ),
                              ),
                              SizedBox(
                                height: upheight,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: 200,
                                  maxWidth: 380,
                                ),
                                //padding: EdgeInsets.,
                                width: maxwidth / 3,
                                color: Color(0xfff5f5f5),
                                child: TextFormField(
                                  obscureText: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SFUIDisplay'),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      prefixIcon: Icon(Icons.lock_outline),
                                      labelStyle: TextStyle(fontSize: 15)),
                                ),
                              ),
                              SizedBox(
                                height: upheight,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: 200,
                                  maxWidth: 380,
                                ),
                                //padding: EdgeInsets.,
                                width: maxwidth / 3,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                dashboard.MyApp()));
                                  }, //since this is only a UI app
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'SFUIDisplay',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  color: widgetcolor,
                                  //elevation: 0,
                                  minWidth: 400,
                                  height: 50,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              Spacer(),
                              // SizedBox(
                              //   height:
                              //       (constraints.maxHeight - (upheight * 2)) / 4,
                              // ), //   ),
                            ],
                          ),
                        )));
              },
            ),
          ),
        ))
      ],
    );
  }
}

class SignInBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: appbarcolor,
            // ),
            body: MyHome()));
  }
}
