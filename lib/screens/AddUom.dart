import 'dart:html';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:touchwoodapp/models/Master.dart';
import 'package:touchwoodapp/repository/assigncolor.dart';
import 'package:touchwoodapp/models/customer.dart';
import 'package:touchwoodapp/models/Paging.dart';
import 'package:touchwoodapp/widgets/collapsing_navigation_drawer_widget.dart'
    as drawer;
import 'package:touchwoodapp/repository/uom_repository.dart';

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
import 'package:touchwoodapp/models/uom.dart' as master;
import 'package:touchwoodapp/screens/Supplierdashboard.dart';
import 'package:dio/dio.dart';
import 'package:touchwoodapp/models/partytype.dart' as type;
import 'package:dropdown_search/dropdown_search.dart';

void main() => runApp(new MaterialApp(
      home: new HomePage(selectedType: "10", pageNo: 1),
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
    ));
PageController controller = PageController();
List<master.Uom> _reportItems = <master.Uom>[];
Paging _pagingdetails = new Paging();
List<Customer> data = <Customer>[];
TextEditingController _GotoTextController;
bool ShowAddWidget = false;
List<Paging> paging = new List<Paging>();
String selectedtype = "10";
String totalCount;
String pageSize;
String masterid;
String currentPage;
String totalPages;
String _id;
String previousPage;
String nextPage;
int pageno;
String searchtext;
FocusNode _nameFocus;
FocusNode _noofdecimalFocus;

int custpageno;
GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<master.Uom>>();

TextStyle textStyle = new TextStyle(color: Colors.black);
GlobalKey<AutoCompleteTextFieldState<master.Uom>> custKey = new GlobalKey();
AutoCompleteTextField<master.Uom> textField;
List<type.Customer> typedetails = <type.Customer>[];
List<String> typedata = [];
final _custNameController = TextEditingController();
final _custIdController = TextEditingController();
final _custnoofdecimalController = TextEditingController();
ProgressDialog pr;
String headerName;
String tableName;
double maxwidth;
double maxheight;

bool enable = false;

class HomePage extends StatefulWidget {
  String selectedType;
  String headername;
  String tablename;
  int pageNo;
  HomePage({this.selectedType, this.pageNo, this.headername, this.tablename});

