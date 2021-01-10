import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:touchwoodapp/models/Master.dart';
import 'package:touchwoodapp/models/customer.dart';
import 'package:touchwoodapp/models/Paging.dart';
import 'package:touchwoodapp/widgets/collapsing_navigation_drawer_widget.dart'
    as drawer;
import 'package:touchwoodapp/models/partytype.dart' as type;
import 'package:touchwoodapp/repository/cutomer_repository.dart';

import 'dart:convert';
import 'package:touchwoodapp/models/Paging.dart';
import 'dart:core';
import 'dart:convert';
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

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:touchwoodapp/models/customer.dart' as customer;
import 'package:touchwoodapp/screens/Supplierdashboard.dart';
import 'package:dio/dio.dart';
import 'package:touchwoodapp/models/partytype.dart' as type;
import 'package:dropdown_search/dropdown_search.dart';

void main() => runApp(new MaterialApp(
      home: new HomePage("10", 1),
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
    ));
PageController controller = PageController();
List<type.Customer> partytypedetails = <type.Customer>[];
List<Customer> _reportItems = <Customer>[];
Paging _pagingdetails = new Paging();
List<Customer> data = <Customer>[];
TextEditingController _GotoTextController;
bool ShowAddWidget = false;
List<Paging> paging = new List<Paging>();
String selectedtype = "10";
List<String> partytypedata = [];
String selectedcompany;
String totalCount;
String pageSize;
String currentPage;
String totalPages;
String previousPage;
String nextPage;
int pageno;
FocusNode idFocusNode;
String searchtext;
String appbartitle = 'Customer';

String partytypeid;

String selectedpartytype;
String custselectedtype;
int custpageno;
String typeid;
GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<customer.Customer>>();
String _id = "";
TextStyle textStyle = new TextStyle(color: Colors.black);
GlobalKey<AutoCompleteTextFieldState<customer.Customer>> custKey =
    new GlobalKey();
