import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:touchwoodapp/models/Granite.dart';
import 'package:touchwoodapp/models/Paging.dart';
import 'package:touchwoodapp/widgets/custom_drawer.dart' as drawer;
import 'dart:convert';
import 'package:touchwoodapp/models/Paging.dart';
import 'dart:core';
import 'dart:io';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:touchwoodapp/repository/cutomer_repository.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:touchwoodapp/repository/assigncolor.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:touchwoodapp/widgets/custom_drawer.dart' as drawer;
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:touchwoodapp/models/customer.dart' as customer;
import 'package:touchwoodapp/screens/dashboard.dart';
import 'package:dio/dio.dart';
import 'package:touchwoodapp/models/partytype.dart' as type;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:touchwoodapp/models/Master.dart' as Master;

void main() => runApp(new MaterialApp(
      home: new HomePage("10", 1),
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
    ));
PageController controller = PageController();
List<Granite> _reportItems = <Granite>[];
Paging _pagingdetails = new Paging();
List<Granite> data = <Granite>[];
TextEditingController _GotoTextController;

List<Paging> paging = new List<Paging>();
String selectedtype = "10";
String totalCount;
String pageSize;
String currentPage;
String totalPages;
String previousPage;
String nextPage;
int pageno;
FocusNode idFocusNode;
String searchtext;

String selectedgranitecolor;
String selecteduom;
String selectedgroup;
String selectedgranitetype;
String selectedmeasurement;

String custselectedtype;
int custpageno;
String groupid;
String uomid;
String granitecolorid;
String measurementid;

GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<customer.Customer>>();
String _id = "";
TextStyle textStyle = new TextStyle(color: Colors.black);
GlobalKey<AutoCompleteTextFieldState<customer.Customer>> custKey =
    new GlobalKey();
AutoCompleteTextField<customer.Customer> textField;

List<Master.Master> groupdetails = <Master.Master>[];
List<Master.Master> granitetypedetails = <Master.Master>[];
List<Master.Master> measurementdetails = <Master.Master>[];
List<Master.Master> uomdetails = <Master.Master>[];
List<Master.Master> granitecolordetails = <Master.Master>[];
List<String> typedata = [];
List<String> graniteuomdata = [];
List<String> granitecolordata = [];
List<String> granitegroupdata = [];
List<String> granitetypedata = [];
List<String> granitemeasurementdata = [];
final _graniteproductcoceController = TextEditingController();
final _graniteproductnameController = TextEditingController();

ProgressDialog pr;
FocusNode GsmFocusNode;
double maxwidth;
double maxheight;

bool enable = false;

class HomePage extends StatefulWidget {
  String selectedType;
  int pageNo;
  HomePage(this.selectedType, this.pageNo);

  String get custid {
    selectedtype = selectedType;
    pageno = pageNo;
  }

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Widget addGranitewid(double maxwidth, double maxheight) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text(
              'Add Granite',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: appbarcolor,
          centerTitle: true,
        ),
        body: Container(
          height: maxheight,
          width: maxwidth,
          child: Expanded(
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      //flex: 2,
                      child: FractionallySizedBox(
                          widthFactor: 0.9,
                          heightFactor: 1,
                          child: Container(
                              height: maxheight,
                              width: maxwidth,

                              //width: MediaQuery.of(context).size.width,5
                              margin: EdgeInsets.only(top: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(15.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Enter Granite Details",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 300,
                                            ),
                                            width: maxwidth * .7,
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: widgetcolor),
                                                  ),
                                                  border: InputBorder.none,
                                                  //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                  labelText: "Product Code",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller:
                                                  _graniteproductcoceController,
                                              focusNode: GsmFocusNode,

                                              readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 300,
                                            ),
                                            width: maxwidth * .7,
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: widgetcolor),
                                                  ),
                                                  border: InputBorder.none,
                                                  //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                  labelText: "Product Name",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller:
                                                  _graniteproductnameController,
                                              focusNode: GsmFocusNode,

