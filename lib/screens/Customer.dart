import 'package:touchwoodapp/widgets/custom_drawer.dart' as drawer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:touchwoodapp/screens/dashboard.dart' as dashboard;
import 'package:touchwoodapp/screens/AddCustomer.dart' as addcustomer;

import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:touchwoodapp/models/customer.dart';
import 'package:touchwoodapp/models/Paging.dart';
import 'package:touchwoodapp/repository/cutomer_repository.dart';
import 'package:touchwoodapp/screens/AddCustomer.dart' as Addparty;
import 'dart:convert';
import 'package:touchwoodapp/models/Paging.dart';
import 'dart:core';
import 'dart:convert';
import 'dart:io';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:touchwoodapp/repository/cutomer_repository.dart';
import 'package:dio/dio.dart';
import 'package:touchwoodapp/repository/assigncolor.dart';

void main() => runApp(new MaterialApp(
      home: new HomePage(),
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// class HomePage extends StatefulWidget {
//   String selectedType;
//   int pageNo;
//   HomePage(this.selectedType, this.pageNo);

//   String get custid {
//     selectedtype = selectedType;
//     pageno = pageNo;
//   }

//   @override
//   HomePageState createState() => new HomePageState();
// }

  Widget build(BuildContext context) {
    OrientationLayoutBuilder(
      portrait: (context) => dashboard.HomePage('', 10),
      landscape: (context) => dashboard.HomePage('', 10),
    );

    return MaterialApp(
        title: 'Sun Party',
        theme: new ThemeData(
          brightness: Brightness.light,
        ),
        home: Scaffold(
            drawer: drawer.CustomDrawer(),
            body: ScreenTypeLayout.builder(
              mobile: (BuildContext context) => dashboard.HomePage('', 10),
              tablet: (BuildContext context) => dashboard.HomePage('', 10),
              desktop: (BuildContext context) => Container(
                  child: Row(children: [
                Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: dashboard.HomePage('', 10),
                    )),
                Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: addcustomer.AddCustomer(
                        key: null,
                        title: "Add Customer",
                      ),
                    ))
              ])),
              watch: (BuildContext context) => Container(color: Colors.purple),
            )));
  }
}
