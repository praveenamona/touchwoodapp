import 'package:flutter/material.dart';
import 'package:touchwoodapp/screens/dashboard.dart' as dashboard;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const BASE_URL = "http://posmmapi.suninfotechnologies.in/api";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "SunInfo Tech",
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
          //scaffoldBackgroundColor: Colors.blueGrey,
        ),
        home: dashboard.HomePage('10', 1),
        routes: {
          '/Dashboard': (context) => dashboard.HomePage('10', 1),
        },
        debugShowCheckedModeBanner: false);
  }
}
