import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:touchwoodapp/repository/cutomer_repository.dart';
import 'package:touchwoodapp/widgets/custom_drawer.dart' as drawer;
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:touchwoodapp/models/customer.dart' as customer;
import 'package:touchwoodapp/screens/dashboard.dart';
import 'package:dio/dio.dart';
import 'package:touchwoodapp/models/partytype.dart' as type;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:touchwoodapp/repository/assigncolor.dart';
import 'package:responsive_builder/responsive_builder.dart';

String selectedcustomer;
String custselectedtype;
int custpageno;
String typeid;
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
ProgressDialog pr;
FocusNode custidFocusNode;
double maxwidth;
double maxheight;

class AddCustomer extends StatefulWidget {
  static const String routeName = '/AddParty';
  String id;
  double pmaxwidth;
  double pmaxheight;

  String selectedType;
  int pageNo;
  String searchtext;
  AddCustomer(
      {Key key,
      this.title,
      this.id,
      this.selectedType,
      this.pageNo,
      this.searchtext,
      this.pmaxwidth,
      this.pmaxheight})
      : super(key: key);

  final String title;
  String get custid {
    _id = id;

    custselectedtype = selectedType;
    custpageno = pageNo;
    maxwidth = pmaxwidth;
    maxheight = pmaxheight;
    return id;
  }

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

bool enable = false;

class _AddCustomerPageState extends State<AddCustomer> {
  @override
  void initState() {
    super.initState();
    //clearData(context);
    custidFocusNode = FocusNode();
    _custIdController.text = '0';
    getGroupMaster('');
    setState(() {
      getCustomerJson();
      if ((_id != "") && (_id != null) && (_id != "0"))
        _custIdController.text = _id.toString();
    });
  }

  List<customer.Customer> data = new List<customer.Customer>();

  Future<List<type.Customer>> getGroupMaster(String filter) async {
    setState(() {
      typedetails = [];
      typedata = [];
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
      typedetails = parsed
          .map<type.Customer>((json) => type.Customer.fromJSON(json))
          .toList();

      if (filter != "")
        typedetails = typedetails
            .where((element) => element.ptyname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      typedata = typedetails.map((e) => e.ptyname).toList();
      if (typeid == '' || typeid == null || typeid == '0')
        selectedcustomer = typedata.first;

      typeid = typeid = typedetails
          .where((element) => element.ptyname == selectedcustomer)
          .map((e) => e.partyid)
          .first
          .toString();
    });

    return typedetails;
  }

  Future<customer.Customer> getCustomerJson() async {
    String customerurl;

    if (widget.searchtext == '' || widget.searchtext == null) {
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
              widget.searchtext;
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
              }));
  }

  @override
  void dispose() {
    _custRemarksController.dispose();
    _custMobileController.dispose();
    _custNameController.dispose();
    _custAdd1Controller.dispose();
    _custAdd2Controller.dispose();
    _custAdd3Controller.dispose();
    _custAdd4Controller.dispose();
    _custIdController.dispose();
    _custGstinController.dispose();
    _custEmailController.dispose();
    custidFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //initRelativeScaler(context);

    UnderlineInputBorder underlineInputBorder =
        new UnderlineInputBorder(borderSide: BorderSide(color: widgetcolor));
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return MaterialApp(
      title: 'Sun Party',
      theme: new ThemeData(
        brightness: Brightness.light,
        //primaryColor: Colors.blas,
        //accentColor: Colors.blue,
      ),
      home: Container(
          width: maxwidth,
          height: maxheight,
          child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndDocked,
              floatingActionButton: FloatingActionButton(
                backgroundColor: widgetcolor,
                onPressed: () {},
                tooltip: 'Add new customer entry',
                child: IconButton(
                    icon: Image.asset('images/add.png', color: Colors.black),
                    onPressed: () {}),
              ),
              // drawer: drawer.CustomDrawer(),
              appBar: AppBar(
                //  titleSpacing: 0.2,
                // leading: Builder(
                //   builder: (BuildContext context) {
                //     return IconButton(
                //       icon: Image.asset(
                //         'images/menu.png',
                //         color: widgetcolor,
                //       ),
                //       onPressed: () {
                //         Scaffold.of(context).openDrawer();
                //       },
                //       tooltip:
                //           MaterialLocalizations.of(context).openAppDrawerTooltip,
                //     );
                //   },
                // ),
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: EdgeInsets.only(
                    bottom: 30,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                backgroundColor: appbarcolor,
                centerTitle: true,
              ),

              // bottomNavigationBar: bottomapp(maxwidth, maxheight),
              body: Container(
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
                                                "Enter Customer Details",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),

                                              // Wrap(
                                              //     alignment: WrapAlignment.start,
                                              //     spacing: 150,
                                              //     //   runSpacing: 200,
                                              //children: [
                                              if (typedata != null &&
                                                  typedata.isNotEmpty)
                                                Container(
                                                  constraints: BoxConstraints(
                                                    minWidth: 200,
                                                    maxWidth: 380,
                                                  ),
                                                  //padding: EdgeInsets.,
                                                  width:
                                                      maxwidth * .7, //* 0.50,
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
                                                    items: typedata,
                                                    label: "Type *",
                                                    showClearButton: false,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        selectedcustomer = val;

                                                        typeid = typedetails
                                                            .where((element) =>
                                                                element
                                                                    .ptyname ==
                                                                val)
                                                            .map((e) =>
                                                                e.partyid)
                                                            .first
                                                            .toString();
                                                      });
                                                    },
                                                    popupItemDisabled:
                                                        (String s) =>
                                                            s.startsWith('I'),
                                                    selectedItem:
                                                        selectedcustomer,
                                                  ),
                                                ),

