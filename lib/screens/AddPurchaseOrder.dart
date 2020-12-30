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
import 'package:touchwoodapp/repository/cutomer_repository.dart';
//import 'package:touchwoodapp/screens/AddCustomer.dart' as Addparty;
import 'dart:convert';
import 'package:touchwoodapp/models/Paging.dart';
import 'dart:core';
import 'dart:convert';
import 'dart:io';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
import 'package:touchwoodapp/screens/dashboard.dart';
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
List<Customer> _reportItems = <Customer>[];
Paging _pagingdetails = new Paging();
List<Customer> data = <Customer>[];
TextEditingController _GotoTextController;
bool ShowAddWidget = false;
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

String selectedcompany;
String selectedcurrency;
String custselectedtype;
String selectedyarnmill;
String selectedyarncolor;
String selectedyarntype;
String selectedyarncount;
String selectedfabric;
String selectedfabcolor;
String selecteddia;
String selecteduom;
String selectedcomposition;

int custpageno;
String compid;
String currencyid;
String supplierid;
String selectedsupplier;
String selectedprodtype;
GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<customer.Customer>>();
String _id = "";
TextStyle textStyle = new TextStyle(color: Colors.black);
GlobalKey<AutoCompleteTextFieldState<customer.Customer>> custKey =
    new GlobalKey();
AutoCompleteTextField<customer.Customer> textField;
List<type.Customer> companydetails = <type.Customer>[];
List<type.Customer> currencydetails = <type.Customer>[];
List<type.Customer> supplierdetails = <type.Customer>[];
List<String> companydata = [];
List<String> supplierdata = [];
List<String> currencydata = [];
List<String> yarncountdata = [];
List<String> yarnmilldata = [];
List<String> yarncolordata = [];
List<String> yarntypedata = [];
List<String> fabricdata = [];
final _custPONoController = TextEditingController();
final _custIdController = TextEditingController();
final _custMobileController = TextEditingController();
final _custRemarksController = TextEditingController();
final _custDateController = TextEditingController();
final _custNotifypartyController = TextEditingController();
final _custAdd3Controller = TextEditingController();
final _custAdd4Controller = TextEditingController();
final _custEmailController = TextEditingController();
final _custGstinController = TextEditingController();
ProgressDialog pr;
FocusNode custidFocusNode;
double maxwidth;
double maxheight;
TextEditingController dateCtl = TextEditingController();
var seldate;
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

GlobalKey _keyRed = GlobalKey();
double xaxis;

