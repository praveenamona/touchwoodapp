import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:touchwoodapp/models/customer.dart';
import 'package:touchwoodapp/models/Paging.dart';
import 'package:touchwoodapp/widgets/collapsing_navigation_drawer_widget.dart'
    as drawer;
import 'package:touchwoodapp/repository/cutomer_repository.dart';

import 'dart:convert';
import 'dart:core';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:touchwoodapp/repository/assigncolor.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:touchwoodapp/models/customer.dart' as customer;
import 'package:touchwoodapp/models/partytype.dart' as type;

void main() => runApp(new MaterialApp(
      home: new HomePage("10", 1),
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
    ));
PageController controller = PageController();
List<Customer> _reportItems = <Customer>[];

List<Customer> data = <Customer>[];

bool showAddWidget = false;
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
FocusNode _nameFocus;
FocusNode _add2Focus;
FocusNode _remarksFocus;
FocusNode _mobileFocus;
FocusNode _add1Focus;
FocusNode _add4Focus;
FocusNode _add3Focus;
FocusNode _emailFocus;
FocusNode _gstinFocus;
FocusNode _contactpersonFocus;
FocusNode _banknameFocus;
FocusNode _bankaddressFocus;
FocusNode _bankbranchFocus;
FocusNode _swiftFocus;
FocusNode _countryFocus;

String selectedcustomer;
String custselectedtype;
int custpageno;
String typeid = "2";
GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<customer.Customer>>();
String _id = "";
TextStyle textStyle = new TextStyle(color: Colors.black);
GlobalKey<AutoCompleteTextFieldState<customer.Customer>> custKey =
    new GlobalKey();
AutoCompleteTextField<customer.Customer> textField;
List<type.Customer> typedetails = <type.Customer>[];
List<String> typedata = [];
final _custNameController = TextEditingController();
final _custIdController = TextEditingController();
final _custMobileController = TextEditingController();
final _custRemarksController = TextEditingController();
final _custAdd1Controller = TextEditingController();
final _custAdd2Controller = TextEditingController();
final _custAdd3Controller = TextEditingController();
final _custAdd4Controller = TextEditingController();
final _custEmailController = TextEditingController();
final _custGstinController = TextEditingController();
final _custContactPersonController = TextEditingController();
final _custBanknameController = TextEditingController();
final _custBankAddressController = TextEditingController();
final _custBankBranchController = TextEditingController();
final _custCountryController = TextEditingController();
final _custSwiftCodeController = TextEditingController();
ProgressDialog pr;
FocusNode custidFocusNode;
double maxwidth;
double maxheight;

bool enable = false;

class HomePage extends StatefulWidget {
  final String selectedType;
  final int pageNo;
  HomePage(this.selectedType, this.pageNo);