AutoCompleteTextField<customer.Customer> textField;
List<Master> typedetails = <Master>[];
List<String> typedata = [];
final _custNameController = TextEditingController();
final _custIdController = TextEditingController();
final _custemailController = TextEditingController();
final _custcountryController = TextEditingController();
final _custAdd1Controller = TextEditingController();
final _custAdd2Controller = TextEditingController();
final _custAdd3Controller = TextEditingController();
final _custcontactpersonController = TextEditingController();
final _custcontactnumberController = TextEditingController();
final _custswiftcodeontroller = TextEditingController();
final _custtaxcodeController = TextEditingController();
final _custremarksController = TextEditingController();
ProgressDialog pr;
FocusNode custidFocusNode;
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
  Widget addcustomerwid(double maxwidth, double maxheight) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text(
              appbartitle.toString(),
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
                                          // Text(
                                          //   "Enter Customer Details",
                                          //   style: TextStyle(fontSize: 16),
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (partytypedata != null &&
                                              partytypedata.isNotEmpty)
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
                                                items: partytypedata,
                                                label: "Type *",
                                                showClearButton: false,
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedpartytype = val;
                                                    appbartitle = val;
                                                    partytypeid = partytypedetails
                                                        .where((element) =>
                                                            element.ptyname ==
                                                            val)
                                                        .map((e) => e.partyid)
                                                        .first
                                                        .toString();

                                                    getCustomerJson();
                                                  });
                                                },
                                                popupItemDisabled: (String s) =>
                                                    s.startsWith('I'),
                                                selectedItem: selectedpartytype,
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
                                                  labelText: "Name",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller: _custNameController,
                                              focusNode: custidFocusNode,

                                              readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
                                          ),
                                          // ]),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 380,
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
                                                  labelText: "Add1",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller: _custAdd1Controller,
                                              // focusNode: custidFocusNode,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 380,
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
                                                  labelText: "Add2",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),

                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller: _custAdd2Controller,
                                              //  focusNode: custidFocusNode,
                                            ),
                                          ),

                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 380,
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
                                                  labelText: "Add3",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),

                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller: _custAdd3Controller,
                                              //  focusNode: custidFocusNode,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 380,
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
                                                  labelText: "Contact Person",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller:
                                                  _custcontactpersonController,
                                              //focusNode: custidFocusNode,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 380,
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
                                                  labelText: "Contact Number",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),

                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller:
                                                  _custcontactnumberController,
                                              // focusNode: custidFocusNode,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //  minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 300,
                                              //maxHeight: double.infinity
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
                                                  labelText: "Email",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType:
                                                  TextInputType.number,
                                              style: textStyle,
                                              controller: _custemailController,
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
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
                                                  labelText: "TaxCode",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),

                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller:
                                                  _custtaxcodeController,
                                              // focusNode: custidFocusNode,
                                            ),
                                          ),
                                          // Container(
                                          //   constraints: BoxConstraints(
                                          //     //minHeight: 20,
                                          //     minWidth: 300,
                                          //     maxWidth: 380,
                                          //     //maxHeight: double.infinity
                                          //   ),
                                          //   width: maxwidth * .7,
                                          //   child: TextField(
                                          //     decoration: const InputDecoration(
                                          //         focusedBorder:
                                          //             UnderlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: widgetcolor),
                                          //         ),
                                          //         border: InputBorder.none,
                                          //         labelText: "Account Number",
                                          //         labelStyle: TextStyle(
                                          //             fontSize: 20.0)),

                                          //     keyboardType: TextInputType.text,
                                          //     style: textStyle,
                                          //     controller: _custAcnoController,
                                          //     //focusNode: custidFocusNode,
                                          //   ),
                                          // ),
                                          // Container(
                                          //   constraints: BoxConstraints(
                                          //     //  minHeight: 20,
                                          //     minWidth: 300,
                                          //     maxWidth: 700,
                                          //   ),
                                          //   width: maxwidth * .8,
                                          //   child: TextField(
                                          //     decoration: const InputDecoration(
                                          //         focusedBorder:
                                          //             UnderlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: widgetcolor),
                                          //         ),
                                          //         border: InputBorder.none,
                                          //         labelText: "Name of Bank",
                                          //         labelStyle: TextStyle(
                                          //             fontSize: 20.0)),
                                          //     keyboardType: TextInputType.text,
                                          //     style: textStyle,
                                          //     controller:
                                          //         _custcountryController,
                                          //   ),
                                          // ),
                                          // Container(
                                          //   constraints: BoxConstraints(
                                          //     //  minHeight: 20,
                                          //     minWidth: 300,
                                          //     maxWidth: 700,
                                          //   ),
                                          //   width: maxwidth * .8,
                                          //   child: TextField(
                                          //     decoration: const InputDecoration(
                                          //         focusedBorder:
                                          //             UnderlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: widgetcolor),
                                          //         ),
                                          //         border: InputBorder.none,
                                          //         labelText: "Branch",
                                          //         labelStyle: TextStyle(
                                          //             fontSize: 20.0)),
                                          //     keyboardType: TextInputType.text,
                                          //     style: textStyle,
                                          //     controller:
                                          //         _custcountryController,
                                          //   ),
                                          // ),
                                          // Container(
                                          //   constraints: BoxConstraints(
                                          //     //  minHeight: 20,
                                          //     minWidth: 300,
                                          //     maxWidth: 700,
                                          //   ),
                                          //   width: maxwidth * .8,
                                          //   child: TextField(
                                          //     decoration: const InputDecoration(
                                          //         focusedBorder:
                                          //             UnderlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: widgetcolor),
                                          //         ),
                                          //         border: InputBorder.none,
                                          //         labelText: "Country",
                                          //         labelStyle: TextStyle(
                                          //             fontSize: 20.0)),
                                          //     keyboardType: TextInputType.text,
                                          //     style: textStyle,
                                          //     controller:
                                          //         _custcountryController,
                                          //   ),
                                          // ),
                                          // Container(
                                          //   constraints: BoxConstraints(
                                          //     //  minHeight: 20,
                                          //     minWidth: 300,
                                          //     maxWidth: 700,
                                          //   ),
                                          //   width: maxwidth * .8,
                                          //   child: TextField(
                                          //     decoration: const InputDecoration(
                                          //         focusedBorder:
                                          //             UnderlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: widgetcolor),
                                          //         ),
                                          //         border: InputBorder.none,
                                          //         labelText: "Swift Code",
                                          //         labelStyle: TextStyle(
                                          //             fontSize: 20.0)),
                                          //     keyboardType: TextInputType.text,
                                          //     style: textStyle,
                                          //     controller:
                                          //         _custswiftcodeontroller,
                                          //   ),
                                          // ),
                                          // Container(
                                          //   constraints: BoxConstraints(
                                          //     //  minHeight: 20,
                                          //     minWidth: 300,
                                          //     maxWidth: 700,
                                          //   ),
                                          //   width: maxwidth * .8,
                                          //   child: TextField(
                                          //     decoration: const InputDecoration(
                                          //         focusedBorder:
                                          //             UnderlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: widgetcolor),
                                          //         ),
                                          //         border: InputBorder.none,
                                          //         labelText: "Remarks",
                                          //         labelStyle: TextStyle(
                                          //             fontSize: 20.0)),
                                          //     keyboardType: TextInputType.text,
                                          //     style: textStyle,
                                          //     controller:
                                          //         _custremarksController,
                                          //   ),
                                          // )

                                          // ]),
                                          // Row(children: [
                                          // ]),
                                          // Row(children: [
                                          //   ]),
                                          // Row(children: [
                                          // ]),
                                          // Row(children: [
                                          // ]),
                                          // Row(children: [
                                          //  ]),
                                          // Row(children: [
                                          // ]),
                                          // Row(children: [
                                          //   ]),
                                          // Row(children: [
                                          //    ]),
                                          // Row(children: [
                                          //  ]),
                                          // SizedBox(
                                          //   height: 20.0,
                                          // ),
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
                      } else {
                        final String customerurl =
                            "http://posmmapi.suninfotechnologies.in/api/partymaster?&intflag=5&strPartyname=" +
                                _custNameController.text;

                        var response = await http.get(
                            Uri.encodeFull(customerurl),
                            headers: {"Accept": "application/json"});
                        var convertDataToJson = json.decode(response.body);
                        setState(() {
                          enable = true;
                        });
                        if (convertDataToJson[0]
                            .toString()
                            .contains("Already Exists: Already Exists")) {
                          Alert(
                              context: context,
                              title: "Alert",
                              type: AlertType.warning,
                              desc: "Already Exists",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Close",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      ShowAddWidget = false;
                                    });
                                    //clearData(context);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => HomePage(
                                    //             custselectedtype, custpageno)));
                                  },
                                  width: 120,
                                )
                              ]).show();
                        } else {
                          // pr.show();
                          saveItems();

                          // Function f;
                          // f = await Navigator.pushNamed(context, 'Dashboard',
                          //     arguments: {custselectedtype, custpageno});
                          // f();
                        }
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
                      setState(() {
                        ShowAddWidget = false;
                      });
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
    String custId = _custIdController.text;
    String custName = _custNameController.text;
    String custMobile = _custcontactnumberController.text;
    // String custRemarks = _custRemarksController.text;
    String custGstin = _custtaxcodeController.text;
    String custAdd1 = _custAdd1Controller.text;
    String custAdd2 = _custAdd2Controller.text;
    String custAdd3 = _custAdd3Controller.text;
    String custcontactperson = _custcontactpersonController.text;
    String custemail = _custemailController.text;

    setState(() {
      enable = false;
    });
    clearData(context);

    if (custId != '' && custName != '') {
      //   pr.show();

      try {
        Stream<String> stream = await insertCustomer(
            custId,
            custName,
            custMobile,
            custAdd1,
            custAdd2,
            custAdd3,
            "",
            custGstin,
            custemail,
            0,
            custcontactperson,
            custGstin,
            "",
            "",
            "",
            "",
            "",
            "",
            partytypeid);
        stream.listen((String message) {
          if (message.contains("""[{"RESULT":1}]""") ||
              message.contains("""[{"RESULT":2}]""")) {
            setState(() {
              ShowAddWidget = false;
            });
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
            setState(() {
              ShowAddWidget = false;
            });
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
      setState(() {
        ShowAddWidget = false;
      });
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
    _custIdController.text = '0';
    _custNameController.text = '';
    _custAdd1Controller.text = '';

    _custAdd2Controller.text = '';
    _custcontactpersonController.text = '';
    _custcontactnumberController.text = '';
    _custAdd3Controller.text = '';
    _custtaxcodeController.text = '';
    _custemailController.text = '';
    _custcountryController.text = '';
    _id = '0';

    // Navigator.pop(context);
    //  FocusScope.of(context).requestFocus(custidFocusNode);
  }

  List<customer.Customer> data = new List<customer.Customer>();

  Future<List<type.Customer>> getpartytypeMaster(String filter) async {
    setState(() {
      partytypedetails = [];
      partytypedata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=20&Mode=PARTYTYPE&spname=GetAndSubmitPartytype&intflag=4&intUserID=1";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      partytypedetails = parsed
          .map<type.Customer>((json) => type.Customer.fromJSON(json))
          .toList();

      if (filter != "")
        partytypedetails = partytypedetails
            .where((element) =>
                element.ptyname
                    .toLowerCase()
                    .toString()
                    .contains(filter.toLowerCase().toString()) &&
                element.ptyname.toLowerCase() != 'supplier'.toLowerCase())
            .toList();

      partytypedata = partytypedetails.map((e) => e.ptyname).toList();
      if (partytypeid == '' || partytypeid == null || partytypeid == '0') {
        selectedpartytype = partytypedata.first;

        appbartitle = selectedpartytype;
      }

      partytypeid = partytypedetails
          .where((element) => element.ptyname == selectedpartytype)
          .map((e) => e.partyid)
          .first
          .toString();
    });

    return partytypedetails;
  }

  Future<customer.Customer> getAddCustomerJson() async {
    String customerurl;

    if (searchtext == '' || searchtext == null) {
      customerurl =
          'http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intUserID=1&intPartytypeID=1&pagesize=' +
              custselectedtype +
              '&pagenumber=' +
              custpageno.toString();
    } else {
      customerurl =
          'http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intUserID=1&pagesize=' +
              custselectedtype +
              '&pagenumber=' +
              custpageno.toString() +
              '&strPartyname=' +
              searchtext;
    }

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    List<customer.Customer> customer1 = new List<customer.Customer>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    customer1 = parsed
        .map<customer.Customer>((json) => customer.Customer.fromJSON(json))
        .toList();
    data = customer1;
    if (_id != "" && _id != "" && _id != null)
      customer1
          .where((element) => element.custId == _id)
          .forEach((element) => setState(() {
                _custAdd1Controller.text = element.add1;
                _custAdd2Controller.text = element.add2;
                _custcontactpersonController.text = element.contactperson;
                _custcontactnumberController.text = element.mobile;
                typeid = element.partytypeMasterID;
                selectedpartytype = element.partytype;
                _custtaxcodeController.text = element.gstin;
                _custemailController.text = element.email;
                _custAdd3Controller.text = element.add3;
                _custNameController.text = element.customerName;
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
    getpartytypeMaster('');
    custidFocusNode = FocusNode();
    _custIdController.text = '0';
    //getGroupMaster('');
    setState(() {
      getAddCustomerJson();
      if ((_id != "") && (_id != null) && (_id != "0"))
        _custIdController.text = _id.toString();
    });

    super.initState();
  }

  PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  void dispose() {
    _custcountryController.dispose();
    _custemailController.dispose();
    _custNameController.dispose();
    _custAdd1Controller.dispose();
    _custAdd2Controller.dispose();
    _custcontactpersonController.dispose();
    _custcontactnumberController.dispose();
    _custIdController.dispose();
    _custtaxcodeController.dispose();
    _custAdd3Controller.dispose();
    custidFocusNode.dispose();
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

    Widget Addbutton() {
      return FloatingActionButton(
        backgroundColor: widgetcolor,
        onPressed: () {},
        tooltip: 'Add new customer entry',
        child: IconButton(
            icon: Image.asset('images/add.png', color: Colors.black),
            onPressed: () {
              setState(() {
                enable = false;
                _id = '0';
                ShowAddWidget = true;
                custpageno = pageno;
                custselectedtype = selectedtype;
                getAddCustomerJson();
                getpartytypeMaster('');
                clearData(context);
                //  getGroupMaster('');
                //setState(() {
                //   getCustomerJson();
                if ((_id != "") && (_id != null) && (_id != "0"))
                  _custIdController.text = _id.toString();
              });
            }),
      );
    }

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
                    child: Text("Name",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    // width: maxwidth * .10,
                    child: Text("Email",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  // SizedBox(
                  //   width: 90,
                  // ),
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
            mobile: (BuildContext context) => ShowAddWidget == false
                ? Scaffold(
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.miniEndDocked,
                    floatingActionButton: Addbutton(),
                    drawer: drawer.CollapsingNavigationDrawer(),
                    appBar: appbarwid(),
                    bottomNavigationBar: bottomapp(maxwidth, maxheight),
                    body: bodywid(maxwidth, maxheight),
                  )
                : addcustomerwid(maxwidth, maxheight),
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
                        floatingActionButton: Addbutton(),
                        drawer: drawer.CollapsingNavigationDrawer(),
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
                    child: addcustomerwid(maxwidth, maxheight),
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

  List<Customer> _customers;
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
            "https://cors-anywhere.herokuapp.com/http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intPartytypeID=" +
                ((partytypeid.toString() != 'null' &&
                        partytypeid.toString() != '' &&
                        partytypeid.toString() != '0')
                    ? partytypeid.toString()
                    : '1') +
                "&intUserID=1&pagesize=" +
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
          parsed.map<Customer>((json) => Customer.fromJSON(json)).toList();

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
                          // Container(
                          //     child: Row(
                          //   children: [

                          //Spacer(),
                          // SizedBox(width: 25),
                          Expanded(
                            //width: maxwidth * .20,
                            child: Text(
                              _reportItems[index]
                                  .customerName
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
                                  .email
                                  .toLowerCase()
                                  .toString(),
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
                                  ShowAddWidget = true;
                                  String id = _reportItems[index].custId;
                                  _id = id;
                                  custselectedtype = selectedtype;
                                  custpageno = pageno;
                                  getAddCustomerJson();
                                  getpartytypeMaster('');
                                  // getGroupMaster('');
                                  //setState(() {
                                  //   getCustomerJson();
                                  if ((_id != "") &&
                                      (_id != null) &&
                                      (_id != "0"))
                                    _custIdController.text = _id.toString();

                                  /// });
                                });
                              },
                              highlightColor: Colors.pink,
                            ),
                            SizedBox(width: 1),
                            // Spacer(),
                            new IconButton(
                              icon: Image.asset('Images/delete.png',
                                  color: widgetcolor),
                              onPressed: () async {
                                String id = _reportItems[index].custId;

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
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
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
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
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

  List<Widget> generateTables() {
    List<Widget> widgets = <Widget>[];
    widgets.add(ListView.builder(
        itemCount: _reportItems.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Expanded(
            child: Text(
              _reportItems[index].customerName.toString(),
              textScaleFactor: 1.6,
              textAlign: TextAlign.right,
            ),
          );
        }));

    //widgets.add(SizedBox(height: 2.0));
    return widgets;
  }

  Widget generateChildTable() {
    return ListView.builder(
        itemCount: _reportItems.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Expanded(
            child: Text(
              _reportItems[index].customerName.toString(),
              textScaleFactor: 1.6,
              textAlign: TextAlign.right,
            ),
          );
        });
  }
}