                                              // Wrap(spacing: 20, children: [

                                              // Text.rich('/'),
                                              // TextField(controller:  'Name'),
                                              Container(
                                                constraints: BoxConstraints(
                                                  //minHeight: 20,
                                                  minWidth: 300,
                                                  maxWidth: 300,
                                                ),
                                                width: maxwidth * .7,
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
                                                          //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                          labelText: "Name",
                                                          labelStyle: TextStyle(
                                                              fontSize: 20.0)),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  style: textStyle,
                                                  controller:
                                                      _custNameController,
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
                                                  controller:
                                                      _custAdd1Controller,
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
                                                  controller:
                                                      _custAdd2Controller,
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
                                                  controller:
                                                      _custAdd3Controller,
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
                                                  controller:
                                                      _custAdd4Controller,
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
                                              Container(
                                                constraints: BoxConstraints(
                                                  minWidth: 300,
                                                  maxWidth: 300,
                                                ),
                                                width: maxwidth * .7,
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
                                                          labelText: "GSTIN",
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
                                              Container(
                                                constraints: BoxConstraints(
                                                  //minHeight: 20,
                                                  minWidth: 300,
                                                  maxWidth: 380,
                                                  //maxHeight: double.infinity
                                                ),
                                                width: maxwidth * .7,
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
                                              Container(
                                                constraints: BoxConstraints(
                                                  //  minHeight: 20,
                                                  minWidth: 300,
                                                  maxWidth: 700,
                                                ),
                                                width: maxwidth * .8,
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
              )),
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
                              var convertDataToJson =
                                  json.decode(response.body);
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
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () {
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

                            Navigator.pop(context, () {
                              setState(() {});
                            });
                            Navigator.pop(context, () {
                              setState(() {});
                            });
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
                              borderRadius: new BorderRadius.circular(10.0))),
                      padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
                    )
                  ])))),
    );
  }

  void saveItems() async {
    String custId = _custIdController.text;
    String custName = _custNameController.text;
    String custMobile = _custMobileController.text;
    // String custRemarks = _custRemarksController.text;
    String custGstin = _custGstinController.text;
    String custAdd1 = _custAdd1Controller.text;
    String custAdd2 = _custAdd2Controller.text;
    String custAdd3 = _custAdd3Controller.text;
    String custAdd4 = _custAdd4Controller.text;
    String custemail = _custEmailController.text;
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
            custAdd4,
            custGstin,
            custemail,
            "",
            selectedcustomer,
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
    _custIdController.text = '0';
    _custNameController.text = '';
    _custAdd1Controller.text = '';
    _custAdd2Controller.text = '';
    _custAdd3Controller.text = '';
    _custAdd4Controller.text = '';
    _custEmailController.text = '';
    _custGstinController.text = '';
    _custMobileController.text = '';
    _custRemarksController.text = '';
    _id = '0';
    // Navigator.pop(context);
    //  FocusScope.of(context).requestFocus(custidFocusNode);
  }
}