  String get custid {
    selectedtype = selectedType;
    pageno = pageNo;
    return '';
  }

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Widget addcustomerwid(double maxwidth, double maxheight) {
    // document.addEventListener('keydown', (dynamic event) {
    //   if (event.code == 'Tab') {
    //     //  event.preventDefault();
    //   }
    // });
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text(
              'Supplier',
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
                                          //   "Enter Supplier Details",
                                          //   style: TextStyle(fontSize: 16),
                                          // ),
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
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(_add1Focus);
                                                }
                                              },
                                              autofocus: true,
                                              focusNode: _nameFocus,
                                              child: TextField(
                                                //  focusNode: _nameFocus,
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                        labelText: "Name",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller: _custNameController,
                                                // focusNode: custidFocusNode,

                                                readOnly: enable,
                                                //enableInteractiveSelection: enable,
                                              ),
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
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(_add2Focus);
                                                }
                                              },
                                              focusNode: _add1Focus,
                                              child: TextField(
                                                //    FocusScope.of(context).requestFocus(myFocusNode);
                                                // focusNode: _add1Focus,
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Add1",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller: _custAdd1Controller,
                                                // focusNode: custidFocusNode,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 380,
                                            ),
                                            width: maxwidth * .7,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(_add3Focus);
                                                }
                                              },
                                              focusNode: _add2Focus,
                                              child: TextField(
                                                //    focusNode: _add2Focus,
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Add2",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),

                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller: _custAdd2Controller,
                                                //  focusNode: custidFocusNode,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 380,
                                            ),
                                            width: maxwidth * .7,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(_add4Focus);
                                                }
                                              },
                                              focusNode: _add3Focus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Add3",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller: _custAdd3Controller,
                                                //focusNode: custidFocusNode,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 380,
                                            ),
                                            width: maxwidth * .7,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _contactpersonFocus);
                                                }
                                              },
                                              focusNode: _add4Focus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Add4",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),

                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller: _custAdd4Controller,
                                                // focusNode: custidFocusNode,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 300,
                                              //  minHeight: 20,
                                              maxWidth: 300,
                                              //maxHeight: double.infinity
                                            ),
                                            width: maxwidth * .7,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _mobileFocus);
                                                }
                                              },
                                              focusNode: _contactpersonFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText:
                                                            "Contact Person",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.number,
                                                style: textStyle,
                                                controller:
                                                    _custContactPersonController,
                                              ),
                                            ),
                                          ),

                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 300,
                                              //  minHeight: 20,
                                              maxWidth: 300,
                                              //maxHeight: double.infinity
                                            ),
                                            width: maxwidth * .7,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _gstinFocus);
                                                }
                                              },
                                              focusNode: _mobileFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Mobile",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.number,
                                                style: textStyle,
                                                controller:
                                                    _custMobileController,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 300,
                                              maxWidth: 300,
                                            ),
                                            width: maxwidth * .7,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _emailFocus);
                                                }
                                              },
                                              focusNode: _gstinFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Tax Code",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),

                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller:
                                                    _custGstinController,
                                                // focusNode: custidFocusNode,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 380,
                                              //maxHeight: double.infinity
                                            ),
                                            width: maxwidth * .7,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _banknameFocus);
                                                }
                                              },
                                              focusNode: _emailFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Email",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),

                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller:
                                                    _custEmailController,
                                                //focusNode: custidFocusNode,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //  minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 700,
                                            ),
                                            width: maxwidth * .8,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _bankaddressFocus);
                                                }
                                              },
                                              focusNode: _banknameFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Bank Name",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller:
                                                    _custBanknameController,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //  minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 700,
                                            ),
                                            width: maxwidth * .8,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _bankbranchFocus);
                                                }
                                              },
                                              focusNode: _bankaddressFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText:
                                                            "Bank Address",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller:
                                                    _custBankAddressController,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //  minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 700,
                                            ),
                                            width: maxwidth * .8,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _countryFocus);
                                                }
                                              },
                                              focusNode: _bankbranchFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText:
                                                            "Bank Branch",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller:
                                                    _custBankBranchController,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //  minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 700,
                                            ),
                                            width: maxwidth * .8,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _swiftFocus);
                                                }
                                              },
                                              focusNode: _countryFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Country",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller:
                                                    _custCountryController,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //  minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 700,
                                            ),
                                            width: maxwidth * .8,
                                            child: RawKeyboardListener(
                                              onKey: (dynamic key) {
                                                if (key.data.key == "Tab") {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _remarksFocus);
                                                }
                                              },
                                              focusNode: _swiftFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Swift Code",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller:
                                                    _custSwiftCodeController,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              //  minHeight: 20,
                                              minWidth: 300,
                                              maxWidth: 700,
                                            ),
                                            width: maxwidth * .8,
                                            child: RawKeyboardListener(
                                              // onKey: (dynamic key) {
                                              //   if (key.data.key == "Tab") {
                                              //     FocusScope.of(context)
                                              //         .requestFocus(_add2Focus);
                                              //   }
                                              // },
                                              focusNode: _nameFocus,
                                              child: TextField(
                                                decoration:
                                                    const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  widgetcolor),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        labelText: "Remarks",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: textStyle,
                                                controller:
                                                    _custRemarksController,
                                              ),
                                            ),
                                          )
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
                                      showAddWidget = false;
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
                        showAddWidget = false;
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
    String custMobile = _custMobileController.text;
    String custGstin = _custGstinController.text;
    String custAdd1 = _custAdd1Controller.text;
    String custAdd2 = _custAdd2Controller.text;
    String custAdd3 = _custAdd3Controller.text;
    String custAdd4 = _custAdd4Controller.text;
    String custemail = _custEmailController.text;
    String custcontact = _custContactPersonController.text;
    String custRemarks = _custRemarksController.text;
    String custBankName = _custBanknameController.text;
    String custBankAddress = _custBankAddressController.text;
    String custBankBranch = _custBankBranchController.text;
    String custCountry = _custCountryController.text;
    String custSwiftCode = _custSwiftCodeController.text;

    if (custId != '' && custName != '') {
      try {
        Stream<String> stream = await insertCustomer(
            custId,
            custName,
            custMobile,
            custAdd1,
            custAdd2,
            custAdd3,
            custAdd4,
            custGstin,
            custemail,
            0,
            custcontact,
            custGstin,
            custRemarks,
            custBankName,
            custBankAddress,
            custBankBranch,
            custCountry,
            custSwiftCode,
            "2");
        stream.asBroadcastStream().listen((String message) {
          if (message.contains("""[{"RESULT":1}]""") ||
              message.contains("""[{"RESULT":2}]""")) {
            clearData(context);
            enable = false;

            setState(() {
              showAddWidget = false;
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
              showAddWidget = false;
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
      } on Exception catch (_) {}
    } else {
      setState(() {
        showAddWidget = true;
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

    _custBankAddressController.text = '';
    _custBankBranchController.text = '';
    _custBanknameController.text = '';
    _custAdd1Controller.text = '';
    _custAdd2Controller.text = '';
    _custContactPersonController.text = '';
    _custCountryController.text = '';
    _custSwiftCodeController.text = '';
    _custAdd3Controller.text = '';
    _custAdd4Controller.text = '';
    _custEmailController.text = '';
    _custGstinController.text = '';
    _custMobileController.text = '';
    _custRemarksController.text = '';
    _id = '0';
    _nameFocus.requestFocus();
    // FocusScope.of(context).requestFocus(_nameFocus);
  }

  List<customer.Customer> data = new List<customer.Customer>();

  // Future<List<type.Customer>> getGroupMaster(String filter) async {
  //   setState(() {
  //     typedetails = [];
  //     typedata = [];
  //   });

  //   final String customerurl =
  //       "http://posmmapi.suninfotechnologies.in/api/partytype?&intflag=4";

  //   var response = await http.get(Uri.encodeFull(customerurl),
  //       headers: {"Accept": "application/json"});
  //   //List<ItemMaster> customer1 = new List<ItemMaster>();

  //   var convertDataToJson = json.decode(response.body);
  //   final parsed = convertDataToJson.cast<Map<String, dynamic>>();
  //   setState(() {
  //     typedetails = parsed
  //         .map<type.Customer>((json) => type.Customer.fromJSON(json))
  //         .toList();

  //     if (filter != "")
  //       typedetails = typedetails
  //           .where((element) => element.ptyname
  //               .toLowerCase()
  //               .toString()
  //               .contains(filter.toLowerCase().toString()))
  //           .toList();

  //     typedata = typedetails.map((e) => e.ptyname).toList();
  //     if (typeid == '' || typeid == null || typeid == '0')
  //       selectedcustomer = typedata.first;

  //     typeid = typeid = typedetails
  //         .where((element) => element.ptyname == selectedcustomer)
  //         .map((e) => e.partyid)
  //         .first
  //         .toString();
  //   });

  //   return typedetails;
  // }

  void getAddCustomerJson() async {
    String customerurl;

    if (searchtext == '' || searchtext == null) {
      customerurl =
          'http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intUserID=1&intPartytypeID=2&pagesize=' +
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
                _custAdd3Controller.text = element.add3;
                _custAdd4Controller.text = element.add4;
                typeid = element.partytypeMasterID;
                selectedcustomer = element.partytype;
                _custEmailController.text = element.email;
                _custMobileController.text = element.mobile;
                _custGstinController.text = element.gstin;
                _custNameController.text = element.customerName;
                _custContactPersonController.text = element.contactperson;
                _custBanknameController.text = element.bankname;
                _custBankAddressController.text = element.bankaddress;
                _custBankBranchController.text = element.bankbranch;
                _custCountryController.text = element.country;
                _custSwiftCodeController.text = element.swiftcode;
                _custRemarksController.text = element.remarks;
              }));
  }

  @override
  void initState() {
    idFocusNode = FocusNode();

    searchtext = '';
    getCustomerJson();
    custidFocusNode = FocusNode();
    _custIdController.text = '0';
    //getGroupMaster('');
    setState(() {
      getAddCustomerJson();
      if ((_id != "") && (_id != null) && (_id != "0"))
        _custIdController.text = _id.toString();
    });

    super.initState();
    _nameFocus = FocusNode();
    _add2Focus = FocusNode();
    _remarksFocus = FocusNode();
    _mobileFocus = FocusNode();
    _add1Focus = FocusNode();
    _add3Focus = FocusNode();
    _add4Focus = FocusNode();
    _emailFocus = FocusNode();
    _gstinFocus = FocusNode();
    _contactpersonFocus = FocusNode();
    _banknameFocus = FocusNode();
    _bankbranchFocus = FocusNode();
    _bankaddressFocus = FocusNode();
    _swiftFocus = FocusNode();
    _countryFocus = FocusNode();
  }

  PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  void dispose() {
    _custRemarksController.dispose();
    _custMobileController.dispose();
    _nameFocus.dispose();
    _add2Focus.dispose();
    _remarksFocus.dispose();
    _mobileFocus.dispose();
    _add1Focus.dispose();
    _add4Focus.dispose();
    _add3Focus.dispose();
    _emailFocus.dispose();
    _gstinFocus.dispose();
    _contactpersonFocus.dispose();
    _banknameFocus.dispose();
    _bankaddressFocus.dispose();
    _bankbranchFocus.dispose();
    _swiftFocus.dispose();
    _countryFocus.dispose();

    _custNameController.dispose();
    _custAdd1Controller.dispose();
    _custAdd2Controller.dispose();
    _custAdd3Controller.dispose();
    _custAdd4Controller.dispose();
    _custIdController.dispose();
    _custGstinController.dispose();
    _custEmailController.dispose();
    custidFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  NotchedShape shape;

  Widget build(BuildContext context) {
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
              });
            }),
      );
    }

    Widget bodywid(double maxwidth, double maxheight) {
      return new SizedBox(
        width: maxwidth, // * .40,
        height: maxheight,
        child: ListView(children: <Widget>[
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text("Name",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    child: Text("Email",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    child: Text("Mobile No",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    child: Text("Country",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    child: Text("Action",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
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
    }

    @override
    Widget bottomapp(double width, double height) {
      return BottomAppBar(
              color: appbarcolor,
              shape: CircularNotchedRectangle(),
              notchMargin: 6,
              child: Row(children: <Widget>[
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
                Text('Rows/Page',
                    style: TextStyle(
                      fontSize: 11,
                    )),
                SizedBox(
                  width: 20,
                ),
                if (selectedtype != null)
                  SizedBox(
                    child: DropdownButton<String>(
                        value: selectedtype,
                        icon: Image.asset('Images/arrow_drop_down.png',
                            color: Colors.white),
                        hint: SizedBox(child: Text('Rows Per Page')),
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

    Widget addbutton() {
      return FloatingActionButton(
        backgroundColor: widgetcolor,
        onPressed: () {},
        tooltip: 'Add new customer entry',
        child: IconButton(
            icon: Image.asset('images/add.png', color: Colors.black),
            onPressed: () {
              setState(() {
                showAddWidget = true;
                _id = '0';
                custpageno = pageno;
                custselectedtype = selectedtype;
                getAddCustomerJson();
                clearData(context);

                // getGroupMaster('');
                //setState(() {
                //   getCustomerJson();
                if ((_id != "") && (_id != null) && (_id != "0"))
                  _custIdController.text = _id.toString();
              });
            }),
      );
    }

    return MaterialApp(
        title: 'Sun Party',
        theme: new ThemeData(
          brightness: Brightness.light,
        ),
        home: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          var maxwidth = constraints.maxWidth;
          var maxheight = constraints.maxHeight;

          return ScreenTypeLayout.builder(
            mobile: (BuildContext context) => showAddWidget == false
                ? Scaffold(
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.miniEndDocked,
                    floatingActionButton: addbutton(),
                    drawer: drawer.CollapsingNavigationDrawer(),
                    appBar: appbarwid(),
                    bottomNavigationBar: bottomapp(maxwidth, maxheight),
                    body: bodywid(maxwidth, maxheight),
                  )
                : addcustomerwid(maxwidth, maxheight),
            desktop: (BuildContext context) => Container(
                width: maxwidth,
                height: maxheight,
                child: Row(children: [
                  Expanded(
                      flex: 3,
                      child: Scaffold(
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.miniEndDocked,
                        floatingActionButton: addbutton(),
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
                  )
                ])),
            watch: (BuildContext context) => Container(color: Colors.purple),
          );
        })); //);
  }

  Future<String> getCustomerJson() async {
    if (this.mounted) {
      setState(() {
        _reportItems = [];
        // _pagingdetails = null;
        totalPages = null;
      });
      String customerurl;

      if (searchtext == null || searchtext == '') {
        customerurl =
            "https://cors-anywhere.herokuapp.com/http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intPartytypeID=2&intUserID=1&pagesize=" +
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
    List<Widget> widgets = <Widget>[];
    if (totalPages != null) {
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
                          Expanded(
                            //width: maxwidth * .20,
                            child: Text(
                              _reportItems[index]
                                  .mobile
                                  .toLowerCase()
                                  .toString(),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.left,
                            ),
                          ),

                          // SizedBox(width: 25),
                          Expanded(
                            //width: maxwidth * .20,
                            child: Text(
                              _reportItems[index]
                                  .country
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
                                  showAddWidget = true;
                                  String id = _reportItems[index].custId;
                                  _id = id;
                                  custselectedtype = selectedtype;
                                  custpageno = pageno;
                                  getAddCustomerJson();
                                  // getGroupMaster('');
                                  //setState(() {
                                  //   getCustomerJson();
                                  if ((_id != "") &&
                                      (_id != null) &&
                                      (_id != "0"))
                                    _custIdController.text = _id.toString();

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
                                              stream
                                                  .asBroadcastStream()
                                                  .listen((String message) {
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
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
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