  String get custid {
    selectedtype = selectedType;
    pageno = pageNo;
    headerName = headername;
    tableName = tablename;
  }

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Widget addcustomerwid(double maxwidth, double maxheight) {
    document.addEventListener('keydown', (dynamic event) {
      if (event.code == 'Tab') {
        event.preventDefault();
      }
    });
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text(
              'UOM',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: appbarcolor,
          centerTitle: true,
        ),
        body: Container(
          //     padding: EdgeInsets.all(10),
          height: maxheight,
          width: maxwidth,
          color: bodycolor,
          child: Expanded(
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      //flex: 2,
                      child: FractionallySizedBox(
                          widthFactor: 0.9,
                          heightFactor: 0.6,
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
                                            "Enter UOM Details",
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
                                            // child: RawKeyboardListener(
                                            //   onKey: (dynamic key) {
                                            //     if (key.data.key == "Tab") {
                                            //       // FocusScope.of(context)
                                            //       //     .requestFocus(_add1Focus);
                                            //     }
                                            //   },
                                            //   focusNode: _nameFocus,
                                            child: TextField(
                                              focusNode: _nameFocus,
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
                                              // focusNode: custidFocusNode,

                                              readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
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
                                            // child: RawKeyboardListener(
                                            //   onKey: (dynamic key) {
                                            //     if (key.data.key == "Tab") {
                                            //       // FocusScope.of(context)
                                            //       //     .requestFocus(_add1Focus);
                                            //     }
                                            //   },
                                            //   focusNode: _nameFocus,
                                            child: TextField(
                                              focusNode: _noofdecimalFocus,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: widgetcolor),
                                                  ),
                                                  border: InputBorder.none,
                                                  //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                  labelText: "No of Decimal",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller:
                                                  _custnoofdecimalController,
                                              // focusNode: custidFocusNode,

                                              readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
                                          ),

                                          //),
                                          // ]),
                                        ]),
                                  ))))),
                  SizedBox(height: 20),
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      // heightFactor: 0.3,
                      child: Container(
                          child: Row(children: <Widget>[
                        Spacer(),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: RaisedButton(
                              onPressed: () async {
                                if ((_id != "") &&
                                    (_id != null) &&
                                    (_id != "0")) {
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
                                  var convertDataToJson =
                                      json.decode(response.body);
                                  setState(() {
                                    enable = true;
                                  });
                                  if (convertDataToJson[0].toString().contains(
                                      "Already Exists: Already Exists")) {
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
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                ShowAddWidget = false;
                                              });
                                              //clearData(context);
                                              Navigator.of(context,
                                                      rootNavigator: true)
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
                                  Image.asset('Images/save.png',
                                      color: Colors.black),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "SAVE",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              color: widgetcolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0))),
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
                                  Image.asset('Images/cancel.png',
                                      color: Colors.black),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "CANCEL",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              color: widgetcolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0))),
                          padding:
                              EdgeInsets.only(top: 5, bottom: 5, right: 10),
                        )
                      ])),
                    ),
                  ),
                ] // )
                ),
          ),
        ));
  }

  void saveItems() async {
    String custId = _custIdController.text;
    String custName = _custNameController.text;
    String noofdecimal = _custnoofdecimalController.text;

    if (custId != '' && custName != '') {
      try {
        Stream<String> stream =
            await insertUom(custId, noofdecimal, custName, "0");
        stream.asBroadcastStream().listen((String message) {
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
    _custNameController.text = '';
    _custnoofdecimalController.text = '';
    _id = '0';
    enable = false;
    _nameFocus.requestFocus();
  }

  List<master.Uom> data = new List<master.Uom>();

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

  Future<master.Uom> getAddCustomerJson() async {
    String customerurl;

    if (searchtext == '' || searchtext == null) {
      customerurl =
          'http://tap.suninfotechnologies.in/api/touch?&Mode=uom&spname=GetAndSubmituommaster&intOrgID=1&intUserID=1&intflag=4' +
              '&pagesize=10&pagenumber=1&intuomMasterid=' +
              _id +
              '';
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
    List<master.Uom> customer1 = new List<master.Uom>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    customer1 =
        parsed.map<master.Uom>((json) => master.Uom.fromJSON(json)).toList();
    data = customer1;
    if (_id != "" && _id != "" && _id != null)
      customer1
          .where((element) => element.columnMasterid == _id)
          .forEach((element) => setState(() {
                masterid = element.columnMasterid;
                _custNameController.text = element.columnname;
                _custnoofdecimalController.text = element.noofDecimal;
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
    //getGroupMaster('');
    setState(() {
      getAddCustomerJson();
      if ((_id != "") && (_id != null) && (_id != "0"))
        _custIdController.text = _id.toString();
    });

    super.initState();
    _nameFocus = FocusNode();
    _noofdecimalFocus = FocusNode();
  }

  PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  void dispose() {
    _custnoofdecimalController.dispose();
    _nameFocus.dispose();
    _noofdecimalFocus.dispose();
    _custNameController.dispose();
    _custIdController.dispose();
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
      return new Container(
        color: bodycolor,
        child: Container(
          //color: Colors.white,
          width: maxwidth, // * .40,
          height: maxheight,
          padding: EdgeInsets.all(50),

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
                      child: Text("No of Decimal",
                          textScaleFactor: 1.7,
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                            color: widgetcolor,
                          )),
                    ),
                    Spacer(),
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
              //padding: EdgeInsets.all(5)
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
        ),
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
                  )
                ])),
            watch: (BuildContext context) => Container(color: Colors.purple),
          );
        })); //);
  }

  List<master.Uom> _customers;
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
            "https://cors-anywhere.herokuapp.com/http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&Mode=UOM&spname=GetAndSubmitUomMaster&intflag=4&intOrgID=1&intUserID=1" +
                "&pagesize=" +
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
      print(customerurl);
      var response = await http.get(Uri.encodeFull(customerurl),
          headers: {"Accept": "application/json"});
      print(response);
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
          parsed.map<master.Uom>((json) => master.Uom.fromJSON(json)).toList();

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
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '    ' +
                                  _reportItems[index]
                                      .columnname
                                      .toLowerCase()
                                      .toString(),
                              textScaleFactor: 1.3,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '    ' +
                                  _reportItems[index]
                                      .noofDecimal
                                      .toLowerCase()
                                      .toString(),
                              textScaleFactor: 1.3,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                              //width: maxwidth * .20,
                              child: Row(children: [
                            new IconButton(
                              alignment: Alignment.bottomRight,
                              icon: Image.asset('Images/edit.png',
                                  color: widgetcolor),
                              onPressed: () {
                                setState(() {
                                  ShowAddWidget = true;
                                  String id =
                                      _reportItems[index].columnMasterid;
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
                            SizedBox(width: 3),
                            // Spacer(),
                            new IconButton(
                              alignment: Alignment.bottomRight,
                              icon: Image.asset('Images/delete.png',
                                  color: widgetcolor),
                              onPressed: () async {
                                String id = _reportItems[index].columnMasterid;

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
                                                  await insertUom(
                                                      id, "", "", "1");
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
}