                                              readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
                                          ),
                                          if (granitegroupdata != null &&
                                              granitegroupdata.isNotEmpty)
                                            Container(
                                              constraints: BoxConstraints(
                                                minWidth: 200,
                                                maxWidth: 380,
                                              ),
                                              //padding: EdgeInsets.,
                                              width: maxwidth * .7, //* 0.50,
                                              child: DropdownSearch<String>(
                                                dropDownButton: Image.asset(
                                                    'Images/arrow_drop_down.png',
                                                    color: Colors.white),
                                                validator: (v) => v == null
                                                    ? "required field"
                                                    : null,
                                                hint: "Select a Group",
                                                mode: Mode.MENU,
                                                enabled: (_id != null &&
                                                        _id != '' &&
                                                        _id != '0')
                                                    ? false
                                                    : true,
                                                showSelectedItem: true,
                                                showSearchBox: true,
                                                items: granitegroupdata,
                                                label: "Group *",
                                                showClearButton: false,
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedgroup = val;

                                                    groupid = groupdetails
                                                        .where((element) =>
                                                            element
                                                                .columnname ==
                                                            val)
                                                        .map((e) =>
                                                            e.columnMasterid)
                                                        .first
                                                        .toString();
                                                  });
                                                },
                                                popupItemDisabled: (String s) =>
                                                    s.startsWith('I'),
                                                selectedItem: selectedgroup,
                                              ),
                                            ),
                                          if (graniteuomdata != null &&
                                              graniteuomdata.isNotEmpty)
                                            Container(
                                              constraints: BoxConstraints(
                                                minWidth: 200,
                                                maxWidth: 380,
                                              ),
                                              //padding: EdgeInsets.,
                                              width: maxwidth * .7, //* 0.50,
                                              child: DropdownSearch<String>(
                                                dropDownButton: Image.asset(
                                                    'Images/arrow_drop_down.png',
                                                    color: Colors.white),
                                                validator: (v) => v == null
                                                    ? "required field"
                                                    : null,
                                                hint: "Select a Uom",
                                                mode: Mode.MENU,
                                                enabled: (_id != null &&
                                                        _id != '' &&
                                                        _id != '0')
                                                    ? false
                                                    : true,
                                                showSelectedItem: true,
                                                showSearchBox: true,
                                                items: graniteuomdata,
                                                label: "Uom *",
                                                showClearButton: false,
                                                onChanged: (val) {
                                                  setState(() {
                                                    selecteduom = val;

                                                    uomid = uomdetails
                                                        .where((element) =>
                                                            element
                                                                .columnname ==
                                                            val)
                                                        .map((e) =>
                                                            e.columnMasterid)
                                                        .first
                                                        .toString();
                                                  });
                                                },
                                                popupItemDisabled: (String s) =>
                                                    s.startsWith('I'),
                                                selectedItem: selecteduom,
                                              ),
                                            ),
                                          if (granitecolordata != null &&
                                              granitecolordata.isNotEmpty)
                                            Container(
                                              constraints: BoxConstraints(
                                                minWidth: 200,
                                                maxWidth: 380,
                                              ),
                                              //padding: EdgeInsets.,
                                              width: maxwidth * .7, //* 0.50,
                                              child: DropdownSearch<String>(
                                                dropDownButton: Image.asset(
                                                    'Images/arrow_drop_down.png',
                                                    color: Colors.white),
                                                validator: (v) => v == null
                                                    ? "required field"
                                                    : null,
                                                hint: "Select a Color",
                                                mode: Mode.MENU,
                                                enabled: (_id != null &&
                                                        _id != '' &&
                                                        _id != '0')
                                                    ? false
                                                    : true,
                                                showSelectedItem: true,
                                                showSearchBox: true,
                                                items: granitecolordata,
                                                label: "Color *",
                                                showClearButton: false,
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedgranitecolor = val;

                                                    granitecolorid =
                                                        granitecolordetails
                                                            .where((element) =>
                                                                element
                                                                    .columnname ==
                                                                val)
                                                            .map((e) => e
                                                                .columnMasterid)
                                                            .first
                                                            .toString();
                                                  });
                                                },
                                                popupItemDisabled: (String s) =>
                                                    s.startsWith('I'),
                                                selectedItem:
                                                    selectedgranitecolor,
                                              ),
                                            ),
                                          if (granitetypedata != null &&
                                              granitetypedata.isNotEmpty)
                                            Container(
                                              constraints: BoxConstraints(
                                                minWidth: 200,
                                                maxWidth: 380,
                                              ),
                                              //padding: EdgeInsets.,
                                              width: maxwidth * .7, //* 0.50,
                                              child: DropdownSearch<String>(
                                                dropDownButton: Image.asset(
                                                    'Images/arrow_drop_down.png',
                                                    color: Colors.white),
                                                validator: (v) => v == null
                                                    ? "required field"
                                                    : null,
                                                hint: "Select a Type",
                                                mode: Mode.MENU,
                                                enabled: (_id != null &&
                                                        _id != '' &&
                                                        _id != '0')
                                                    ? false
                                                    : true,
                                                showSelectedItem: true,
                                                showSearchBox: true,
                                                items: granitetypedata,
                                                label: "Type *",
                                                showClearButton: false,
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedgranitetype = val;

                                                    typeid = granitetypedetails
                                                        .where((element) =>
                                                            element
                                                                .columnname ==
                                                            val)
                                                        .map((e) =>
                                                            e.columnMasterid)
                                                        .first
                                                        .toString();
                                                  });
                                                },
                                                popupItemDisabled: (String s) =>
                                                    s.startsWith('I'),
                                                selectedItem:
                                                    selectedgranitetype,
                                              ),
                                            ),
                                          if (granitemeasurementdata != null &&
                                              granitemeasurementdata.isNotEmpty)
                                            Container(
                                              constraints: BoxConstraints(
                                                minWidth: 200,
                                                maxWidth: 380,
                                              ),
                                              //padding: EdgeInsets.,
                                              width: maxwidth * .7, //* 0.50,
                                              child: DropdownSearch<String>(
                                                dropDownButton: Image.asset(
                                                    'Images/arrow_drop_down.png',
                                                    color: Colors.white),
                                                validator: (v) => v == null
                                                    ? "required field"
                                                    : null,
                                                hint: "Select a Measurement",
                                                mode: Mode.MENU,
                                                enabled: (_id != null &&
                                                        _id != '' &&
                                                        _id != '0')
                                                    ? false
                                                    : true,
                                                showSelectedItem: true,
                                                showSearchBox: true,
                                                items: granitemeasurementdata,
                                                label: "Measurement *",
                                                showClearButton: false,
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedmeasurement = val;

                                                    measurementid =
                                                        measurementdetails
                                                            .where((element) =>
                                                                element
                                                                    .columnname ==
                                                                val)
                                                            .map((e) => e
                                                                .columnMasterid)
                                                            .first
                                                            .toString();
                                                  });
                                                },
                                                popupItemDisabled: (String s) =>
                                                    s.startsWith('I'),
                                                selectedItem:
                                                    selectedmeasurement,
                                              ),
                                            ),
                                        ]),
                                  )))))
                ] // )
                ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.tealAccent,
            shape: CircularNotchedRectangle(),
            notchMargin: 6,
            child: Row(children: <Widget>[
              Spacer(),
              SizedBox(
                width: 10,
              ),
              Container(
                child: RaisedButton(
                    onPressed: () async {
                      if ((_id != "") && (_id != null) && (_id != "0")) {
                        setState(() {
                          enable = true;
                        });
                        saveItems();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('Images/save.png', color: Colors.black),
                        SizedBox(width: 10.0),
                        Text(
                          "SAVE",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    color: widgetcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0))),
                padding: EdgeInsets.only(top: 5, bottom: 5),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: RaisedButton(
                    onPressed: () {
                      clearData(context);
                      // saveItems();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('Images/cancel.png', color: Colors.black),
                        SizedBox(width: 10.0),
                        Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    color: widgetcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0))),
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
              )
            ])));
  }

  void saveItems() async {
    String custGstin = _graniteproductcoceController.text;
    if (_id != '') {
      //   pr.show();

      try {
        Stream<String> stream = await insertCustomer(
            'custId',
            'custName',
            'custMobile',
            'custAdd1',
            'custAdd2',
            'custAdd3',
            'custAdd4',
            'custGstin',
            'custemail',
            "",
            "selectedgranitetype",
            typeid);
        stream.listen((String message) {
          if (message.contains("""[{"RESULT":1}]""") ||
              message.contains("""[{"RESULT":2}]""")) {
            Alert(
                context: context,
                title: "Done!",
                desc: "Data saved successfully",
                type: AlertType.success,
                style: AlertStyle(isCloseButton: false),
                buttons: [
                  DialogButton(
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      // clearData(context);
                      //    pr.dismiss();
                      Navigator.of(context, rootNavigator: true).pop();
                      getCustomerJson();
                      clearData(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             HomePage(custselectedtype, custpageno)));

                      //    pr.dismiss();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                      // // pr.dismiss();
//pr.hide();
                    },
                    width: 120,
                  )
                ]).show();
          } else {
            Alert(
                    context: context,
                    type: AlertType.error,
                    title: "Error",
                    desc: "Error during the Save. Please try again.",
                    style: AlertStyle(isCloseButton: false))
                .show();
          }
        });
      } on Exception catch (_) {
        //  pr.dismiss();
      }
      //   pr.dismiss();
      // clearData(context);
    } else {
      Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: "Enter Customer ID and Name",
              style: AlertStyle(isCloseButton: false))
          .show();
    }
  }

  void clearData(context) {
    _graniteproductcoceController.text = '0';
    _id = '0';
  }

  List<Granite> data = new List<Granite>();

  Future<List<Master.Master>> getgroupmaster(String filter) async {
    setState(() {
      groupdetails = [];
      granitegroupdata = [];
      //  getitems = [];
    });

    final String customerurl =
        "http://posmmapi.suninfotechnologies.in/api/partytype?&intflag=4";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      groupdetails = parsed
          .map<Master.Master>((json) => Master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        groupdetails = groupdetails
            .where((element) =>
                element.columnname
                    .toLowerCase()
                    .toString()
                    .contains(filter.toLowerCase().toString()) &&
                element.tablename == 'group')
            .toList();

      granitegroupdata = groupdetails.map((e) => e.columnname).toList();
      if (groupid == '' || groupid == null || groupid == '0')
        selectedgroup = granitegroupdata.first;

      groupid = groupdetails
          .where((element) => element.columnname == selectedgroup)
          .map((e) => e.columnMasterid)
          .first
          .toString();
    });

    return typedetails;
  }

  Future<List<Master.Master>> getuomdetails(String filter) async {
    setState(() {
      uomdetails = [];
      graniteuomdata = [];
      //  getitems = [];
    });

    final String customerurl =
        "http://posmmapi.suninfotechnologies.in/api/partytype?&intflag=4";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      uomdetails = parsed
          .map<Master.Master>((json) => Master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        uomdetails = uomdetails
            .where((element) =>
                element.columnname
                    .toLowerCase()
                    .toString()
                    .contains(filter.toLowerCase().toString()) &&
                element.tablename == 'uom')
            .toList();

      graniteuomdata = uomdetails.map((e) => e.columnname).toList();
      if (uomid == '' || uomid == null || uomid == '0')
        selecteduom = graniteuomdata.first;

      uomid = uomdetails
          .where((element) => element.columnname == selecteduom)
          .map((e) => e.columnMasterid)
          .first
          .toString();
    });

    return uomdetails;
  }

  Future<List<Master.Master>> getgranitecolormaster(String filter) async {
    setState(() {
      granitecolordetails = [];
      granitecolordata = [];
      //  getitems = [];
    });

    final String customerurl =
        "http://posmmapi.suninfotechnologies.in/api/partytype?&intflag=4";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      granitecolordetails = parsed
          .map<Master.Master>((json) => Master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        granitecolordetails = granitecolordetails
            .where((element) =>
                element.columnname
                    .toLowerCase()
                    .toString()
                    .contains(filter.toLowerCase().toString()) &&
                element.tablename == 'granite color')
            .toList();

      granitecolordata = granitecolordetails.map((e) => e.columnname).toList();
      if (granitecolorid == '' ||
          granitecolorid == null ||
          granitecolorid == '0') selectedgranitecolor = granitecolordata.first;

      granitecolorid = granitecolordetails
          .where((element) => element.columnname == selectedgranitecolor)
          .map((e) => e.columnMasterid)
          .first
          .toString();
    });

    return granitecolordetails;
  }

  Future<List<Master.Master>> getgranitetypemaster(String filter) async {
    setState(() {
      granitetypedetails = [];
      granitetypedata = [];
      //  getitems = [];
    });

    final String customerurl =
        "http://posmmapi.suninfotechnologies.in/api/partytype?&intflag=4";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      granitetypedetails = parsed
          .map<Master.Master>((json) => Master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        granitetypedetails = granitetypedetails
            .where((element) =>
                element.columnname
                    .toLowerCase()
                    .toString()
                    .contains(filter.toLowerCase().toString()) &&
                element.tablename == 'type')
            .toList();

      granitetypedata = granitetypedetails.map((e) => e.columnname).toList();
      if (typeid == '' || typeid == null || typeid == '0')
        selectedgranitetype = granitetypedata.first;

      typeid = granitetypedetails
          .where((element) => element.columnname == selectedgranitetype)
          .map((e) => e.columnMasterid)
          .first
          .toString();
    });

    return granitetypedetails;
  }

  Future<List<Master.Master>> getgranitemeasurementmaster(String filter) async {
    setState(() {
      measurementdetails = [];
      granitemeasurementdata = [];
      //  getitems = [];
    });

    final String customerurl =
        "http://posmmapi.suninfotechnologies.in/api/partytype?&intflag=4";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      measurementdetails = parsed
          .map<Master.Master>((json) => Master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        measurementdetails = measurementdetails
            .where((element) =>
                element.columnname
                    .toLowerCase()
                    .toString()
                    .contains(filter.toLowerCase().toString()) &&
                element.tablename == 'type')
            .toList();

      granitemeasurementdata =
          measurementdetails.map((e) => e.columnname).toList();
      if (typeid == '' || typeid == null || typeid == '0')
        selectedmeasurement = granitemeasurementdata.first;

      measurementid = measurementdetails
          .where((element) => element.columnname == selectedmeasurement)
          .map((e) => e.columnMasterid)
          .first
          .toString();
    });

    return measurementdetails;
  }

  Future<customer.Customer> getAddCustomerJson() async {
    String customerurl;

    if (searchtext == '' || searchtext == null) {
      customerurl =
          'http://posmmapi.suninfotechnologies.in/api/partymaster?&intflag=4&pagesize=' +
              custselectedtype +
              '&pagenumber=' +
              custpageno.toString();
    } else {
      customerurl =
          'http://posmmapi.suninfotechnologies.in/api/partymaster?&intflag=4&pagesize=' +
              custselectedtype +
              '&pagenumber=' +
              custpageno.toString() +
              '&strPartyname=' +
              searchtext;
    }

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    List<Granite> _granitedetails = new List<Granite>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    _granitedetails =
        parsed.map<Granite>((json) => Granite.fromJSON(json)).toList();
    data = _granitedetails;
    if (_id != "" && _id != "" && _id != null)
      _granitedetails
          .where((element) => element.masterid == _id)
          .forEach((element) => setState(() {
                selecteduom = element.uom;
                selectedgroup = element.group;
                selectedgranitecolor = element.color;
                selectedmeasurement = element.measurement;
                selectedgranitetype = element.type;
                _graniteproductcoceController.text =
                    element.productcode.toString();

                _graniteproductnameController.text =
                    element.productname.toString();
                groupid = element.groupid;
                uomid = element.uomid;
                typeid = element.typeid;
                measurementid = element.measurementid;
                granitecolorid = element.colorid;
              }));
  }

  @override
  void initState() {
    idFocusNode = FocusNode();
    setState(() {
      _load = true;
    });
    //getPagingDetails();
    searchtext = '';
    getCustomerJson();
    GsmFocusNode = FocusNode();
    //_custIdController.text = '0';
    getgroupmaster("");
    getuomdetails("");
    getgranitecolormaster("");
    getgranitemeasurementmaster("");
    getgranitetypemaster("");

    setState(() {
      getAddCustomerJson();
      // if ((_id != "") && (_id != null) && (_id != "0"))
      //   _custIdController.text = _id.toString();
    });

    super.initState();
  }

  PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  void dispose() {
    _graniteproductcoceController.dispose();
    GsmFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  bool _load = false;
  NotchedShape shape;

  Widget build(BuildContext context) {
    MediaQueryData queryData;
    print(widget.pageNo);
    queryData = MediaQuery.of(context);

    UnderlineInputBorder underlineInputBorder =
        new UnderlineInputBorder(borderSide: BorderSide(color: widgetcolor));
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

    Widget loadingIndicator = _load
        ? new Container(
            color: Colors.transparent,
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : new Container();

    Widget appbarwid() {
      return AppBar(
        backgroundColor: appbarcolor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                'images/menu.png',
                color: widgetcolor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        automaticallyImplyLeading: false,
        title: TextField(
            style: TextStyle(fontSize: 15),
            //focusNode: false,

            decoration: InputDecoration(
              hintText: "Search...",
              suffixIcon: IconButton(
                  icon: Image.asset('Images/search.png', color: widgetcolor),
                  onPressed: () {
                    getCustomerJson();
                    setState(() {
                      pageno = 1;
                    });
                  }),
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                searchtext = value;
                pageno = 1;
                getCustomerJson();
                //data = _reportItems;
                // _reportItems = (data
                //     .where((element) => element.customerName
                //         .toLowerCase()
                //         .contains(value.toLowerCase()))
                //     .toList());
                // if (value == "") _reportItems = data;
              });
              // _reportItems = data;
            }),
        // centerTitle: true,
      );

      // AppBar(
      //   //  titleSpacing: 0.2,
      //   leading: Builder(
      //     builder: (BuildContext context) {
      //       return IconButton(
      //         icon: Image.asset(
      //           'images/menu.png',
      //           color: widgetcolor,
      //         ),
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //         tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //       );
      //     },
      //   ),
      //   automaticallyImplyLeading: false,
      //   title: Padding(
      //     padding: EdgeInsets.only(
      //       bottom: 30,
      //     ),
      //     child: Text(
      //       'Customer Details',
      //       style: TextStyle(color: Colors.black),
      //     ),
      //   ),
      //   backgroundColor: appbarcolor,
      //   centerTitle: true,
      // );
    }

    Widget bodywid(double maxwidth, double maxheight) {
      return
          //Stack(children: <Widget>[
          new SizedBox(
        width: maxwidth, // * .40,
        height: maxheight,
        child: ListView(children: <Widget>[
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     SizedBox(
          //       width: maxwidth * .20,
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),

          // Flexible(
          //   flex: 1,
          //   child:
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    //  width: maxwidth * .10,
                    child: Text("Product Code",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    // width: maxwidth * .10,
                    child: Text("Product NAme",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    // width: maxwidth * .10,
                    child: Text("Group",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    // width: maxwidth * .10,
                    child: Text("Type",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    // width: maxwidth * .10,
                    child: Text("Action",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  // Card(
                  //   // child:
                  //   //  Padding(
                  //   //   padding: const EdgeInsets.all(8.0),
                  //   child:
                  //       // Row(
                  //       //   children: <Widget>[
                  //       Container(
                  //           child: Row(
                  //     children: [
                  //       Container(
                  //         width: maxwidth * .10,
                  //         child: Text("Type",
                  //             textScaleFactor: 1.5,
                  //             textAlign: TextAlign.left,
                  //             style: new TextStyle(
                  //               color: widgetcolor,
                  //             )),
                  //       ),
                  //       Container(
                  //         width: maxwidth * .10,
                  //         child: Text("Name",
                  //             textScaleFactor: 1.5,
                  //             textAlign: TextAlign.left,
                  //             style: new TextStyle(
                  //               color: widgetcolor,
                  //             )),
                  //       ),
                  //       // SizedBox(
                  //       //   width: 90,
                  //       // ),
                  //       Container(
                  //         width: maxwidth * .10,
                  //         child: Text("Action",
                  //             textScaleFactor: 1.5,
                  //             textAlign: TextAlign.left,
                  //             style: new TextStyle(
                  //               color: widgetcolor,
                  //             )),
                  //       )
                  //     ],
                  //   )),
                  //   //   ],
                  //   // ),
                  //   //),
                  // ),
                  // //  ),
                ]),
          )),
          //  ),
          Container(
            width: maxwidth,
            height: maxheight,
            child: PageView(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              children: tableView(maxwidth, maxheight),

              //children: tableView(),
              onPageChanged: (index) {
                setState(() {
                  pageno = (index == 0 ? 1 : index);
                  getCustomerJson();
                });
              },
            ),
          ),
        ]),
      );
      //),
      // new Align(
      //   child: loadingIndicator,
      //   alignment: FractionalOffset.center,
      // ),
      //    ]);
      // });
    }

    @override
    Widget bottomapp(double width, double height) {
      return BottomAppBar(
              color: appbarcolor,
              //    titleSpacing: 0.0,
              //elevation: 5.0,
              //  backgroundColor: Color(0xff201F23),
              // title:
              shape: CircularNotchedRectangle(),
              notchMargin: 6,
              //  color: Colors.blue,

              child: Row(children: <Widget>[
                // Spacer(),
                SizedBox(
                    width: width / 10,
                    child: IconButton(
                      icon:
                          Image.asset('Images/search.png', color: widgetcolor),
                      onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) => Container(
                                height: height * .20,
                                child: TextField(
                                    focusNode: idFocusNode,
                                    style: TextStyle(fontSize: 15),
                                    decoration:
                                        InputDecoration(hintText: "GO TO"),
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      if (int.parse(value) <=
                                          int.parse(totalPages)) {
                                        setState(() {
                                          pageno = int.parse(value);
                                          getCustomerJson();
                                          _controller.animateToPage(
                                            pageno,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.linear,
                                          );
                                        });
                                      }
                                    }),
                              )),
                    )),
                // ),
                Text('Rows/Page',
                    style: TextStyle(
                      fontSize: 11,
                    )),
                SizedBox(
                  width: 20,
                ),
                if (selectedtype != null)
                  SizedBox(
//width: width * .50,
                    child: DropdownButton<String>(
                        value: selectedtype,
                        icon: Image.asset('Images/arrow_drop_down.png',
                            color: Colors.white),
                        //iconSize: 10,
                        hint: SizedBox(
                            //  width: width * .20,
                            child: Text('Rows Per Page')),
                        items: ['5', '7', '10', '20', '30', '40', '50']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              //  width: width * .60,
                              child: new Text(
                                value,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedtype = (value);
                            //    getPagingDetails();
                            getCustomerJson();
                          });
                        }),
                  ),
                //SizedBox(width: 10),
                // // Text('No : ' + (pageno == 0 ? 1 : pageno).toString(),
                // //     style: TextStyle(
                // //       fontSize: 12,
                // //     )),
                SizedBox(
                  width: width / 40,
                ),
                new IconButton(
                  icon:
                      Image.asset('Images/Arrow-Left.png', color: widgetcolor),
                  iconSize: 20,
                  color: Colors.blue,
                  splashColor: Colors.green,
                  onPressed: () {
                    setState(() {
                      if ((pageno != 1) && (pageno != 0)) pageno = pageno - 1;
                      getCustomerJson();
                      _controller.animateToPage(
                        pageno,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    });
                  },
                ),
                //    Spacer(),
                Text(((pageno == 0) ? 1 : pageno).toString() +
                    '  of  ' +
                    (totalPages != 'null' ? totalPages : '1').toString()),
                // Spacer(),
                new IconButton(
                  icon:
                      Image.asset('Images/Arrow-Right.png', color: widgetcolor),
                  iconSize: 20,
                  color: Colors.blue,
                  splashColor: Colors.green,
                  onPressed: () {
                    setState(() {
                      if ((pageno < int.parse(totalPages))) pageno = pageno + 1;
                      getCustomerJson();
                      _controller.animateToPage(
                        pageno,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    });
                  },
                ),
                //  Spacer(),
              ]))
          //   ]),
          ;
    }

    return MaterialApp(
        title: 'Sun Party',
        theme: new ThemeData(
          brightness: Brightness.light,
        ),
        home: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          var maxwidth = constraints.maxWidth;
          var minwidth = constraints.minWidth;
          var maxheight = constraints.maxHeight;
          var minheight = constraints.minHeight;

          return ScreenTypeLayout.builder(
            mobile: (BuildContext context) => Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndDocked,
              floatingActionButton: FloatingActionButton(
                backgroundColor: widgetcolor,
                onPressed: () {},
                tooltip: 'Add new customer entry',
                child: IconButton(
                    icon: Image.asset('images/add.png', color: Colors.black),
                    onPressed: () {
                      setState(() {
                        _id = '0';
                        custpageno = pageno;
                        custselectedtype = selectedtype;
                        getAddCustomerJson();
                        getgroupmaster("");
                        getuomdetails("");
                        getgranitecolormaster("");
                        getgranitemeasurementmaster("");
                        getgranitetypemaster("");

                        //setState(() {
                        //   getCustomerJson();
                        // if ((_id != "") && (_id != null) && (_id != "0"))
                        //_custIdController.text = _id.toString();
                      });
                    }),
              ),
              drawer: drawer.CustomDrawer(),
              appBar: appbarwid(),
              bottomNavigationBar: bottomapp(maxwidth, maxheight),
              body: bodywid(maxwidth, maxheight),
            ),
            //    tablet: (BuildContext context) => dashboardscaffold(),
            desktop: (BuildContext context) => Container(
                width: maxwidth,
                height: maxheight,
                child: Row(children: [
                  Expanded(
                      flex: 3,
                      child: Scaffold(
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.miniEndDocked,
                        floatingActionButton: FloatingActionButton(
                          backgroundColor: widgetcolor,
                          onPressed: () {},
                          tooltip: 'Add new customer entry',
                          child: IconButton(
                              icon: Image.asset('images/add.png',
                                  color: Colors.black),
                              onPressed: () {
                                setState(() {
                                  _id = '0';
                                  custpageno = pageno;
                                  custselectedtype = selectedtype;
                                  getAddCustomerJson();
                                  getgroupmaster("");
                                  getuomdetails("");
                                  getgranitemeasurementmaster("");
                                  getgranitetypemaster("");

                                  getgranitecolormaster("");
                                  //setState(() {
                                  //   getCustomerJson();
                                  // if ((_id != "") &&
                                  //     (_id != null) &&
                                  //     (_id != "0"))
                                  //   _custIdController.text = _id.toString();
                                });
                              }),
                        ),
                        drawer: drawer.CustomDrawer(),
                        appBar: appbarwid(),
                        bottomNavigationBar: bottomapp(maxwidth, maxheight),
                        body: bodywid(maxwidth, maxheight),
                      )),
                  SizedBox(
                      width: 5,
                      child: Container(
                        color: appbarcolor,
                      )),
                  Expanded(
                    flex: 2,
                    child: addGranitewid(maxwidth, maxheight),
                    // LayoutBuilder(
                    //     builder: (context, BoxConstraints constraints) {
                    //   var maxwidth = constraints.maxWidth;
                    //   var minwidth = constraints.minWidth;
                    //   var maxheight = constraints.maxHeight;
                    //   var minheight = constraints.minHeight;
                    //   return Container(
                    //     child: addcustomer(context, maxheight, maxwidth),
                    //   );
                    // })
                  )
                ])),

            // Scaffold(
            //   drawer: drawer.CustomDrawer(),
            //   appBar: appbarwid(),
            //   bottomNavigationBar: Container(
            //       width: maxwidth,
            //       // height: maxheight,
            //       child: Row(children: [
            //         Expanded(
            //           flex: 3,
            //           // child: SingleChildScrollView(
            //           child: bottomapp(maxwidth, maxheight),
            //           //)
            //         ),
            //         Expanded(flex: 2, child: Text('test'))
            //       ])),
            //   body: Container(
            //       width: maxwidth,
            //       heght: maxheight,
            //       child: Row(children: [
            //         Expanded(
            //             flex: 3,
            //             child: SingleChildScrollView(
            //               child: bodywid(maxwidth, maxheight),
            //             )),
            //         Expanded(
            //             flex: 2,
            //             child: SingleChildScrollView(
            //                 child: Addparty.AddCustomer(
            //               key: null,
            //               title: "Add Customer",
            //             )))
            //       ])),
            // ),
            watch: (BuildContext context) => Container(color: Colors.purple),
          );

          // Scaffold(
          //     floatingActionButtonLocation:
          //         FloatingActionButtonLocation.miniEndDocked,
          //     floatingActionButton: FloatingActionButton(
          //       backgroundColor: widgetcolor,
          //       onPressed: () {},
          //       tooltip: 'Add new weight entry',
          //       child: IconButton(
          //           icon: Image.asset('images/add.png', color: Colors.black),
          //           onPressed: () {
          //             Addparty.AddCustomer ad = new Addparty.AddCustomer();
          //             ad.id = '0';
          //             ad.pageNo = pageno;
          //             ad.selectedType = selectedtype;

          //             ad.custid;
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => Addparty.AddCustomer(
          //                           key: null,
          //                           title: "Add Customer",
          //                         )));
          //           }),
          //     ),
          //   //  bottomNavigationBar:
          //     //})
          //     //]),

          //     body: // Text('')
          //         LayoutBuilder(builder: (context, BoxConstraints constraints) {
          //       var maxwidth = constraints.maxWidth;
          //       var minwidth = constraints.minWidth;
          //       var maxheight = constraints.maxHeight;
          //       var minheight = constraints.minHeight;
          //       return ScreenTypeLayout.builder(
          //         mobile: (BuildContext context) => bodywid(),
          //         tablet: (BuildContext context) => bodywid(),
          //         desktop: (BuildContext context) => Container(
          //             child: Row(children: [
          //           Expanded(
          //               flex: 3,
          //               child: SingleChildScrollView(
          //                 child: bodywid(),
          //               )),
          //           Expanded(
          //               flex: 1,
          //               child: SingleChildScrollView(child: Text('test')
          //                   // child: Addparty.AddCustomer(
          //                   //   key: null,
          //                   //   title: "Add Customer",
          //                   // ),
          //                   ))
          //         ])),
          //         watch: (BuildContext context) =>
          //             Container(color: Colors.purple),
          //       );
          //     }));
        })); //);
  }

  List<Granite> _customers;
  Future<String> getCustomerJson() async {
    if (this.mounted) {
      setState(() {
        _reportItems = [];
        _pagingdetails = null;
        totalPages = null;
      });
      //selectedtype = totalCount != null ? totalCount : selectedtype;
      //  }
      String customerurl;

      if (searchtext == null || searchtext == '') {
        customerurl =
            "https://cors-anywhere.herokuapp.com/http://posmmapi.suninfotechnologies.in/api/partymaster?&intflag=4&pagesize=" +
                (selectedtype).toString() +
                "&pagenumber=" +
                ((pageno.toString() != 'null' &&
                        pageno.toString() != '' &&
                        pageno.toString() != '0')
                    ? pageno.toString()
                    : '1');
      } else {
        customerurl =
            "https://cors-anywhere.herokuapp.com/http://posmmapi.suninfotechnologies.in/api/partymaster?&intflag=4&pagesize=" +
                (selectedtype).toString() +
                "&pagenumber=" +
                ((pageno.toString() != 'null' &&
                        pageno.toString() != '' &&
                        pageno.toString() != '0')
                    ? pageno.toString()
                    : '1') +
                '&strPartyname=' +
                searchtext;
      }

      var response = await http.get(Uri.encodeFull(customerurl),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200 || response.statusCode == 201) {
        var convertDataToJson;
        convertDataToJson = json.decode(response.headers['paging-headers']);

        final paparsed = convertDataToJson.cast<String, dynamic>();
        if (this.mounted) {
          setState(() {
            totalCount = paparsed['totalCount'].toString();
            pageSize = paparsed['pageSize'].toString();
            currentPage = paparsed['currentPage'].toString();
            totalPages = paparsed['totalPages'].toString();
            previousPage = paparsed['previousPage'].toString();
            nextPage = paparsed['nextPage'].toString();
          });
        }
      }
      //response.setHeader("Access-Control-Expose-Headers", "*");

      var convertDataToJson;

      convertDataToJson = json.decode(response.body);
      final parsed = convertDataToJson.cast<Map<String, dynamic>>();
      _reportItems =
          parsed.map<Granite>((json) => Granite.fromJSON(json)).toList();

      data = _reportItems;
    }
    return "customer";
  }

  List<Widget> tableView(double maxwidth, double maxheight) {
    /// getPagingDetails();
    List<Widget> widgets = <Widget>[];
    //  totalPages = "14";
    if (totalPages != null) {
      // setState(() {
      //   _load = false;
      // });
      for (int i = 0; i < int.parse(totalPages); i++) {
        if (_reportItems.length > 0) {
          widgets.add(SizedBox(
            height: maxheight,
            width: maxwidth,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _reportItems.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    width: maxwidth,
                    height: 50,
                    child: Card(
                      child:
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child:
                          Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _reportItems[index]
                                  .productcode
                                  .toLowerCase()
                                  .toString(),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            //width: maxwidth * .20,
                            child: Text(
                              _reportItems[index]
                                  .productname
                                  .toLowerCase()
                                  .toString(),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            //width: maxwidth * .20,
                            child: Text(
                              _reportItems[index]
                                  .group
                                  .toLowerCase()
                                  .toString(),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            //width: maxwidth * .20,
                            child: Text(
                              _reportItems[index].type.toLowerCase().toString(),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          //SizedBox(width: 90),
                          Expanded(
                              //width: maxwidth * .20,
                              child: Row(children: [
                            new IconButton(
                              icon: Image.asset('Images/edit.png',
                                  color: widgetcolor),
                              onPressed: () {
                                setState(() {
                                  String id = _reportItems[index].masterid;
                                  _id = id;
                                  custselectedtype = selectedtype;
                                  custpageno = pageno;
                                  getAddCustomerJson();
                                  getgroupmaster("");
                                  getuomdetails("");
                                  getgranitecolormaster("");
                                  getgranitemeasurementmaster("");
                                  getgranitetypemaster("");

                                  //setState(() {
                                  //   getCustomerJson();
                                  // if ((_id != "") &&
                                  //     (_id != null) &&
                                  //     (_id != "0"))
                                  //   _custIdController.text = _id.toString();

                                  /// });
                                });

                                // ad.custid;
                                // if (id != '0' || id != null)
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               Addparty.AddCustomer(
                                //                 key: null,
                                //                 title: "Add Customer",
                                //                 searchtext: searchtext,
                                //               )));
                                //
                              },
                              highlightColor: Colors.pink,
                            ),
                            SizedBox(width: 1),
                            // Spacer(),
                            new IconButton(
                              icon: Image.asset('Images/delete.png',
                                  color: widgetcolor),
                              onPressed: () async {
                                String id = _reportItems[index].masterid;

                                _id = id;

                                if (id != '0' || id != null) {
                                  bool yesflag = false;

                                  Alert(
                                      context: context,
                                      title: "Done!",
                                      desc: "Do you want to Delete it?",
                                      type: AlertType.success,
                                      style: AlertStyle(isCloseButton: false),
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () async {
                                            yesflag = true;

                                            if (yesflag) {
                                              Stream<String> stream =
                                                  await insertCustomer(
                                                      id,
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "1",
                                                      "",
                                                      "");
                                              stream.listen((String message) {
                                                if (message.contains(
                                                        """[{"RESULT":1}]""") ||
                                                    message.contains(
                                                        """[{"RESULT":2}]""")) {
                                                  Alert(
                                                      context: context,
                                                      title: "Done!",
                                                      desc:
                                                          "Data Deleted successfully",
                                                      type: AlertType.success,
                                                      style: AlertStyle(
                                                          isCloseButton: false),
                                                      buttons: [
                                                        DialogButton(
                                                          child: Text(
                                                            "Close",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                          onPressed: () {
                                                            getCustomerJson();
                                                            // Navigator.push(
                                                            //     context,
                                                            //     MaterialPageRoute(
                                                            //         builder:
                                                            //             (context) =>
                                                            //                 HomePage()));
                                                          },
                                                          width: 120,
                                                        )
                                                      ]).show();
                                                } else {
                                                  Alert(
                                                          context: context,
                                                          type: AlertType.error,
                                                          title: "Error",
                                                          desc:
                                                              "Error during delete. Please try again.",
                                                          style: AlertStyle(
                                                              isCloseButton:
                                                                  false))
                                                      .show();
                                                }
                                              });
                                            }
                                            //   getPagingDetails();
                                            getCustomerJson();
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          width: 120,
                                        ),
                                        DialogButton(
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () {
                                            yesflag = false;
                                            Navigator.pop(context);
                                          },
                                          width: 120,
                                        )
                                      ]).show();
                                }
                                //
                              },
                              highlightColor: Colors.pink,
                            ),
                          ]))
                          //   ],
                          // )),
                        ],
                      ), //,
                      //),
                    ),
                  );
                }),

            // SingleChildScrollView(
          ));
          //  return widgets;
        } else {
          //   return null;
        }
      }
    } else {
      // return null;
    }
    return widgets;
  }
}