class HomePageState extends State<HomePage> {
  _getPositions() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);

    setState(() {
      xaxis = positionRed.dx;
    });
    print("POSITION of Red: $positionRed ");
  }

  Widget addcustomerwid(double maxwidth, double maxheight) {
    var _custconsigneeAddressController;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text(
              'Add PurchaseOrder',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: appbarcolor,
          centerTitle: true,
        ),
        body: Container(
            height: maxheight,
            width: maxwidth,

            //width: MediaQuery.of(context).size.width,5
            margin: EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(
                color: widgetcolor,
                width: 2,
              ),
            ),
            child: Container(
                margin: EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Enter Purchase Order Details",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            if (companydata != null && companydata.isNotEmpty)
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
                                  validator: (v) =>
                                      v == null ? "required field" : null,
                                  hint: "Select a Company",
                                  mode: Mode.MENU,
                                  enabled:
                                      (_id != null && _id != '' && _id != '0')
                                          ? false
                                          : true,
                                  showSelectedItem: true,
                                  showSearchBox: true,
                                  items: companydata,
                                  label: "Type *",
                                  showClearButton: false,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedcompany = val;

                                      compid = companydetails
                                          .where((element) =>
                                              element.ptyname == val)
                                          .map((e) => e.partyid)
                                          .first
                                          .toString();
                                    });
                                  },
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  selectedItem: selectedcompany,
                                ),
                              ),
                            // ],
                            // ),
                            // ),
                            //)
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                //minHeight: 20,
                                minWidth: 300,
                                maxWidth: 380,
                              ),
                              width: maxwidth * .7,
                              child: TextField(
                                decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: widgetcolor),
                                    ),
                                    border: InputBorder.none,
                                    //disabledBorder: InputDecoration.collapsed(hintText: null),
                                    labelText: "PO No",
                                    labelStyle: TextStyle(fontSize: 20.0)),
                                keyboardType: TextInputType.text,
                                style: textStyle,
                                controller: _custPONoController,
                                focusNode: custidFocusNode,

                                readOnly: enable,
                                //enableInteractiveSelection: enable,
                              ),
                            ),
                            Spacer(),
                            Container(
                              constraints: BoxConstraints(
                                //minHeight: 20,
                                minWidth: 300,
                                maxWidth: 300,
                              ),
                              key: _keyRed,
                              width: maxwidth * .7,
                              child: TextField(
                                decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: widgetcolor),
                                    ),
                                    border: InputBorder.none,
                                    //disabledBorder: InputDecoration.collapsed(hintText: null),
                                    labelText: "Consignee Address",
                                    labelStyle: TextStyle(fontSize: 20.0)),
                                keyboardType: TextInputType.text,
                                style: textStyle,
                                controller: _custconsigneeAddressController,
                                // focusNode: custidFocusNode,

                                readOnly: enable,
                                //enableInteractiveSelection: enable,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                //minHeight: 20,
                                minWidth: 300,
                                maxWidth: 380,
                              ),
                              width: maxwidth * .3,
                              child: TextFormField(
                                //enabled: false,
                                controller: dateCtl,
                                decoration: InputDecoration(
                                  labelText: "Date",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Ex. Insert your date",
                                ),
                                onTap: () async {
                                  DateTime date = DateTime(1900);
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));

                                  if (this.mounted)
                                    setState(() {
                                      DateTime today = date;

                                      if (today != null) {
                                        seldate =
                                            "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

                                        dateCtl.text =
                                            "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year.toString()}";
                                      }
                                      //  seldate; //date.toIso8601String();
                                    });
                                },
                              ),
                            ),
                            Spacer(),
                            Container(
                              constraints: BoxConstraints(
                                //minHeight: 20,
                                minWidth: 300,
                                maxWidth: 380,
                              ),
                              width: maxwidth * .4,
                              child: TextField(
                                decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: widgetcolor),
                                    ),
                                    border: InputBorder.none,
                                    labelText: "Notify Party",
                                    labelStyle: TextStyle(fontSize: 20.0)),

                                keyboardType: TextInputType.text,
                                style: textStyle,
                                controller: _custNotifypartyController,
                                //  focusNode: custidFocusNode,
                              ),
                            ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            if (supplierdata != null && supplierdata.isNotEmpty)
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
                                  validator: (v) =>
                                      v == null ? "required field" : null,
                                  hint: "Select a Supplier",
                                  mode: Mode.MENU,
                                  enabled:
                                      (_id != null && _id != '' && _id != '0')
                                          ? false
                                          : true,
                                  showSelectedItem: true,
                                  showSearchBox: true,
                                  items: supplierdata,
                                  label: "Supplier *",
                                  showClearButton: false,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedsupplier = val;

                                      supplierid = supplierdetails
                                          .where((element) =>
                                              element.ptyname == val)
                                          .map((e) => e.partyid)
                                          .first
                                          .toString();
                                    });
                                  },
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  selectedItem: selectedsupplier,
                                ),
                              ),
                            // ],
                            Spacer(),
                            if (currencydata != null && currencydata.isNotEmpty)
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
                                  validator: (v) =>
                                      v == null ? "required field" : null,
                                  hint: "Select a Currency",
                                  mode: Mode.MENU,
                                  enabled:
                                      (_id != null && _id != '' && _id != '0')
                                          ? false
                                          : true,
                                  showSelectedItem: true,
                                  showSearchBox: true,
                                  items: currencydata,
                                  label: "Currency *",
                                  showClearButton: false,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedcurrency = val;

                                      currencyid = currencydetails
                                          .where((element) =>
                                              element.ptyname == val)
                                          .map((e) => e.partyid)
                                          .first
                                          .toString();
                                    });
                                  },
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  selectedItem: selectedcurrency,
                                ),
                              ),
                            // ],// ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            //if (supplierdata != null && supplierdata.isNotEmpty)
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
                                validator: (v) =>
                                    v == null ? "required field" : null,
                                hint: "Select a Type",
                                mode: Mode.MENU,
                                enabled:
                                    (_id != null && _id != '' && _id != '0')
                                        ? false
                                        : true,
                                showSelectedItem: true,
                                showSearchBox: true,
                                items: ['Yarn', 'Fabric', 'Granite'],
                                label: "Type *",
                                showClearButton: false,
                                onChanged: (val) {
                                  setState(() {
                                    selectedsupplier = val;

                                    supplierid = supplierdetails
                                        .where(
                                            (element) => element.ptyname == val)
                                        .map((e) => e.partyid)
                                        .first
                                        .toString();
                                  });
                                },
                                popupItemDisabled: (String s) =>
                                    s.startsWith('I'),
                                selectedItem: selectedprodtype,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            //if (supplierdata != null && supplierdata.isNotEmpty)
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
                                validator: (v) =>
                                    v == null ? "required field" : null,
                                hint: "Select a Type",
                                mode: Mode.MENU,
                                enabled:
                                    (_id != null && _id != '' && _id != '0')
                                        ? false
                                        : true,
                                showSelectedItem: true,
                                showSearchBox: true,
                                items: ['Yarn', 'Fabric', 'Granite'],
                                label: "Type *",
                                showClearButton: false,
                                onChanged: (val) {
                                  setState(() {
                                    selectedsupplier = val;

                                    supplierid = supplierdetails
                                        .where(
                                            (element) => element.ptyname == val)
                                        .map((e) => e.partyid)
                                        .first
                                        .toString();
                                  });
                                },
                                popupItemDisabled: (String s) =>
                                    s.startsWith('I'),
                                selectedItem: selectedprodtype,
                              ),
                            ),
                          ],
                        )
                      ]),
                ))),
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
                                _custPONoController.text;

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
    String custName = _custPONoController.text;
    String custMobile = _custMobileController.text;
    String custGstin = _custGstinController.text;
    String custAdd1 = _custDateController.text;
    String custAdd2 = _custNotifypartyController.text;
    String custAdd3 = _custAdd3Controller.text;
    String custAdd4 = _custAdd4Controller.text;
    String custemail = _custEmailController.text;
    if (custId != '' && custName != '') {
      try {
        Stream<String> stream = await insertCustomer(
           1,
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
                                                      "","","","","","","","");
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
      } on Exception catch (_) {}
    } else {
      setState(() {
        ShowAddWidget = true;
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
    _custPONoController.text = '';
    _custDateController.text = '';
    _custNotifypartyController.text = '';
    _custAdd3Controller.text = '';
    _custAdd4Controller.text = '';
    _custEmailController.text = '';
    _custGstinController.text = '';
    _custMobileController.text = '';
    _custRemarksController.text = '';
    _id = '0';
  }

  List<customer.Customer> data = new List<customer.Customer>();

  Future<List<type.Customer>> getcompanyMaster(String filter) async {
    setState(() {
      companydetails = [];
      companydata = [];
    });

    final String customerurl =
        "http://posmmapi.suninfotechnologies.in/api/partytype?&intflag=4";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      companydetails = parsed
          .map<type.Customer>((json) => type.Customer.fromJSON(json))
          .toList();

      if (filter != "")
        companydetails = companydetails
            .where((element) => element.ptyname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      companydata = companydetails.map((e) => e.ptyname).toList();
      if (compid == '' || compid == null || compid == '0')
        selectedcompany = companydata.first;

      compid = compid = companydetails
          .where((element) => element.ptyname == selectedcompany)
          .map((e) => e.partyid)
          .first
          .toString();
    });

    return companydetails;
  }

  Future<List<type.Customer>> getsupplierdetails(String filter) async {
    setState(() {
      supplierdetails = [];
      supplierdata = [];
    });

    final String customerurl =
        "http://posmmapi.suninfotechnologies.in/api/partytype?&intflag=4";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      supplierdetails = parsed
          .map<type.Customer>((json) => type.Customer.fromJSON(json))
          .toList();

      if (filter != "")
        supplierdetails = supplierdetails
            .where((element) => element.ptyname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      supplierdata = supplierdetails.map((e) => e.ptyname).toList();
      if (compid == '' || compid == null || compid == '0')
        selectedsupplier = supplierdata.first;

      supplierid = supplierdetails
          .where((element) => element.ptyname == selectedsupplier)
          .map((e) => e.partyid)
          .first
          .toString();
    });

    return supplierdetails;
  }

  Future<List<type.Customer>> getcurrencydetails(String filter) async {
    setState(() {
      currencydetails = [];
      currencydata = [];
    });

    final String customerurl =
        "http://posmmapi.suninfotechnologies.in/api/partytype?&intflag=4";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      currencydetails = parsed
          .map<type.Customer>((json) => type.Customer.fromJSON(json))
          .toList();

      if (filter != "")
        currencydetails = currencydetails
            .where((element) => element.ptyname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      currencydata = currencydetails.map((e) => e.ptyname).toList();
      if (compid == '' || compid == null || compid == '0')
        selectedcurrency = currencydata.first;

      currencyid = currencydetails
          .where((element) => element.ptyname == selectedcurrency)
          .map((e) => e.partyid)
          .first
          .toString();
    });

    return currencydetails;
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
                _custDateController.text = element.add1;
                _custNotifypartyController.text = element.add2;
                _custAdd3Controller.text = element.add3;
                _custAdd4Controller.text = element.add4;
                compid = element.partytypeMasterID;
                selectedcompany = element.partytype;
                _custEmailController.text = element.email;
                _custMobileController.text = element.mobile;
                _custGstinController.text = element.gstin;
                _custPONoController.text = element.customerName;
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
    custidFocusNode = FocusNode();
    _custIdController.text = '0';
    getcompanyMaster('');
    getsupplierdetails('');
    getcurrencydetails('');
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    //_getPositions();
    setState(() {
      getAddCustomerJson();
      if ((_id != "") && (_id != null) && (_id != "0"))
        _custIdController.text = _id.toString();
    });

    super.initState();
  }

  _afterLayout(_) {
    //_getSizes();
    _getPositions();
  }

  PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  void dispose() {
    _custRemarksController.dispose();
    _custMobileController.dispose();
    _custPONoController.dispose();
    _custDateController.dispose();
    _custNotifypartyController.dispose();
    _custAdd3Controller.dispose();
    _custAdd4Controller.dispose();
    _custIdController.dispose();
    _custGstinController.dispose();
    _custEmailController.dispose();
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
                    child: Text("Type",
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: widgetcolor,
                        )),
                  ),
                  Expanded(
                    child: Text("Name",
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
                SizedBox(width: width / 40),
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
                SizedBox(width: width / 40),
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

    Widget Addbutton() {
      return FloatingActionButton(
        backgroundColor: widgetcolor,
        onPressed: () {},
        tooltip: 'Add new customer entry',
        child: IconButton(
            icon: Image.asset('images/add.png', color: Colors.black),
            onPressed: () {
              setState(() {
                ShowAddWidget = true;
                _id = '0';
                custpageno = pageno;
                custselectedtype = selectedtype;
                getAddCustomerJson();
                getcompanyMaster('');
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
            desktop: (BuildContext context) => Container(
                width: maxwidth, //- 210,
                // padding: EdgeInsets.only(left: 210),
                height: maxheight,
                child: Row(children: [
                  Expanded(
                      flex: 3,
                      child: Scaffold(
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.miniEndDocked,
                        floatingActionButton: Addbutton(),
                        drawer: drawer.CollapsingNavigationDrawer(),
                        drawerScrimColor: Colors.transparent,
                        appBar: appbarwid(),
                        bottomNavigationBar: bottomapp(maxwidth, maxheight),
                        body: bodywid(maxwidth, maxheight),
                      )),
                  // SizedBox(
                  //     width: 5,
                  //     child: Container(
                  //       color: appbarcolor,
                  //     )),
                  Expanded(
                    flex: 4,
                    child: addcustomerwid(maxwidth, maxheight),
                  )
                ])),
            watch: (BuildContext context) => Container(color: Colors.purple),
          );
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
                                  .partytype
                                  .toLowerCase()
                                  .toString(),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.left,
                            ),
                          ),

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
                                  getcompanyMaster('');
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
                                                     1,
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
                                                      "","","","","","","","");
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
