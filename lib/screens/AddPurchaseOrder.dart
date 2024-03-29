import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:touchwoodapp/models/Master.dart' as master;
import 'package:touchwoodapp/models/customer.dart';
import 'package:touchwoodapp/models/Paging.dart';

import 'package:touchwoodapp/screens/AddYarn.dart';
import 'package:touchwoodapp/widgets/collapsing_navigation_drawer_widget.dart'
    as drawer;
import 'package:touchwoodapp/repository/cutomer_repository.dart';
//import 'package:touchwoodapp/screens/AddCustomer.dart' as Addparty;
import 'dart:convert';
import 'package:touchwoodapp/models/PurchaseOrder.dart' as purchaseorderdetl;
import 'dart:core';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:touchwoodapp/repository/assigncolor.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:touchwoodapp/models/customer.dart' as customer;
import 'package:touchwoodapp/models/partytype.dart' as type;
import 'package:touchwoodapp/models/uom.dart' as uom;
import 'package:dropdown_search/dropdown_search.dart';

void main() => runApp(new MaterialApp(
      home: new HomePage(),
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
    ));
PageController controller = PageController();
List<purchaseorderdetl.PurchaseOrderHeader> _reportItems =
    <purchaseorderdetl.PurchaseOrderHeader>[];

List<purchaseorderdetl.PurchaseOrderHeader> data =
    <purchaseorderdetl.PurchaseOrderHeader>[];

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
FocusNode focusnoofbox;
String searchtext;

String selectedcompany;
String selectedcurrency;
String custselectedtype;
String selectedfabric;
String selectedcolor;
String selecteddia;
String selecteduom;
String selectedfabtype;
String selectedfabknittype;
String selectedcomposition;
String selectedportofdischarge;
String selectedshipmentmode;
String selectedportofload;
int custpageno;
String compid;
String currencyid;
String supplierid;
String notifypartyid;
String prodtypeid;
String selectedsupplier;
String selectednotifyparty;
String selectedprodtype;
String fabricid;
String fabtypeid;
String fabknittypeid;
String compositionid;
String colorid;
String diaid;
String yarntypeid;
String uomid;
String consigneeid;
String portofdischargeid;
String selectedconsignee;
String portofloadid;
String shipmentmodeid;

String labeltext = new Text("", style: TextStyle(fontSize: 20)).toString();

GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<customer.Customer>>();
String _id = "";
TextStyle textStyle = new TextStyle(color: Colors.black);
GlobalKey<AutoCompleteTextFieldState<customer.Customer>> custKey =
    new GlobalKey();
AutoCompleteTextField<customer.Customer> textField;
List<type.Customer> companydetails = <type.Customer>[];
List<master.Master> currencydetails = <master.Master>[];
List<master.Master> prodtypedetails = <master.Master>[];
List<Customer> consigneedetails = <Customer>[];
List<master.Master> fabricdetails = <master.Master>[];
List<master.Master> fabrictypetypedetails = <master.Master>[];
List<master.Master> fabricknittypedetails = <master.Master>[];
//List<master.Master> fabricknittypedetails = <master.Master>[];
List<purchaseorderdetl.PurchaseOrderDetails> details =
    <purchaseorderdetl.PurchaseOrderDetails>[];
List<purchaseorderdetl.PurchaseOrderDetails> _itemdetails = [];
purchaseorderdetl.PurchaseOrderDetails _previousitem;
List<master.Master> colordetails = <master.Master>[];
List<master.Master> diadetails = <master.Master>[];
List<uom.Uom> uomdetails = <uom.Uom>[];
List<master.Master> compositiondetails = <master.Master>[];
List<customer.Customer> notifypartydetails = <customer.Customer>[];
List<customer.Customer> supplierdetails = <customer.Customer>[];
List<master.Master> portofdischargedetails = <master.Master>[];
List<master.Master> shipmentmodedetails = <master.Master>[];
List<master.Master> portofloaddetails = <master.Master>[];

List<String> companydata = [];
List<String> supplierdata = [];
List<String> currencydata = [];
List<String> notifypartydata = [];
List<String> yarncountdata = [];
List<String> yarnmilldata = [];
List<String> yarncolordata = [];
List<String> yarntypedata = [];
List<String> fabricdata = [];
List<String> consigneedata = [];
List<String> fabrictypedata = [];
List<String> fabricknitdata = [];
List<String> diadata = [];
List<String> colordata = [];
List<String> uomdata = [];
List<String> compositiondata = [];
List<String> prodtypedata = [];
List<String> portofloaddata = [];
List<String> shipmentmodedata = [];
List<String> portofdischargedata = [];
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
final _custgsmController = TextEditingController();
final _custnoofboxController = TextEditingController();
final _custkgsperboxController = TextEditingController();
final _custweightController = TextEditingController();
final _custyarntypeController = TextEditingController();
final _custrateController = TextEditingController();
final _custamountController = TextEditingController();
final _custtermsandconditionsController = TextEditingController();
final _custtermsandconditionsController2 = TextEditingController();
final _custtermsandconditionsController3 = TextEditingController();
final _custtermsandconditionsController4 = TextEditingController();
final _custtermsandconditionsController5 = TextEditingController();
final _custtermsandconditionsController6 = TextEditingController();
final _custtermsandconditionsController7 = TextEditingController();
final _custtermsandconditionsController8 = TextEditingController();
final _custnoofcontainerController = TextEditingController();
final _custpackingdetailController = TextEditingController();
final _custpaymenttermsController = TextEditingController();
final _custremarksController = TextEditingController();

ProgressDialog pr;
FocusNode custidFocusNode;
double maxwidth;
double maxheight;
TextEditingController dateCtl = TextEditingController();
TextEditingController shipmentdateCtl = TextEditingController();
var seldate;
var selshipmentdate;
bool enable = false;

class HomePage extends StatefulWidget {
  final String selectedType;
  final int pageNo;
  HomePage({this.selectedType, this.pageNo});

  String get custid {
    selectedtype = selectedType;
    pageno = pageNo;
    return '';
  }

  @override
  HomePageState createState() => new HomePageState();
}

GlobalKey _keyRed = GlobalKey();
double xaxis;
String selamount;

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}

class HomePageState extends State<HomePage> {
  String selectedyarnmill;
//String selectedyarncolor;
  String selectedyarntype;
  String selectedyarncount;
  _getPositions() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);

    setState(() {
      xaxis = positionRed.dx;
    });
    print("POSITION of Red: $positionRed ");
  }

  Widget addcustomerwid(double maxwidth, double maxheight) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text(
              'Purchase Order',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: appbarcolor,
          centerTitle: true,
        ),
        body: Container(
            height: maxheight,
            width: maxwidth,
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
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Container(
                            height: 190,
                            width: maxwidth,
                            margin: EdgeInsets.only(top: 0),

                            padding: EdgeInsets.all(
                                2), // decoration: BoxDecoration(border: ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // if (companydata != null &&
                                          //     companydata.isNotEmpty)
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 200,
                                              maxWidth: 380,
                                            ),
                                            //padding: EdgeInsets.,
                                            width: maxwidth * .4, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Company",
                                              mode: Mode.MENU,
                                              enabled: (_id != null &&
                                                      _id != '' &&
                                                      _id != '0')
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
                                                          element.ptyname ==
                                                          val)
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
                                          SizedBox(height: 10),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 100,
                                              maxWidth: 250,
                                            ),
                                            width: maxwidth * .3,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: widgetcolor),
                                                  ),
                                                  border: InputBorder.none,
                                                  //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                  labelText: "PO No",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType.text,
                                              style: textStyle,
                                              controller: _custPONoController,
                                              focusNode: custidFocusNode,

                                              readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 100,
                                              maxWidth: 200,
                                            ),
                                            width: maxwidth * .3,
                                            child: TextFormField(
                                              //enabled: false,
                                              controller: dateCtl,
                                              decoration: InputDecoration(
                                                labelText: "Date",
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: widgetcolor),
                                                ),
                                                border: InputBorder.none,
                                                hintText:
                                                    "Ex. Insert your date",
                                              ),
                                              onTap: () async {
                                                DateTime date = DateTime(1900);
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());

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
                                                          "${today.year.toString()}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}";

                                                      dateCtl.text =
                                                          "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year.toString()}";
                                                    }
                                                    //  seldate; //date.toIso8601String();
                                                  });
                                              },
                                            ),
                                          ),
                                        ]),
                                    // ),
                                    flex: 2),
                                SizedBox(width: 20),
                                Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // if (consigneedata != null &&
                                        //     consigneedata.isNotEmpty)
                                        Container(
                                          constraints: BoxConstraints(
                                            minWidth: 100,
                                            maxWidth: 300,
                                          ),
                                          //padding: EdgeInsets.,
                                          width: maxwidth * .3, //* 0.50,
                                          child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Consignee",
                                              mode: Mode.MENU,
                                              enabled: (_id != null &&
                                                      _id != '' &&
                                                      _id != '0')
                                                  ? false
                                                  : true,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: consigneedata,
                                              label: "Consignee *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedconsignee = val;

                                                  consigneeid = consigneedetails
                                                      .where((element) =>
                                                          element
                                                              .customerName ==
                                                          val)
                                                      .map((e) => e.custId)
                                                      .first
                                                      .toString();
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem: selectedconsignee),
                                        ),
                                        SizedBox(height: 10),
                                        // if (notifypartydata != null &&
                                        //     notifypartydata.isNotEmpty)
                                        Container(
                                          constraints: BoxConstraints(
                                            minWidth: 100,
                                            maxWidth: 300,
                                          ),
                                          //padding: EdgeInsets.,
                                          width: maxwidth * .3, //* 0.50,
                                          child: DropdownSearch<String>(
                                            dropDownButton: Image.asset(
                                                'Images/arrow_drop_down.png',
                                                color: Colors.white),
                                            validator: (v) => v == null
                                                ? "required field"
                                                : null,
                                            hint: "Select a Notify Party",
                                            mode: Mode.MENU,
                                            enabled: (_id != null &&
                                                    _id != '' &&
                                                    _id != '0')
                                                ? false
                                                : true,
                                            showSelectedItem: true,
                                            showSearchBox: true,
                                            items: notifypartydata,
                                            label: "Notify Party *",
                                            showClearButton: false,
                                            onChanged: (val) {
                                              setState(() {
                                                selectednotifyparty = val;

                                                notifypartyid =
                                                    notifypartydetails
                                                        .where((element) =>
                                                            element
                                                                .customerName ==
                                                            val)
                                                        .map((e) => e.custId)
                                                        .first
                                                        .toString();
                                              });
                                            },
                                            popupItemDisabled: (String s) =>
                                                s.startsWith('I'),
                                            selectedItem: selectednotifyparty,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // if (supplierdata != null &&
                                        //     supplierdata.isNotEmpty)
                                        Container(
                                          constraints: BoxConstraints(
                                            minWidth: 100,
                                            maxWidth: 300,
                                          ),
                                          //padding: EdgeInsets.,
                                          width: maxwidth * .3, //* 0.50,
                                          child: DropdownSearch<String>(
                                            dropDownButton: Image.asset(
                                                'Images/arrow_drop_down.png',
                                                color: Colors.white),
                                            validator: (v) => v == null
                                                ? "required field"
                                                : null,
                                            hint: "Select a Supplier",
                                            mode: Mode.MENU,
                                            enabled: (_id != null &&
                                                    _id != '' &&
                                                    _id != '0')
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
                                                        element.customerName ==
                                                        val)
                                                    .map((e) => e.custId)
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
                                      ],
                                    ),
                                    flex: 2),
                                Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // if (currencydata != null &&
                                          //     currencydata.isNotEmpty)
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 300,
                                            ),
                                            //padding: EdgeInsets.,
                                            width: maxwidth * .3, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Currency",
                                              mode: Mode.MENU,
                                              enabled: (_id != null &&
                                                      _id != '' &&
                                                      _id != '0')
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
                                                          element.columnname ==
                                                          val)
                                                      .map((e) =>
                                                          e.columnMasterid)
                                                      .first
                                                      .toString();
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem: selectedcurrency,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 200,
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
                                              // enabled: (_id != null &&
                                              //         _id != '' &&
                                              //         _id != '0')
                                              //     ? false
                                              //     : true,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: prodtypedata,
                                              label: "Type *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedprodtype = val;

                                                  prodtypeid = prodtypedetails
                                                      .where((element) =>
                                                          element.columnname ==
                                                          val)
                                                      .map((e) =>
                                                          e.columnMasterid)
                                                      .first
                                                      .toString();

                                                  if (selectedprodtype
                                                          .toString()
                                                          .toLowerCase() ==
                                                      'fabric') {
                                                    getfabricdetails('');
                                                    getfabknittypedetails('');
                                                    getcolordetails('');
                                                    getdiadetails('');
                                                    getuomdetails('');
                                                    getcompositiondetails('');
                                                    getfabrictypedetails('');
                                                  }

                                                  if (selectedprodtype
                                                          .toString()
                                                          .toLowerCase() ==
                                                      'yarn') {
                                                    getyarncountdetails('');
                                                    getyarntypedetails('');
                                                    getyarnmilldetails('');
                                                    getcolordetails('');
                                                  }
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem:
                                                  selectedprodtype.toString() ==
                                                          ''
                                                      ? prodtypedata.first
                                                      : selectedprodtype,
                                            ),
                                          ),
                                        ]),
                                    flex: 1),
                              ],
                            ),
                          ),
                          color: Colors.white70,
                        ),

                        SizedBox(height: 10),
                        Text('Details'),
                        SizedBox(height: 10),
                        Container(
                            height: 130,
                            padding: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.black),
                            ),
                            child: Column(children: [
                              Expanded(
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      if (selectedprodtype
                                              .toString()
                                              .toLowerCase() ==
                                          'fabric')
                                        Row(children: [
                                          SizedBox(width: 10),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 150,
                                            ),
                                            width: maxwidth * .7, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Fabric",
                                              mode: Mode.MENU,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: fabricdata,
                                              label: "Fabric *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedfabric = val;

                                                  fabricid = fabricdetails
                                                      .where((element) =>
                                                          element.columnname ==
                                                          val)
                                                      .map((e) =>
                                                          e.columnMasterid)
                                                      .first
                                                      .toString();
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem: selectedfabric,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 150,
                                            ),
                                            width: maxwidth * .7, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Fabric type",
                                              mode: Mode.MENU,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: fabrictypedata,
                                              label: "Fabric Type*",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedfabtype = val;

                                                  fabtypeid =
                                                      fabrictypetypedetails
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
                                              selectedItem: selectedfabtype,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 150,
                                            ),
                                            width: maxwidth * .7, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Fabric Knit type",
                                              mode: Mode.MENU,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: fabricknitdata,
                                              label: "Fabric Knit Type *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedfabknittype = val;

                                                  fabknittypeid =
                                                      fabricknittypedetails
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
                                              selectedItem: selectedfabknittype,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 150,
                                            ),
                                            width: maxwidth * .7, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint:
                                                  "Select a Fabric Composition",
                                              mode: Mode.MENU,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: compositiondata,
                                              label: "Fabric Composition *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedcomposition = val;

                                                  compositionid = compositiondetails
                                                      .where((element) =>
                                                          element.columnname ==
                                                          val)
                                                      .map((e) =>
                                                          e.columnMasterid)
                                                      .first
                                                      .toString();
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem: selectedcomposition,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          // if (diadata != null &&
                                          //     diadata.isNotEmpty)
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 100,
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
                                              hint: "Select a Dia",
                                              mode: Mode.MENU,
                                              // enabled: (_id != null &&
                                              //         _id != '' &&
                                              //         _id != '0')
                                              //     ? false
                                              //     : true,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: diadata,
                                              label: "Dia *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selecteddia = val;

                                                  diaid = diadetails
                                                      .where((element) =>
                                                          element.columnname ==
                                                          val)
                                                      .map((e) =>
                                                          e.columnMasterid)
                                                      .first
                                                      .toString();
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem: selecteddia,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          // if (colordata != null &&
                                          //     colordata.isNotEmpty)
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 100,
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
                                              // enabled: (_id != null &&
                                              //         _id != '' &&
                                              //         _id != '0')
                                              //     ? false
                                              //     : true,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: colordata,
                                              label: "Color*",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedcolor = val;

                                                  colorid = colordetails
                                                      .where((element) =>
                                                          element.columnname ==
                                                          val)
                                                      .map((e) =>
                                                          e.columnMasterid)
                                                      .first
                                                      .toString();
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem: selectedcolor,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          // if (uomdata != null &&
                                          //     uomdata.isNotEmpty)
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 70,
                                              maxWidth: 100,
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
                                              // enabled: (_id != null &&
                                              //         _id != '' &&
                                              //         _id != '0')
                                              //     ? false
                                              //     : true,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: uomdata,
                                              label: "Uom *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selecteduom = val;

                                                  uomid = uomdetails
                                                      .where((element) =>
                                                          element.columnname ==
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
                                        ]),
                                      if (selectedprodtype
                                              .toString()
                                              .toLowerCase() ==
                                          'yarn')
                                        Row(children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // if (yarncountdata != null &&
                                          //     yarncountdata.isNotEmpty)
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 150,
                                            ),
                                            //padding: EdgeInsets.,
                                            width: maxwidth * 0.08, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a YarnCount",
                                              mode: Mode.MENU,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: yarncountdata,
                                              label: "Yarn Count *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedyarncount =
                                                      val.toString();

                                                  yarncountid = yarncountdetails
                                                      .where((element) =>
                                                          element.columnname ==
                                                          val)
                                                      .map((e) =>
                                                          e.columnMasterid)
                                                      .first
                                                      .toString();
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem: selectedyarncount,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          // if (yarnmilldata != null &&
                                          //     yarnmilldata.isNotEmpty)
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 200,
                                            ),
                                            //padding: EdgeInsets.,
                                            width: maxwidth * 0.15, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Yarn Mill",
                                              mode: Mode.MENU,
                                              // enabled: (_id != null &&
                                              //         _id != '' &&
                                              //         _id != '0')
                                              //     ? false
                                              //     : true,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: yarnmilldata,
                                              label: "Yarn Mill*",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedyarnmill = val;

                                                  yarnmillid = yarnmilldetails
                                                      .where((element) =>
                                                          element.columnname ==
                                                          val)
                                                      .map((e) =>
                                                          e.columnMasterid)
                                                      .first
                                                      .toString();
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem: selectedyarnmill,
                                            ),
                                          ),
                                          SizedBox(width: 10),

                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 250,
                                            ),
                                            //padding: EdgeInsets.,
                                            width: maxwidth * 0.15, //* 0.50,
                                            child: DropdownSearch<String>(
                                              searchBoxController:
                                                  _custyarntypeController,
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Yarn type",
                                              mode: Mode.MENU,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: yarntypedata,
                                              label: "Yarn Type *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                if (this.mounted)
                                                  setState(() {
                                                    _custyarntypeController
                                                        .text = val;

                                                    yarntypeid = yarntypedetails
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
                                              selectedItem:
                                                  _custyarntypeController.text,
                                            ),
                                          ),
                                          SizedBox(width: 10),

                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 250,
                                            ),
                                            //padding: EdgeInsets.,
                                            width: maxwidth * 0.15, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Color",
                                              mode: Mode.MENU,
                                              // enabled: (_id != null &&
                                              //         _id != '' &&
                                              //         _id != '0')
                                              //     ? false
                                              //     : true,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: colordata,
                                              label: "Color*",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedcolor = val;

                                                  colorid = colordetails
                                                      .where((element) =>
                                                          element.columnname ==
                                                          val)
                                                      .map((e) =>
                                                          e.columnMasterid)
                                                      .first
                                                      .toString();
                                                });
                                              },
                                              popupItemDisabled: (String s) =>
                                                  s.startsWith('I'),
                                              selectedItem: selectedcolor,
                                            ),
                                          ),
                                          SizedBox(width: 10),

                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 100,
                                              maxWidth: 120,
                                            ),
                                            width: maxwidth * .08,
                                            child: RawKeyboardListener(
                                              focusNode: focusnoofbox,
                                              onKey: _handleKeyEvent,
                                              child: TextFormField(
                                                onChanged: (val) {},
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),

                                                inputFormatters: [
                                                  DecimalTextInputFormatter(
                                                      decimalRange: 2)
                                                ],
                                                textAlign: TextAlign.right,
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

                                                        labelText: "No of Box",
                                                        labelStyle: TextStyle(
                                                            fontSize: 20.0)),

                                                style: textStyle,
                                                controller:
                                                    _custnoofboxController,
                                                // focusNode: custidFocusNode,

                                                //   readOnly: enable,
                                                //enableInteractiveSelection: enable,
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: 10),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 100,
                                              maxWidth: 100,
                                            ),
                                            width: maxwidth * .7,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: widgetcolor),
                                                  ),
                                                  border: InputBorder.none,
                                                  //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                  labelText: "Kgs/Box",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),

                                              inputFormatters: [
                                                DecimalTextInputFormatter(
                                                    decimalRange: 3)
                                              ],
                                              textAlign: TextAlign.right,
                                              style: textStyle,
                                              controller:
                                                  _custkgsperboxController,
                                              //     focusNode: custidFocusNode,

                                              //  readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 100,
                                            ),
                                            width: maxwidth * .7,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: widgetcolor),
                                                  ),
                                                  border: InputBorder.none,
                                                  //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                  labelText: "Weight",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),

                                              inputFormatters: [
                                                DecimalTextInputFormatter(
                                                    decimalRange: 3)
                                              ],
                                              textAlign: TextAlign.right,
                                              style: textStyle,
                                              controller: _custweightController,
                                              //   focusNode: custidFocusNode,

                                              // readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 100,
                                            ),
                                            width: maxwidth * .7,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: widgetcolor),
                                                  ),
                                                  border: InputBorder.none,
                                                  //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                  labelText: "Rate",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),

                                              inputFormatters: [
                                                DecimalTextInputFormatter(
                                                    decimalRange: 2)
                                              ],
                                              textAlign: TextAlign.right,
                                              style: textStyle,
                                              controller: _custrateController,
                                              //focusNode: custidFocusNode,

                                              // readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 100,
                                            ),
                                            width: maxwidth * .7,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: widgetcolor),
                                                  ),
                                                  border: InputBorder.none,
                                                  //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                  labelText: "Amount",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),

                                              inputFormatters: [
                                                DecimalTextInputFormatter(
                                                    decimalRange: 2)
                                              ],
                                              textAlign: TextAlign.right,
                                              style: textStyle,
                                              controller: _custamountController,
                                              // focusNode: custidFocusNode,
                                              //readOnly: enable,
                                              //enableInteractiveSelection: enable,
                                            ),
                                          ),
                                        ]),
                                    ]),
                              ),
                              SizedBox(height: 5),
                              Expanded(
                                  child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  // SizedBox(height: 10),
                                  Row(children: [
                                    SizedBox(width: 10),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      Container(
                                        constraints: BoxConstraints(
                                          //minHeight: 20,
                                          minWidth: 100,
                                          maxWidth: 100,
                                        ),
                                        width: maxwidth * .7,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: widgetcolor),
                                              ),
                                              border: InputBorder.none,
                                              //disabledBorder: InputDecoration.collapsed(hintText: null),
                                              labelText: "GSM",
                                              labelStyle:
                                                  TextStyle(fontSize: 20.0)),
                                          keyboardType: TextInputType.text,
                                          style: textStyle,
                                          controller: _custgsmController,
                                          //   focusNode: custidFocusNode,

                                          //  readOnly: enable,
                                          //enableInteractiveSelection: enable,
                                        ),
                                      ),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      SizedBox(width: 20),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      Container(
                                        constraints: BoxConstraints(
                                          //minHeight: 20,
                                          minWidth: 100,
                                          maxWidth: 100,
                                        ),
                                        width: maxwidth * .7,
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),

                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2)
                                          ],
                                          textAlign: TextAlign.right,
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: widgetcolor),
                                              ),
                                              border: InputBorder.none,
                                              //disabledBorder: InputDecoration.collapsed(hintText: null),
                                              labelText: "No of Box",
                                              labelStyle:
                                                  TextStyle(fontSize: 20.0)),

                                          style: textStyle,
                                          controller: _custnoofboxController,
                                          // focusNode: custidFocusNode,

                                          //readOnly: enable,
                                          //enableInteractiveSelection: enable,
                                        ),
                                      ),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      SizedBox(width: 10),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      Container(
                                        constraints: BoxConstraints(
                                          //minHeight: 20,
                                          minWidth: 100,
                                          maxWidth: 100,
                                        ),
                                        width: maxwidth * .7,
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),

                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 3)
                                          ],
                                          textAlign: TextAlign.right,
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: widgetcolor),
                                              ),
                                              border: InputBorder.none,
                                              //disabledBorder: InputDecoration.collapsed(hintText: null),
                                              labelText: "Kgs/Box",
                                              labelStyle:
                                                  TextStyle(fontSize: 20.0)),

                                          style: textStyle,
                                          controller: _custkgsperboxController,
                                          //     focusNode: custidFocusNode,

                                          //readOnly: enable,
                                          //enableInteractiveSelection: enable,
                                        ),
                                      ),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      SizedBox(width: 10),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      Container(
                                        constraints: BoxConstraints(
                                          minWidth: 100,
                                          maxWidth: 100,
                                        ),
                                        width: maxwidth * .7,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: widgetcolor),
                                              ),
                                              border: InputBorder.none,
                                              //disabledBorder: InputDecoration.collapsed(hintText: null),
                                              labelText: "Weight",
                                              labelStyle:
                                                  TextStyle(fontSize: 20.0)),
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),

                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 3)
                                          ],
                                          textAlign: TextAlign.right,
                                          style: textStyle,
                                          controller: _custweightController,
                                          //   focusNode: custidFocusNode,

                                          //  readOnly: enable,
                                          //enableInteractiveSelection: enable,
                                        ),
                                      ),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      SizedBox(width: 10),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      Container(
                                        constraints: BoxConstraints(
                                          minWidth: 100,
                                          maxWidth: 100,
                                        ),
                                        width: maxwidth * .7,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: widgetcolor),
                                              ),
                                              border: InputBorder.none,
                                              //disabledBorder: InputDecoration.collapsed(hintText: null),
                                              labelText: "Rate",
                                              labelStyle:
                                                  TextStyle(fontSize: 20.0)),
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),

                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2)
                                          ],
                                          textAlign: TextAlign.right,
                                          style: textStyle,
                                          controller: _custrateController,
                                          //focusNode: custidFocusNode,

                                          //   readOnly: enable,
                                          //enableInteractiveSelection: enable,
                                        ),
                                      ),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      SizedBox(width: 20),
                                    if (selectedprodtype
                                            .toString()
                                            .toLowerCase() ==
                                        'fabric')
                                      Container(
                                        constraints: BoxConstraints(
                                          minWidth: 100,
                                          maxWidth: 100,
                                        ),
                                        width: maxwidth * .7,
                                        child: TextFormField(
                                          onChanged: (text) {
                                            if (text.indexOf(".0123456789") !=
                                                -1) {}
                                          },
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: widgetcolor),
                                              ),
                                              border: InputBorder.none,
                                              //disabledBorder: InputDecoration.collapsed(hintText: null),
                                              labelText: "Amount",
                                              labelStyle:
                                                  TextStyle(fontSize: 20.0)),
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),

                                          inputFormatters: [
                                            DecimalTextInputFormatter(
                                                decimalRange: 2)
                                          ],
                                          textAlign: TextAlign.right,
                                          style: textStyle,
                                          controller: _custamountController,
                                          // focusNode: custidFocusNode,
                                          //   readOnly: enable,
                                          //enableInteractiveSelection: enable,
                                        ),
                                      ),
                                  ])
                                ],
                              )),
                            ])),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Spacer(),
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: FloatingActionButton(
                                backgroundColor: widgetcolor,
                                heroTag: "btn1",

                                onPressed: () {
                                  if (this.mounted)
                                    setState(() {
                                      purchaseorderdetl.PurchaseOrderDetails
                                          _data;
                                      _data =
                                          getitemdetails(); //= <ItemMaster>[];

                                      if ((_itemdetails
                                              .where((e) =>
                                                  e.yarnmillid.toString() == _data.yarnmillid.toString() &&
                                                  e.yarntypeid.toString() ==
                                                      _data.yarntypeid
                                                          .toString() &&
                                                  e.yarncountid.toString() ==
                                                      _data.yarncountid
                                                          .toString() &&
                                                  e.colorid.toString() ==
                                                      _data.colorid.toString())
                                              .isEmpty) &&
                                          (selectedprodtype
                                                  .toString()
                                                  .toLowerCase() ==
                                              'yarn')) {
                                        _itemdetails.add(_data);

                                        selectedcolor = '';
                                        selecteddia = '';
                                        selecteduom = '';
                                        selectedfabric = '';
                                        selectedfabknittype = '';
                                        selectedcomposition = '';
                                        selectedfabtype = '';
                                        selectedyarnmill = '';
                                        selectedyarncount = '';
                                        selectedyarncolor = '';
                                        _custyarntypeController.text = '';
                                        _custgsmController.text = '';
                                        _custweightController.text = '';
                                        _custnoofboxController.text = '';
                                        _custrateController.text = '';
                                        _custamountController.text = '';
                                        _custkgsperboxController.text = '';
                                      }

                                      if (_itemdetails
                                              .where((e) =>
                                                  e.fabricid.toString() ==
                                                      _data.fabricid
                                                          .toString() &&
                                                  e.fabrictypeid.toString() ==
                                                      _data.fabrictypeid
                                                          .toString() &&
                                                  e.knittypeid.toString() ==
                                                      _data.knittypeid
                                                          .toString() &&
                                                  e.colorid.toString() ==
                                                      _data.colorid
                                                          .toString() &&
                                                  e.diaid.toString() ==
                                                      _data.diaid.toString() &&
                                                  e.uomid.toString() ==
                                                      _data.uomid.toString() &&
                                                  e.compositionid.toString() ==
                                                      _data.compositionid
                                                          .toString())
                                              .isEmpty &&
                                          (selectedprodtype
                                                  .toString()
                                                  .toLowerCase() ==
                                              'fabric')) {
                                        _itemdetails.add(_data);

                                        selectedcolor = '';
                                        selecteddia = '';
                                        selecteduom = '';
                                        selectedfabric = '';
                                        selectedfabknittype = '';
                                        selectedcomposition = '';
                                        selectedfabtype = '';
                                        selectedyarnmill = '';
                                        selectedyarncolor = '';
                                        _custyarntypeController.text = '';
                                        _custgsmController.text = '';
                                        _custweightController.text = '';
                                        _custnoofboxController.text = '';
                                        _custrateController.text = '';
                                        _custamountController.text = '';
                                        _custkgsperboxController.text = '';
                                      }
                                    });
                                },
                                //clearData(context);
                                //idFocusNode.dispose();
                                // },
                                tooltip: 'Add new Item ',
                                child: Image.asset('images/add.png',
                                    color: Colors.black),
                              )),
                          SizedBox(width: 10),
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: FloatingActionButton(
                                heroTag: "btn2",
                                backgroundColor: widgetcolor,
                                onPressed: () {
                                  setState(() {
                                    if (_previousitem != null)
                                      _itemdetails.add(_previousitem);
                                    selectedcolor = '';
                                    selectedyarnmill = '';
                                    selectedcolor = '';
                                    selectedyarntype = '';
                                    selecteddia = '';
                                    selecteduom = '';
                                    selectedfabric = '';
                                    selectedfabknittype = '';
                                    selectedcomposition = '';
                                    selectedfabtype = '';

                                    _custyarntypeController.text = '';
                                    _custgsmController.text = '';
                                    _custweightController.text = '';
                                    _custnoofboxController.text = '';
                                    _custrateController.text = '';
                                    _custamountController.text = '';
                                    _custkgsperboxController.text = '';
                                    _previousitem = null;
                                  });
                                },
                                tooltip: 'Cancel Item ',
                                child: Image.asset('Images/cancel.png',
                                    color: Colors.black),
                              )),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            decoration: getBoxDecoration(),
                            child: listtableView(maxwidth, maxheight, context)),
                        Container(
                          height: maxheight * .30,
                          width: maxwidth,
                          margin: EdgeInsets.only(top: 0),

                          padding: EdgeInsets.all(
                              2), // decoration: BoxDecoration(border: ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            //minHeight: 20,
                                            minWidth: 100,
                                            maxWidth: 200,
                                          ),
                                          width: maxwidth * .3,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: widgetcolor),
                                                ),
                                                border: InputBorder.none,
                                                //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                labelText:
                                                    "Total No.of Containers",
                                                labelStyle:
                                                    TextStyle(fontSize: 20.0)),
                                            keyboardType: TextInputType.text,
                                            style: textStyle,
                                            controller:
                                                _custnoofcontainerController,
                                            //   focusNode: custidFocusNode,
                                            readOnly: enable,
                                            //enableInteractiveSelection: enable,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // if (portofloaddata != null &&
                                        //     portofloaddata.isNotEmpty)
                                        Container(
                                          constraints: BoxConstraints(
                                            minWidth: 100,
                                            maxWidth: 300,
                                          ),
                                          //padding: EdgeInsets.,
                                          width: maxwidth * .2, //* 0.50,
                                          child: DropdownSearch<String>(
                                            dropDownButton: Image.asset(
                                                'Images/arrow_drop_down.png',
                                                color: Colors.white),
                                            validator: (v) => v == null
                                                ? "required field"
                                                : null,
                                            hint: "Select a Port of Load",
                                            mode: Mode.MENU,
                                            enabled: (_id != null &&
                                                    _id != '' &&
                                                    _id != '0')
                                                ? false
                                                : true,
                                            showSelectedItem: true,
                                            showSearchBox: true,
                                            items: portofloaddata,
                                            label: "Port of Loading *",
                                            showClearButton: false,
                                            onChanged: (val) {
                                              setState(() {
                                                selectedportofload = val;

                                                portofloadid = portofloaddetails
                                                    .where((element) =>
                                                        element.columnname ==
                                                        val)
                                                    .map(
                                                        (e) => e.columnMasterid)
                                                    .first
                                                    .toString();
                                              });
                                            },
                                            popupItemDisabled: (String s) =>
                                                s.startsWith('I'),
                                            selectedItem: selectedportofload,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          constraints: BoxConstraints(
                                            //minHeight: 20,
                                            minWidth: 100,
                                            maxWidth: 300,
                                          ),
                                          width: maxwidth * .3,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: widgetcolor),
                                                ),
                                                border: InputBorder.none,
                                                //disabledBorder: InputDecoration.collapsed(hintText: null),
                                                labelText: "Packing Detail",
                                                labelStyle:
                                                    TextStyle(fontSize: 20.0)),
                                            keyboardType: TextInputType.text,
                                            style: textStyle,
                                            controller:
                                                _custpackingdetailController,
                                            //   focusNode: custidFocusNode,

                                            readOnly: enable,
                                            //enableInteractiveSelection: enable,
                                          ),
                                        ),
                                      ]),
                                  // ),
                                  flex: 1),
                              SizedBox(width: 20),
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          //minHeight: 20,
                                          minWidth: 100,
                                          maxWidth: 600,
                                        ),
                                        width: maxwidth * .8,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: widgetcolor),
                                              ),
                                              border: InputBorder.none,
                                              //disabledBorder: InputDecoration.collapsed(hintText: null),
                                              labelText: "Payment Terms/LC",
                                              labelStyle:
                                                  TextStyle(fontSize: 20.0)),
                                          keyboardType: TextInputType.text,
                                          style: textStyle,
                                          controller:
                                              _custpaymenttermsController,
                                          //   focusNode: custidFocusNode,

                                          readOnly: enable,
                                          //enableInteractiveSelection: enable,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          // if (portofdischargedata != null &&
                                          //     portofdischargedata.isNotEmpty)
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 250,
                                            ),
                                            //padding: EdgeInsets.,
                                            width: maxwidth * .25, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint:
                                                  "Select a Port of Discharge",
                                              mode: Mode.MENU,
                                              enabled: (_id != null &&
                                                      _id != '' &&
                                                      _id != '0')
                                                  ? false
                                                  : true,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: portofdischargedata,
                                              label: "Port of Discharge *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedportofdischarge = val;

                                                  portofdischargeid =
                                                      portofdischargedetails
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
                                                  selectedportofdischarge,
                                            ),
                                          ),
                                          Spacer(),
                                          // if (shipmentmodedata != null &&
                                          //     shipmentmodedata.isNotEmpty)
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 100,
                                              maxWidth: 250,
                                            ),
                                            //padding: EdgeInsets.,
                                            width: maxwidth * .2, //* 0.50,
                                            child: DropdownSearch<String>(
                                              dropDownButton: Image.asset(
                                                  'Images/arrow_drop_down.png',
                                                  color: Colors.white),
                                              validator: (v) => v == null
                                                  ? "required field"
                                                  : null,
                                              hint: "Select a Shipment Mode",
                                              mode: Mode.MENU,
                                              enabled: (_id != null &&
                                                      _id != '' &&
                                                      _id != '0')
                                                  ? false
                                                  : true,
                                              showSelectedItem: true,
                                              showSearchBox: true,
                                              items: shipmentmodedata,
                                              label: "Shipment Mode *",
                                              showClearButton: false,
                                              onChanged: (val) {
                                                setState(() {
                                                  selectedshipmentmode = val;

                                                  shipmentmodeid =
                                                      shipmentmodedetails
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
                                              // popupItemDisabled: (String s) =>
                                              //     s.startsWith('I'),
                                              selectedItem:
                                                  selectedshipmentmode,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            constraints: BoxConstraints(
                                              //minHeight: 20,
                                              minWidth: 100,
                                              maxWidth: 200,
                                            ),
                                            width: maxwidth * .2,
                                            child: TextFormField(
                                              //enabled: false,
                                              controller: shipmentdateCtl,
                                              decoration: InputDecoration(
                                                labelText: "Shipment Date",
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: widgetcolor),
                                                ),
                                                border: InputBorder.none,
                                                hintText:
                                                    "Ex. Insert your Shipment date",
                                              ),
                                              onTap: () async {
                                                DateTime date = DateTime(1900);
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());

                                                date = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(2100));

                                                if (this.mounted)
                                                  setState(() {
                                                    DateTime today = date;

                                                    if (today != null) {
                                                      selshipmentdate =
                                                          "${today.year.toString()}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}";

                                                      shipmentdateCtl.text =
                                                          "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year.toString()}";
                                                    }
                                                    //  seldate; //date.toIso8601String();
                                                  });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        constraints: BoxConstraints(
                                          //minHeight: 20,
                                          minWidth: 100,
                                          maxWidth: 700,
                                        ),
                                        width: maxwidth * .6,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: widgetcolor),
                                              ),
                                              border: InputBorder.none,
                                              //disabledBorder: InputDecoration.collapsed(hintText: null),
                                              labelText: "Remarks",
                                              labelStyle:
                                                  TextStyle(fontSize: 20.0)),
                                          keyboardType: TextInputType.text,
                                          style: textStyle,
                                          controller: _custremarksController,
                                          //   focusNode: custidFocusNode,

                                          readOnly: enable,
                                          //enableInteractiveSelection: enable,
                                        ),
                                      ),
                                    ],
                                  ),
                                  flex: 3),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          constraints: BoxConstraints(
                            //minHeight: 20,
                            minWidth: 100,
                            maxWidth: 900,
                          ),
                          width: maxwidth * .9,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: widgetcolor),
                                ),
                                border: InputBorder.none,
                                //disabledBorder: InputDecoration.collapsed(hintText: null),
                                labelText: "Terms & Conditions",
                                labelStyle: TextStyle(fontSize: 20.0)),
                            //keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _custtermsandconditionsController,
                            //   focusNode: custidFocusNode,

                            readOnly: enable,
                            //enableInteractiveSelection: enable,
                          ),
                        ),

                        SizedBox(height: 2),
                        Container(
                          constraints: BoxConstraints(
                            //minHeight: 20,
                            minWidth: 100,
                            maxWidth: 900,
                          ),
                          width: maxwidth * .9,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widgetcolor,
                                  ),
                                ),
                                //border: InputBorder.none,
                                //disabledBorder: InputDecoration.collapsed(hintText: null),
                                //: "Terms & Conditions",
                                labelStyle: TextStyle(fontSize: 20.0)),
                            //keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _custtermsandconditionsController2,
                            //   focusNode: custidFocusNode,

                            readOnly: enable,
                            //enableInteractiveSelection: enable,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          constraints: BoxConstraints(
                            //minHeight: 20,
                            minWidth: 100,
                            maxWidth: 900,
                          ),
                          width: maxwidth * .9,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widgetcolor,
                                  ),
                                ),
                                //disabledBorder: InputDecoration.collapsed(hintText: null),
                                //labelText: "Terms & Conditions",
                                labelStyle: TextStyle(fontSize: 20.0)),
                            //keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _custtermsandconditionsController3,
                            //   focusNode: custidFocusNode,

                            readOnly: enable,
                            //enableInteractiveSelection: enable,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          constraints: BoxConstraints(
                            //minHeight: 20,
                            minWidth: 100,
                            maxWidth: 900,
                          ),
                          width: maxwidth * .9,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widgetcolor,
                                  ),
                                ),
                                //disabledBorder: InputDecoration.collapsed(hintText: null),
                                //labelText: "Terms & Conditions",
                                labelStyle: TextStyle(fontSize: 20.0)),
                            //keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _custtermsandconditionsController4,
                            //   focusNode: custidFocusNode,

                            readOnly: enable,
                            //enableInteractiveSelection: enable,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          constraints: BoxConstraints(
                            //minHeight: 20,
                            minWidth: 100,
                            maxWidth: 900,
                          ),
                          width: maxwidth * .9,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widgetcolor,
                                  ),
                                ),
                                //disabledBorder: InputDecoration.collapsed(hintText: null),
                                //labelText: "Terms & Conditions",
                                labelStyle: TextStyle(fontSize: 20.0)),
                            //keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _custtermsandconditionsController5,
                            //   focusNode: custidFocusNode,

                            readOnly: enable,
                            //enableInteractiveSelection: enable,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          constraints: BoxConstraints(
                            //minHeight: 20,
                            minWidth: 100,
                            maxWidth: 900,
                          ),
                          width: maxwidth * .9,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widgetcolor,
                                  ),
                                ), //disabledBorder: InputDecoration.collapsed(hintText: null),
                                //labelText: "Terms & Conditions",
                                labelStyle: TextStyle(fontSize: 20.0)),
                            //keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _custtermsandconditionsController6,
                            //   focusNode: custidFocusNode,

                            readOnly: enable,
                            //enableInteractiveSelection: enable,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          constraints: BoxConstraints(
                            //minHeight: 20,
                            minWidth: 100,
                            maxWidth: 900,
                          ),
                          width: maxwidth * .9,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widgetcolor,
                                  ),
                                ),
                                //disabledBorder: InputDecoration.collapsed(hintText: null),
                                //labelText: "Terms & Conditions",
                                labelStyle: TextStyle(fontSize: 20.0)),
                            //keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _custtermsandconditionsController7,
                            //   focusNode: custidFocusNode,

                            readOnly: enable,
                            //enableInteractiveSelection: enable,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          constraints: BoxConstraints(
                            //minHeight: 20,
                            minWidth: 100,
                            maxWidth: 900,
                          ),
                          width: maxwidth * .9,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widgetcolor,
                                  ),
                                ),
                                //disabledBorder: InputDecoration.collapsed(hintText: null),
                                // labelText: "Terms & Conditions",
                                labelStyle: TextStyle(fontSize: 20.0)),
                            //keyboardType: TextInputType.text,
                            style: textStyle,
                            controller: _custtermsandconditionsController8,
                            //   focusNode: custidFocusNode,

                            readOnly: enable,
                            //enableInteractiveSelection: enable,
                          ),
                        ),
                        // //  addfabricwid()
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
                      bool saveitems = true;
                      if ((prodtypeid == "") ||
                          (prodtypeid == null) ||
                          (prodtypeid == "0")) {
                        saveitems = false;
                        returnalert("Production Type").show();
                      } else if ((currencyid == "") ||
                          (currencyid == null) ||
                          (currencyid == "0")) {
                        saveitems = false;
                        returnalert("Currency").show();
                      } else if ((supplierid == "") ||
                          (supplierid == null) ||
                          (supplierid == "0")) {
                        saveitems = false;
                        returnalert("Supplier").show();
                      } else if ((notifypartyid == "") ||
                          (notifypartyid == null) ||
                          (notifypartyid == "0")) {
                        saveitems = false;
                        returnalert("Notify Party").show();
                      } else if ((currencyid == "") ||
                          (currencyid == null) ||
                          (currencyid == "0")) {
                        saveitems = false;
                        returnalert("Currency").show();
                      } else if ((portofloadid == "") ||
                          (portofloadid == null) ||
                          (portofloadid == "0")) {
                        returnalert("Port of Load").show();
                      } else if ((portofdischargeid == "") ||
                          (portofdischargeid == null) ||
                          (portofdischargeid == "0")) {
                        returnalert("Port of Discharge").show();
                      } else if ((shipmentmodeid == "") ||
                          (shipmentmodeid == null) ||
                          (shipmentmodeid == "0")) {
                        returnalert("Shipment Mode").show();
                      }

                      //saveItems();
                      if ((_id != "") && (_id != null) && (_id != "0")) {
                        setState(() {
                          enable = true;
                        });
                        if (saveitems) saveItems();
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
                          if (saveitems) saveItems();

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

  void _handleKeyEvent(RawKeyEvent event) {
    setState(() {
      if (event.logicalKey == LogicalKeyboardKey.keyQ) {
        //   _message = 'Pressed the "Q" key!';
      } else {
        if (kReleaseMode) {
          //    _message =
          print(' Key label is "${event.logicalKey.keyLabel ?? '<none>'}"');
        } else {
          // This will only print useful information in debug mode.
          //_message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
        }
      }
    });
  }
  // Widget listtableView() {
  //   // selrate = '';
  //   // Selecteditem = '';
  //   //pr.show();
  //   if (_itemdetails.length > 0) {
  //     return SingleChildScrollView(
  //         scrollDirection: Axis.vertical,
  //         child: SingleChildScrollView(
  //             scrollDirection: Axis.horizontal,
  //             child: DataTable(
  //               columnSpacing: 10.0,
  //               columns: [
  //                 DataColumn(
  //                   label: Container(
  //                       width: MediaQuery.of(context).size.width * 0.25,
  //                       child: Text("Group")),
  //                   numeric: false,
  //                 ),
  //                 DataColumn(
  //                   label: Container(
  //                       width: MediaQuery.of(context).size.width * 0.15,
  //                       child: Text("Item Code")),
  //                   numeric: false,
  //                 ),
  //                 DataColumn(
  //                   label: Container(
  //                     width: MediaQuery.of(context).size.width * 0.25,
  //                     child: Text("Item Name"),
  //                   ),
  //                   numeric: false,
  //                 ),
  //                 DataColumn(
  //                   label: Container(
  //                     width: MediaQuery.of(context).size.width * 0.10,
  //                     child: Text("Rate"),
  //                   ),
  //                   numeric: true,
  //                 ),
  //                 DataColumn(
  //                   label: Text("Action"),
  //                 )
  //               ],
  //               rows: _itemdetails
  //                       ?.map(
  //                         (item) => DataRow(cells: [
  //                           DataCell(Container(
  //                             width: MediaQuery.of(context).size.width * 0.25,
  //                             child: Text(item.groupname.toUpperCase()),
  //                           )),
  //                           DataCell(Container(
  //                             width: MediaQuery.of(context).size.width * 0.15,
  //                             child: Text(item.itemCode.toUpperCase()),
  //                           )),
  //                           DataCell(
  //                             Container(
  //                               width: MediaQuery.of(context).size.width * 0.25,
  //                               child: Text(item.itemName.toString()),
  //                             ),
  //                           ),
  //                           DataCell(
  //                             Container(
  //                               width: MediaQuery.of(context).size.width * 0.10,
  //                               child: Text(item.rate.toString()),
  //                             ),
  //                           ),
  //                           DataCell(Row(
  //                             children: [
  //                               Container(
  //                                   width: MediaQuery.of(context).size.width *
  //                                       0.25,
  //                                   child: Row(children: [
  //                                     IconButton(
  //                                         icon: Image.asset('Images/edit.png',
  //                                             color: Colors.orange),
  //                                         highlightColor: Colors.pink,
  //                                         onPressed: () {
  //                                           if (this.mounted)
  //                                             setState(() {
  //                                               Selecteditem = item.itemName;
  //                                               Selectedgroup = groupdetails
  //                                                   .where((element) =>
  //                                                       element
  //                                                           .columnMasterid ==
  //                                                       item.groupMasterID)
  //                                                   .map((e) => e.columnname)
  //                                                   .first
  //                                                   .toString();

  //                                               //Editeditem = item.itemName;
  //                                               selrate = item.rate;
  //                                               _pricerateController.text =
  //                                                   item.rate;
  //                                               _previousitem = item;
  //                                               removeItem(item);
  //                                             });

  //                                           //  Itemid = item.itemMasterID;
  //                                           //  removeItem(item);
  //                                         }),
  //                                     SizedBox(width: 2),
  //                                     IconButton(
  //                                         icon: Image.asset('Images/delete.png',
  //                                             color: Colors.orange),
  //                                         highlightColor: Colors.pink,
  //                                         onPressed: () {
  //                                           removeItem(item);
  //                                         })
  //                                   ]))
  //                             ],
  //                           )),
  //                         ]),
  //                       )
  //                       ?.toList() ??
  //                   [],
  //             )));
  //   } else {
  //     // pr.dismiss();
  //     return Text("Add details using the form below",
  //         textAlign: TextAlign.center);
  //   }

  //   //pr.dismiss();
  // }

  List<Widget> addfabricwid() {
    List<Widget> widgs = [];
    //  return Row(
    //  children: [
    //Text('')
    // if (selectedprodtype.toLowerCase() == 'fabric'.toLowerCase())
    //if (fabricdata != null && fabricdata.isNotEmpty)
    widgs.add(
      Container(
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: 150,
        ),
        //padding: EdgeInsets.,
        width: maxwidth * .7, //* 0.50,
        child: DropdownSearch<String>(
          dropDownButton:
              Image.asset('Images/arrow_drop_down.png', color: Colors.white),
          validator: (v) => v == null ? "required field" : null,
          hint: "Select a Fabric",
          mode: Mode.MENU,
          enabled: (_id != null && _id != '' && _id != '0') ? false : true,
          showSelectedItem: true,
          showSearchBox: true,
          items: fabricdata,
          label: "Fabric *",
          showClearButton: false,
          onChanged: (val) {
            setState(() {
              selectedfabric = val;

              fabricid = fabricdetails
                  .where((element) => element.columnname == val)
                  .map((e) => e.columnMasterid)
                  .first
                  .toString();
            });
          },
          popupItemDisabled: (String s) => s.startsWith('I'),
          selectedItem: selectedfabric,
        ),
      ),
      // SizedBox(width: 10),
    );
    widgs.add(SizedBox(width: 10));
    //if (fabrictypedata != null && fabrictypedata.isNotEmpty)
    widgs.add(
      Container(
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: 150,
        ),
        //padding: EdgeInsets.,
        width: maxwidth * .7, //* 0.50,
        child: DropdownSearch<String>(
          dropDownButton:
              Image.asset('Images/arrow_drop_down.png', color: Colors.white),
          validator: (v) => v == null ? "required field" : null,
          hint: "Select a Fabric type",
          mode: Mode.MENU,
          enabled: (_id != null && _id != '' && _id != '0') ? false : true,
          showSelectedItem: true,
          showSearchBox: true,
          items: fabrictypedata,
          label: "Fabric Type*",
          showClearButton: false,
          onChanged: (val) {
            setState(() {
              selectedfabtype = val;

              fabtypeid = fabrictypetypedetails
                  .where((element) => element.columnname == val)
                  .map((e) => e.columnMasterid)
                  .first
                  .toString();
            });
          },
          popupItemDisabled: (String s) => s.startsWith('I'),
          selectedItem: selectedfabtype,
        ),
      ),
    );
    widgs.add(SizedBox(width: 10));
    //  if (fabricknitdata != null && fabricknitdata.isNotEmpty)
    widgs.add(
      Container(
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: 150,
        ),
        //padding: EdgeInsets.,
        width: maxwidth * .7, //* 0.50,
        child: DropdownSearch<String>(
          dropDownButton:
              Image.asset('Images/arrow_drop_down.png', color: Colors.white),
          validator: (v) => v == null ? "required field" : null,
          hint: "Select a Fabric Knit type",
          mode: Mode.MENU,
          enabled: (_id != null && _id != '' && _id != '0') ? false : true,
          showSelectedItem: true,
          showSearchBox: true,
          items: fabricknitdata,
          label: "Fabric Knit Type *",
          showClearButton: false,
          onChanged: (val) {
            setState(() {
              selectedfabknittype = val;

              fabknittypeid = fabricknittypedetails
                  .where((element) => element.columnname == val)
                  .map((e) => e.columnMasterid)
                  .first
                  .toString();
            });
          },
          popupItemDisabled: (String s) => s.startsWith('I'),
          selectedItem: selectedfabknittype,
        ),
      ),
    );

    return widgs; //    ],
    //  );
  }

  BoxDecoration getBoxDecoration() {
    if (_itemdetails.length > 0) {
      return BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.blueGrey),
          color: appbarcolor);
    }
    return null;
  }

  void removeItem(item) {
    if (this.mounted)
      setState(() {
        _itemdetails.remove(item);
      });
  }

  void saveItems() async {
    if (_id == "" || _id == null) {
      _id = "0";
    }
    List<purchaseorderdetl.PurchaseOrderDetails> yarndetail =
        List<purchaseorderdetl.PurchaseOrderDetails>.generate(
            _itemdetails.length, (int index) {
      return purchaseorderdetl.PurchaseOrderDetails(
          intflag: (_id == '0' || _id == '' || _id == null) ? '1' : '0',
          headerid: _id,
          yarnmillid: _itemdetails[index].yarnmillid,
          yarntypeid: _itemdetails[index].yarntypeid,
          yarncountid: _itemdetails[index].yarncountid,
          colorid: _itemdetails[index].colorid,
          noofbox: _itemdetails[index].noofbox,
          weight: _itemdetails[index].weight,
          rate: _itemdetails[index].rate,
          amount: _itemdetails[index].amount);
    });

    List<purchaseorderdetl.PurchaseOrderFabricDetails> fabricdetail =
        List<purchaseorderdetl.PurchaseOrderFabricDetails>.generate(
            _itemdetails.length, (int index) {
      return purchaseorderdetl.PurchaseOrderFabricDetails(
          headerid: _id,
          intflag: (_id == '0' || _id == '' || _id == null) ? '1' : '0',
          fabrictypeid: _itemdetails[index].fabrictypeid,
          fabricid: _itemdetails[index].fabricid,
          compositionid: _itemdetails[index].compositionid,
          gsm: _itemdetails[index].gsm,
          diaid: _itemdetails[index].diaid,
          knittypeid: _itemdetails[index].knittypeid,
          uomid: _itemdetails[index].uomid,
          colorid: _itemdetails[index].colorid,
          noofbox: _itemdetails[index].noofbox,
          weight: _itemdetails[index].weight,
          rate: _itemdetails[index].rate,
          amount: _itemdetails[index].amount);
    });

    final purchaseorderdetl.PurchaseOrderHeader purchaseorderList =
        (selectedprodtype.toString().toLowerCase() == 'yarn')
            ? purchaseorderdetl.PurchaseOrderHeader(
                intflag: (_id == '0' || _id == '' || _id == null) ? '1' : '0',
                purchaseorderdetail: yarndetail,
                headerid: _id,
                pono: _custPONoController.text,
                podate: seldate,
                producttype: selectedprodtype,
                consigneeid: consigneeid,
                supplierid: supplierid,
                currencyid: currencyid,
                noofcontainers: _custnoofcontainerController.text,
                paymentterms: _custpaymenttermsController.text,
                shipmentmodeid: shipmentmodeid,
                portofloadingid: portofloadid,
                shipmentdate: selshipmentdate,
                packinglistid: _custpackingdetailController.text,
                remarks: _custRemarksController.text,
                termsandconditions: _custtermsandconditionsController.text)
            : purchaseorderdetl.PurchaseOrderHeader(
                intflag: (_id == '0' || _id == '' || _id == null) ? '1' : '0',
                purchaseorderfabricdetail: fabricdetail,
                headerid: _id,
                pono: _custPONoController.text,
                podate: seldate,
                producttype: selectedprodtype,
                consigneeid: consigneeid,
                supplierid: supplierid,
                currencyid: currencyid,
                noofcontainers: _custnoofcontainerController.text,
                paymentterms: _custpaymenttermsController.text,
                shipmentmodeid: shipmentmodeid,
                portofloadingid: portofloadid,
                shipmentdate: selshipmentdate,
                packinglistid: _custpackingdetailController.text,
                remarks: _custRemarksController.text,
                termsandconditions: _custtermsandconditionsController.text);
    final String requestBody = json.encoder.convert(purchaseorderList);
    final http.Response response =
        await http.post('http://tap.suninfotechnologies.in/api/Touchpo',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: requestBody);

    if (response.statusCode == 200) {
      setState(() {
        clearData(context);
        enable = false;
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
                Navigator.of(context, rootNavigator: true).pop();
//pr.hide();
              },
              width: 120,
            )
          ]).show();
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Alert returnalert(String name) {
    return Alert(
        context: context,
        title: "Done!",
        desc: name.toString() + " should not be empty",
        type: AlertType.success,
        style: AlertStyle(isCloseButton: false),
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
//pr.hide();
            },
            width: 120,
          )
        ]);
  }

  void clearData(context) {
    setState(() {
      selectedsupplier = '';
      _custIdController.text = '0';
      _custPONoController.text = '';
      _custDateController.text = '';
      //_cust
      shipmentdateCtl.text = '';
      dateCtl.text = '';

      selectedportofload = '';
      selectedportofdischarge = '';
      selectedshipmentmode = '';
      _custNotifypartyController.text = '';
      _custAdd3Controller.text = '';
      _custAdd4Controller.text = '';
      _custEmailController.text = '';
      _custGstinController.text = '';
      _custMobileController.text = '';
      _custRemarksController.text = '';
      _custgsmController.text = '';
      _custnoofboxController.text = '';
      _custkgsperboxController.text = '';
      _custweightController.text = '';
      _custrateController.text = '';
      _custamountController.text = '';
      _custtermsandconditionsController.text = '';
      _custtermsandconditionsController2.text = '';
      _custtermsandconditionsController3.text = '';
      _custtermsandconditionsController4.text = '';
      _custtermsandconditionsController5.text = '';
      _custtermsandconditionsController6.text = '';
      _custtermsandconditionsController7.text = '';
      _custtermsandconditionsController8.text = '';
      _custnoofcontainerController.text = '';
      _custpackingdetailController.text = '';
      _custpaymenttermsController.text = '';
      _custremarksController.text = '';
      colorid = '0';
      yarncountid = '0';
      yarnmillid = '0';
      yarntypeid = '0';
      fabricid = '0';
      diaid = '0';
      fabtypeid = '0';
      fabknittypeid = '0';
      compositionid = '0';
      selectedconsignee = '';
      selectednotifyparty = '';
      selectedcurrency = '';
      _itemdetails = [];
      _id = '0';

      selectedyarnmill = '';
      selectedyarntype = '';
      selectedyarncount = '';
      selectedcolor = '';
      selectedfabric = '';
      selectedcomposition = '';
      selectedfabknittype = '';
      selecteddia = '';
      selecteduom = '';
      DateTime today = DateTime.now();
      dateCtl.text =
          "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString()}";
      seldate =
          "${today.year.toString()}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}";

      shipmentdateCtl.text =
          "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString()}";
      selshipmentdate =
          "${today.year.toString()}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}";
    });

    // Selectedcolor = 'white';
    // colorid = '2';
    // _custyarntypeController.text = 'TESoGT';
    // yarntypeid = '5';
  }

  List<purchaseorderdetl.PurchaseOrderHeader> data =
      new List<purchaseorderdetl.PurchaseOrderHeader>();

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

      compid = companydetails
              .where((element) => element.ptyname == selectedcompany)
              .map((e) => e.partyid)
              .isEmpty
          ? "0"
          : companydetails
              .where((element) => element.ptyname == selectedcompany)
              .map((e) => e.partyid)
              .first
              .toString();
    });

    return companydetails;
  }

  Future<List<purchaseorderdetl.PurchaseOrderDetails>>
      getpurchaseitemdetails() async {
    setState(() {
      _itemdetails = [];
    });
    final String customerurl =
        'http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=20&Mode=PO&spname=GetAndSubmitPODetails&intflag=4&intHeaderID=' +
            _id;
    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      _itemdetails = (selectedprodtype.toString().toLowerCase() == 'fabric')
          ? parsed
              .map<purchaseorderdetl.PurchaseOrderDetails>((json) =>
                  purchaseorderdetl.PurchaseOrderDetails.fromJSON(json))
              .toList()
          : parsed
              .map<purchaseorderdetl.PurchaseOrderDetails>((json) =>
                  purchaseorderdetl.PurchaseOrderDetails.fromyarnJSON(json))
              .toList();
    });
    return _itemdetails;
  }

  Future<List<customer.Customer>> getsupplierdetails(String filter) async {
    setState(() {
      supplierdetails = [];
      supplierdata = [];
    });

    final String customerurl =
        'http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intUserID=1&intPartytypeID=2&pagesize=50';

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      supplierdetails = parsed
          .map<customer.Customer>((json) => customer.Customer.fromJSON(json))
          .toList();

      if (filter != "")
        supplierdetails = supplierdetails
            .where((element) => element.customerName
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      supplierdata = supplierdetails.map((e) => e.customerName).toList();
      if (supplierid == '' || supplierid == null || supplierid == '0')
        selectedsupplier = supplierdata.first;

      supplierid = supplierdetails
              .where((element) => element.customerName == selectedsupplier)
              .map((e) => e.custId)
              .isEmpty
          ? "0"
          : supplierdetails
              .where((element) => element.customerName == selectedsupplier)
              .map((e) => e.custId)
              .first
              .toString();
    });

    return supplierdetails;
  }

  Future<List<customer.Customer>> getnotifypartydetails(String filter) async {
    setState(() {
      notifypartydetails = [];
      notifypartydata = [];
    });

    final String customerurl =
        'http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intUserID=1&intPartytypeID=4&pagesize=10';

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      notifypartydetails = parsed
          .map<customer.Customer>((json) => customer.Customer.fromJSON(json))
          .toList();

      if (filter != "")
        notifypartydetails = notifypartydetails
            .where((element) => element.customerName
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      notifypartydata = notifypartydetails.map((e) => e.customerName).toList();
      if (notifypartyid == '' || notifypartyid == null || notifypartyid == '0')
        selectednotifyparty = notifypartydata.first;

      notifypartyid = notifypartydetails
              .where((element) => element.customerName == selectednotifyparty)
              .map((e) => e.custId)
              .isEmpty
          ? "0"
          : notifypartydetails
              .where((element) => element.customerName == selectednotifyparty)
              .map((e) => e.custId)
              .first
              .toString();
    });

    return notifypartydetails;
  }

  Future<List<master.Master>> getcurrencydetails(String filter) async {
    setState(() {
      currencydetails = [];
      currencydata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=currencymaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      currencydetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        currencydetails = currencydetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      currencydata = currencydetails.map((e) => e.columnname).toList();
      if (currencyid == '' || currencyid == null || currencyid == '0')
        selectedcurrency = currencydata.first;

      currencyid = currencydetails
              .where((element) => element.columnname == selectedcurrency)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : currencydetails
              .where((element) => element.columnname == selectedcurrency)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return currencydetails;
  }

  Future<List<uom.Uom>> getuomdetails(String filter) async {
    setState(() {
      uomdetails = [];
      uomdata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=uom&spname=GetAndSubmituommaster&intOrgID=1&intUserID=1&intflag=4";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      uomdetails =
          parsed.map<uom.Uom>((json) => uom.Uom.fromJSON(json)).toList();

      if (filter != "")
        uomdetails = uomdetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      uomdata = uomdetails.map((e) => e.columnname).toList();
      if (uomid == '' || uomid == null || uomid == '0')
        selecteduom = uomdata.first;

      uomid = uomdetails
              .where((element) => element.columnname == selecteduom)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : uomdetails
              .where((element) => element.columnname == selecteduom)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return uomdetails;
  }

  Future<List<master.Master>> getcompositiondetails(String filter) async {
    setState(() {
      compositiondetails = [];
      compositiondata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=fabriccompositionmaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      compositiondetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        compositiondetails = compositiondetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      compositiondata = compositiondetails.map((e) => e.columnname).toList();
      if (compositionid == '' || compositionid == null || compositionid == '0')
        selectedcomposition = compositiondata.first;

      compositionid = compositiondetails
              .where((element) => element.columnname == selectedcomposition)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : compositiondetails
              .where((element) => element.columnname == selectedcomposition)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return compositiondetails;
  }

  Future<List<master.Master>> getdiadetails(String filter) async {
    setState(() {
      diadetails = [];
      diadata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=fabricdiamaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      diadetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        diadetails = diadetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      diadata = diadetails.map((e) => e.columnname).toList();
      if (diaid == '' || diaid == null || diaid == '0')
        selecteddia = diadata.first;

      diaid = diadetails
              .where((element) => element.columnname == selecteddia)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : diadetails
              .where((element) => element.columnname == selecteddia)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return diadetails;
  }

  Future<List<master.Master>> getportofdischargedetails(String filter) async {
    setState(() {
      portofdischargedetails = [];
      portofdischargedata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=portofdischargemaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      portofdischargedetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        portofdischargedetails = portofdischargedetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      portofdischargedata =
          portofdischargedetails.map((e) => e.columnname).toList();
      if (portofdischargeid == '' ||
          portofdischargeid == null ||
          portofdischargeid == '0')
        selectedportofdischarge = portofdischargedata.first;

      portofdischargeid = portofdischargedetails
              .where((element) => element.columnname == selectedportofdischarge)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : portofdischargedetails
              .where((element) => element.columnname == selectedportofdischarge)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return portofdischargedetails;
  }

  Future<List<master.Master>> getportofloaddetails(String filter) async {
    setState(() {
      portofloaddetails = [];
      portofloaddata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=portofloadingmaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      portofloaddetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        portofloaddetails = portofloaddetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      portofloaddata = portofloaddetails.map((e) => e.columnname).toList();
      if (portofloadid == '' || portofloadid == null || portofloadid == '0')
        selectedportofload = portofloaddata.first;

      portofloadid = portofloaddetails
              .where((element) => element.columnname == selectedportofload)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : portofloaddetails
              .where((element) => element.columnname == selectedportofload)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return portofloaddetails;
  }

  Future<List<master.Master>> getshipmentmodedetails(String filter) async {
    setState(() {
      shipmentmodedetails = [];
      shipmentmodedata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=shipmentmodemaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      shipmentmodedetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        shipmentmodedetails = shipmentmodedetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      shipmentmodedata = shipmentmodedetails.map((e) => e.columnname).toList();
      if (shipmentmodeid == '' ||
          shipmentmodeid == null ||
          shipmentmodeid == '0') selectedshipmentmode = shipmentmodedata.first;

      shipmentmodeid = shipmentmodedetails
              .where((element) => element.columnname == selectedshipmentmode)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : shipmentmodedetails
              .where((element) => element.columnname == selectedshipmentmode)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return shipmentmodedetails;
  }

  Future<List<master.Master>> getcolordetails(String filter) async {
    setState(() {
      colordetails = [];
      colordata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=master&spname=GetAndSubmitmastertable&intOrgID=1&intUserID=1&intflag=4&strTableName=colormaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      colordetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        colordetails = colordetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      colordata = colordetails.map((e) => e.columnname).toList();
      if (colorid == '' || colorid == null || colorid == '0')
        selectedcolor = colordata.first;

      colorid = colordetails
              .where((element) => element.columnname == selectedcolor)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : colordetails
              .where((element) => element.columnname == selectedcolor)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return colordetails;
  }

  Future<List<master.Master>> getfabknittypedetails(String filter) async {
    setState(() {
      fabricknittypedetails = [];
      fabricknitdata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=fabricdknittypemaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      fabricknittypedetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        fabricknittypedetails = fabricknittypedetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      fabricknitdata = fabricknittypedetails.map((e) => e.columnname).toList();
      if (fabknittypeid == '' || fabknittypeid == null || fabknittypeid == '0')
        selectedfabknittype = fabricknitdata.first;

      fabknittypeid = fabricknittypedetails
              .where((element) => element.columnname == selectedfabknittype)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : fabricknittypedetails
              .where((element) => element.columnname == selectedfabknittype)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return fabricknittypedetails;
  }

  Future<List<master.Master>> getfabrictypedetails(String filter) async {
    setState(() {
      fabrictypetypedetails = [];
      fabrictypedata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=fabrictypemaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      fabrictypetypedetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        fabrictypetypedetails = fabrictypetypedetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      fabrictypedata = fabrictypetypedetails.map((e) => e.columnname).toList();
      if (fabtypeid == '' || fabtypeid == null || fabtypeid == '0')
        selectedfabtype = fabrictypedata.first;

      fabtypeid = fabrictypetypedetails
              .where((element) => element.columnname == selectedfabtype)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : fabrictypetypedetails
              .where((element) => element.columnname == selectedfabtype)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return fabrictypetypedetails;
  }

  Future<List<master.Master>> getyarnmilldetails(String filter) async {
    setState(() {
      yarnmilldetails = [];
      yarnmilldata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=yarnmillmaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      yarnmilldetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        yarnmilldetails = yarnmilldetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      yarnmilldata = yarnmilldetails.map((e) => e.columnname).toList();
      if (yarnmillid == '' || yarnmillid == null || yarnmillid == '0')
        selectedyarnmill = yarnmilldata.first;

      yarnmillid = yarnmilldetails
              .where((element) => element.columnname == selectedyarnmill)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : yarnmilldetails
              .where((element) => element.columnname == selectedyarnmill)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return yarnmilldetails;
  }

  Future<List<master.Master>> getyarncountdetails(String filter) async {
    setState(() {
      yarncountdetails = [];
      yarncountdata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=yarncountmaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      yarncountdetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        yarncountdetails = yarncountdetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      yarncountdata = yarncountdetails.map((e) => e.columnname).toList();
      if (yarncountid == '' || yarncountid == null || yarncountid == '0')
        selectedyarncount = yarncountdata.first;

      yarncountid = yarncountdetails
              .where((element) => element.columnname == selectedyarncount)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : yarncountdetails
              .where((element) => element.columnname == selectedyarncount)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return yarncountdetails;
  }

  Future<List<Customer>> getconsigneedetails(String filter) async {
    setState(() {
      consigneedetails = [];
      consigneedata = [];
    });

    final String customerurl =
        "https://cors-anywhere.herokuapp.com/http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intPartytypeID=3&intUserID=1&pagesize=150&pagenumber=1";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      consigneedetails =
          parsed.map<Customer>((json) => Customer.fromJSON(json)).toList();

      if (filter != "")
        consigneedetails = consigneedetails
            .where((element) => element.customerName
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      consigneedata = consigneedetails.map((e) => e.customerName).toList();
      if (consigneeid == '' || consigneeid == null || consigneeid == '0')
        selectedconsignee = consigneedata.first;

      consigneeid = consigneedetails
              .where((element) => element.customerName == selectedconsignee)
              .map((e) => e.custId)
              .isEmpty
          ? "0"
          : consigneedetails
              .where((element) => element.customerName == selectedconsignee)
              .map((e) => e.custId)
              .first
              .toString();
    });

    return consigneedetails;
  }

  Future<List<master.Master>> getyarntypedetails(String filter) async {
    setState(() {
      yarntypedetails = [];
      yarntypedata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=yarntypemaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      yarntypedetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        yarntypedetails = yarntypedetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      yarntypedata = yarntypedetails.map((e) => e.columnname).toList();
      if (yarntypeid == '' || yarntypeid == null || yarntypeid == '0')
        _custyarntypeController.text = yarntypedata.first;

      yarntypeid = yarntypedetails
              .where((element) =>
                  element.columnname == _custyarntypeController.text)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : yarntypedetails
              .where((element) =>
                  element.columnname == _custyarntypeController.text)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return yarntypedetails;
  }

  Future<List<master.Master>> getfabricdetails(String filter) async {
    setState(() {
      fabricdetails = [];
      fabricdata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=fabricnamemaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      fabricdetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        fabricdetails = fabricdetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      fabricdata = fabricdetails.map((e) => e.columnname).toList();
      if (fabricid == '' || fabricid == null || fabricid == '0')
        selectedfabric = fabricdata.first;

      fabricid = fabricdetails
              .where((element) => element.columnname == selectedfabric)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : fabricdetails
              .where((element) => element.columnname == selectedfabric)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return fabricdetails;
  }

  Future<List<master.Master>> getproddetails(String filter) async {
    setState(() {
      prodtypedetails = [];
      prodtypedata = [];
    });

    final String customerurl =
        "http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=50&Mode=MASTER&spname=GetAndSubmitMasterTable&intOrgID=1&intUserID=1&intflag=4&strTableName=producttypemaster";

    var response = await http.get(Uri.encodeFull(customerurl),
        headers: {"Accept": "application/json"});
    //List<ItemMaster> customer1 = new List<ItemMaster>();

    var convertDataToJson = json.decode(response.body);
    final parsed = convertDataToJson.cast<Map<String, dynamic>>();
    setState(() {
      prodtypedetails = parsed
          .map<master.Master>((json) => master.Master.fromJSON(json))
          .toList();

      if (filter != "")
        prodtypedetails = prodtypedetails
            .where((element) => element.columnname
                .toLowerCase()
                .toString()
                .contains(filter.toLowerCase().toString()))
            .toList();

      prodtypedata = prodtypedetails.map((e) => e.columnname).toList();
      if (prodtypeid == '' || prodtypeid == null || prodtypeid == '0')
        selectedprodtype = prodtypedata.first;

      prodtypeid = prodtypedetails
              .where((element) => element.columnname == selectedprodtype)
              .map((e) => e.columnMasterid)
              .isEmpty
          ? "0"
          : prodtypedetails
              .where((element) => element.columnname == selectedprodtype)
              .map((e) => e.columnMasterid)
              .first
              .toString();
    });

    return prodtypedetails;
  }

  void getAddCustomerJson() async {
    if (_id != "" && _id != "0" && _id != null) {
      _reportItems
          .where((element) => element.headerid == _id)
          .forEach((element) => setState(() {
                dateCtl.text = element.podate;
                shipmentdateCtl.text = element.shipmentdate;
                selectednotifyparty = element.notifyparty;
                notifypartyid = element.notifypartyid;
                _custPONoController.text = element.pono;
                selectedprodtype = element.producttype;
                //prodtypeid = element.producttype;
                selectedconsignee = element.consignee;
                selectedsupplier = element.supplier;
                supplierid = element.supplierid;
                selectedcurrency = element.currency;
                currencyid = element.currencyid;
                _custnoofcontainerController.text = element.noofcontainers;
                _custpaymenttermsController.text = element.paymentterms;

                selectedportofdischarge = portofdischargedetails
                        .where((e1) =>
                            e1.columnMasterid == element.portofdischargeid)
                        .map((e) => e.columnname)
                        .isNotEmpty
                    ? portofdischargedetails
                        .where((e1) =>
                            e1.columnMasterid == element.portofdischargeid)
                        .map((e) => e.columnname)
                        .first
                        .toString()
                    : "";
                selectedportofload = portofloaddetails
                        .where((e1) =>
                            e1.columnMasterid == element.portofloadingid)
                        .map((e) => e.columnname)
                        .isNotEmpty
                    ? portofloaddetails
                        .where((e1) =>
                            e1.columnMasterid == element.portofloadingid)
                        .map((e) => e.columnname)
                        .first
                        .toString()
                    : "";
                selectedshipmentmode = shipmentmodedetails
                        .where(
                            (e1) => e1.columnMasterid == element.shipmentmodeid)
                        .map((e) => e.columnname)
                        .first
                        .isNotEmpty
                    ? shipmentmodedetails
                        .where(
                            (e1) => e1.columnMasterid == element.shipmentmodeid)
                        .map((e) => e.columnname)
                        .first
                        .toString()
                    : "";
                shipmentmodeid = element.shipmentdate;
                portofloadid = element.portofloadingid;
                portofdischargeid = element.portofdischargeid;
                selshipmentdate = element.shipmentdate;
                _custpackingdetailController.text = element.packinglistid;
                _custremarksController.text = element.remarks;
                _custtermsandconditionsController.text =
                    element.termsandconditions.toString();
                _custtermsandconditionsController2.text =
                    element.termsandconditions2.toString();
                _custtermsandconditionsController3.text =
                    element.termsandconditions3.toString();
                _custtermsandconditionsController4.text =
                    element.termsandconditions4.toString();
                _custtermsandconditionsController5.text =
                    element.termsandconditions5.toString();
                _custtermsandconditionsController6.text =
                    element.termsandconditions6.toString();
                _custtermsandconditionsController7.text =
                    element.termsandconditions7.toString();
                _custtermsandconditionsController8.text =
                    element.termsandconditions8.toString();
              }));
      getpurchaseitemdetails();
    }
  }

  @override
  void initState() {
    idFocusNode = FocusNode();
    focusnoofbox = FocusNode();

    searchtext = '';
    getCustomerJson();
    custidFocusNode = FocusNode();
    _custIdController.text = '0';
    getcompanyMaster('');
    getsupplierdetails('');
    getcurrencydetails('');
    getnotifypartydetails('');
    getportofdischargedetails('');
    getportofloaddetails('');
    getconsigneedetails('');
    getshipmentmodedetails('');
    getproddetails('');

    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    setState(() {
      getAddCustomerJson();
      if ((_id != "") && (_id != null) && (_id != "0"))
        _custIdController.text = _id.toString();
      else {
        DateTime today = DateTime.now();
        dateCtl.text =
            "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString()}";
        seldate =
            "${today.year.toString()}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}";

        shipmentdateCtl.text =
            "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString()}";
        selshipmentdate =
            "${today.year.toString()}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}";
      }
    });

    if (selectedprodtype.toString().toLowerCase() == 'fabric') {
      getfabricdetails('');
      getfabknittypedetails('');
      getcolordetails('');
      getdiadetails('');
      getuomdetails('');
      getcompositiondetails('');
      getfabrictypedetails('');
    }

    if (selectedprodtype.toString().toLowerCase() == 'yarn') {
      getyarncountdetails('');
      getyarntypedetails('');
      getyarnmilldetails('');
      getcolordetails('');
    }

    super.initState();
  }

  _afterLayout(_) {
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

    _custGstinController.dispose();
    _custgsmController.dispose();
    _custnoofboxController.dispose();
    _custkgsperboxController.dispose();
    _custyarntypeController.dispose();
    _custweightController.dispose();
    _custrateController.dispose();
    _custamountController.dispose();
    //_custconsigneeAddressController.dispose();
    _custtermsandconditionsController.dispose();
    _custtermsandconditionsController2.dispose();
    _custtermsandconditionsController3.dispose();
    _custtermsandconditionsController4.dispose();
    _custtermsandconditionsController5.dispose();
    _custtermsandconditionsController6.dispose();
    _custtermsandconditionsController7.dispose();
    _custtermsandconditionsController8.dispose();
    _custnoofcontainerController.dispose();
    _custpackingdetailController.dispose();
    _custpaymenttermsController.dispose();
    _custremarksController.dispose();

    _controller.dispose();
    super.dispose();
  }

  NotchedShape shape;

  Widget listtableView(double maxwidth, double maxheight, context) {
    // selrate = '';
    // Selecteditem = '';
    //pr.show();
    if (_itemdetails.length > 0) {
      return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  height: 200,
                  child: DataTable(
                    columnSpacing: 10.0,
                    columns: [
                      if (selectedprodtype.toString().toLowerCase() == 'fabric')
                        DataColumn(
                          label: Container(
                              width: maxwidth * 0.10, child: Text("Fabric")),
                          numeric: false,
                        ),
                      if (selectedprodtype.toString().toLowerCase() == 'fabric')
                        DataColumn(
                          label: Container(
                              width: maxwidth * 0.10,
                              child: Text("Fabric Type")),
                          numeric: false,
                        ),
                      if (selectedprodtype.toString().toLowerCase() == 'fabric')
                        DataColumn(
                          label: Container(
                            width: maxwidth * 0.10,
                            child: Text("knit Type"),
                          ),
                          numeric: false,
                        ),
                      if (selectedprodtype.toString().toLowerCase() == 'yarn')
                        DataColumn(
                          label: Container(
                              width: maxwidth * .10, child: Text("Yarn Mill")),
                          numeric: false,
                        ),
                      if (selectedprodtype.toString().toLowerCase() == 'yarn')
                        DataColumn(
                          label: Container(
                              width: maxwidth * 0.08,
                              child: Text("Yarn Count")),
                          numeric: false,
                        ),
                      if (selectedprodtype.toString().toLowerCase() == 'yarn')
                        DataColumn(
                          label: Container(
                            width: maxwidth * 0.10,
                            child: Text("Yarn Type"),
                          ),
                          numeric: false,
                        ),
                      DataColumn(
                        label: Container(
                          width: maxwidth * 0.10,
                          child: Text("Color"),
                        ),
                        numeric: true,
                      ),
                      if (selectedprodtype.toString().toLowerCase() == 'fabric')
                        DataColumn(
                          label: Container(
                            width: maxwidth * 0.10,
                            child: Text("Dia"),
                          ),
                          numeric: true,
                        ),
                      if (selectedprodtype.toString().toLowerCase() == 'fabric')
                        DataColumn(
                          label: Container(
                            width: maxwidth * 0.10,
                            child: Text("Uom"),
                          ),
                          numeric: true,
                        ),
                      DataColumn(
                        label: Container(
                          width: maxwidth * 0.08,
                          child: Text("No of Box"),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Container(
                          width: maxwidth * 0.10,
                          child: Text("Kgs/Box"),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Container(
                          width: maxwidth * 0.10,
                          child: Text("Weight"),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Container(
                          width: maxwidth * 0.08,
                          child: Text("Rate"),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Container(
                          width: maxwidth * 0.10,
                          child: Text("Amount"),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Container(
                          width: maxwidth * 0.12,
                          child: Text("Action"),
                        ),
                      )
                    ],
                    rows: _itemdetails
                            ?.map(
                              (item) => DataRow(cells: [
                                if (selectedprodtype.toString().toLowerCase() ==
                                    'fabric')
                                  DataCell(Container(
                                    width: maxwidth * 0.10,
                                    child: Text((fabricdetails
                                            .where((element) =>
                                                element.columnMasterid ==
                                                item.fabricid)
                                            .map((e) => e.columnname)
                                            .isNotEmpty
                                        ? fabricdetails
                                            .where((element) =>
                                                element.columnMasterid ==
                                                item.fabricid)
                                            .map((e) => e.columnname)
                                            .first
                                            .toString()
                                        : "")),
                                  )),
                                if (selectedprodtype.toString().toLowerCase() ==
                                    'fabric')
                                  DataCell(Container(
                                    width: maxwidth * 0.10,
                                    child: Text(item.fabrictype
                                        .toString()
                                        .toUpperCase()),
                                  )),
                                if (selectedprodtype.toString().toLowerCase() ==
                                    'fabric')
                                  DataCell(
                                    Container(
                                      width: maxwidth * 0.10,
                                      child: Text(item.knittype.toString()),
                                    ),
                                  ),
                                if (selectedprodtype.toString().toLowerCase() ==
                                    'yarn')
                                  DataCell(
                                    Container(
                                      width: maxwidth * 0.10,
                                      child: Text(item.yarnmill.toString()),
                                    ),
                                  ),
                                if (selectedprodtype.toString().toLowerCase() ==
                                    'yarn')
                                  DataCell(
                                    Container(
                                      width: maxwidth * 0.08,
                                      child: Text(item.yarncount.toString()),
                                    ),
                                  ),
                                if (selectedprodtype.toString().toLowerCase() ==
                                    'yarn')
                                  DataCell(
                                    Container(
                                      width: maxwidth * 0.10,
                                      child: Text(item.yarntype.toString()),
                                    ),
                                  ),
                                DataCell(
                                  Container(
                                    width: maxwidth * 0.10,
                                    child: Text(item.color.toString()),
                                  ),
                                ),
                                if (selectedprodtype.toString().toLowerCase() ==
                                    'fabric')
                                  DataCell(Container(
                                    width: maxwidth * 0.10,
                                    child:
                                        Text(item.dia.toString().toUpperCase()),
                                  )),
                                if (selectedprodtype.toString().toLowerCase() ==
                                    'fabric')
                                  DataCell(Container(
                                    width: maxwidth * 0.10,
                                    child:
                                        Text(item.uom.toString().toUpperCase()),
                                  )),
                                DataCell(
                                  Container(
                                    width: maxwidth * 0.08,
                                    child: Text(double.parse(item.noofbox)
                                        .toStringAsFixed(0)),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: maxwidth * 0.10,
                                    child: Text(double.parse(item.kgsperbox)
                                        .toStringAsFixed(3)),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: maxwidth * 0.10,
                                    child: Text(double.parse(item.weight)
                                        .toStringAsFixed(3)),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: maxwidth * 0.08,
                                    child: Text(double.parse(item.rate)
                                        .toStringAsFixed(2)),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: maxwidth * 0.10,
                                    child: Text(double.parse(item.amount)
                                        .toStringAsFixed(2)),
                                  ),
                                ),
                                DataCell(Row(
                                  children: [
                                    Container(
                                        width: maxwidth * 0.12,
                                        child: Row(children: [
                                          // IconButton(
                                          //     icon: Image.asset(
                                          //         'Images/edit.png',
                                          //         color: widgetcolor),
                                          //     highlightColor: Colors.pink,
                                          //     onPressed: () {
                                          //       setState(() {
                                          //         selectedcolor = '';
                                          //         selectedyarncount = '';
                                          //         _custyarntypeController.text =
                                          //             '';
                                          //         selectedyarnmill = '';

                                          //         selectedcolor = item.color;
                                          //         if (selectedprodtype
                                          //                 .toString()
                                          //                 .toLowerCase() ==
                                          //             'fabric') {
                                          //           //   this.setState(() {
                                          //           selecteddia = item.dia;
                                          //           selecteduom = item.uom;
                                          //           selectedfabknittype =
                                          //               item.knittype;
                                          //           selectedcomposition =
                                          //               item.composition;
                                          //           selectedfabtype =
                                          //               item.fabrictype;

                                          //           _custgsmController.text =
                                          //               item.gsm;
                                          //           selectedfabric =
                                          //               item.fabric;
                                          //           // });
                                          //         } else {
                                          //           // this.setState(() {
                                          //           _custyarntypeController
                                          //                   .text =
                                          //               item.yarntype
                                          //                   .toString();
                                          //           yarntypeid =
                                          //               item.yarntypeid;
                                          //           selectedyarncount = item
                                          //               .yarncount
                                          //               .toString();
                                          //           yarncountid =
                                          //               item.yarncountid;
                                          //           selectedyarnmill = item
                                          //               .yarnmill
                                          //               .toString();
                                          //           yarnmillid =
                                          //               item.yarnmillid;

                                          //           selectedcolor =
                                          //               item.color.toString();
                                          //           colorid = item.colorid;
                                          //           //selectedyarncolor = item.color;});
                                          //           //  });
                                          //         }

                                          //         _custweightController.text =
                                          //             item.weight;
                                          //         _custnoofboxController.text =
                                          //             item.noofbox;
                                          //         _custrateController.text =
                                          //             item.rate;
                                          //         _custamountController.text =
                                          //             item.amount;
                                          //         _custkgsperboxController
                                          //             .text = item.kgsperbox;
                                          //       });
                                          //       //refereshdetails(item);
                                          //       //  if (this.mounted)
                                          //       //    this.setState(() {
                                          //       //  selectedprodtype = 'fabric';
                                          //       // if (selectedprodtype
                                          //       //         .toString()
                                          //       //         .toLowerCase() ==
                                          //       //     'fabric') {
                                          //       //   getfabricdetails('');
                                          //       //   getfabknittypedetails('');
                                          //       //   getcolordetails('');
                                          //       //   getdiadetails('');
                                          //       //   getuomdetails('');
                                          //       //   getcompositiondetails('');
                                          //       //   getfabrictypedetails('');
                                          //       // }

                                          //       // if (selectedprodtype
                                          //       //         .toString()
                                          //       //         .toLowerCase() ==
                                          //       //     'yarn') {
                                          //       //   getyarncountdetails('');
                                          //       //   getyarntypedetails('');
                                          //       //   getyarnmilldetails('');
                                          //       //   getcolordetails('');
                                          //       // }

                                          //       _previousitem = item;
                                          //       removeItem(item);
                                          //       //});

                                          //       //  Itemid = item.itemMasterID;
                                          //       //  removeItem(item);
                                          //     }),
                                          // SizedBox(width: 2),
                                          IconButton(
                                              icon: Image.asset(
                                                  'Images/delete.png',
                                                  color: widgetcolor),
                                              highlightColor: Colors.pink,
                                              onPressed: () {
                                                removeItem(item);
                                              })
                                        ]))
                                  ],
                                )),
                              ]),
                            )
                            ?.toList() ??
                        [],
                  ))));
    } else {
      // pr.dismiss();
      return Text("Add details using the form below",
          textAlign: TextAlign.center);
    }

    //pr.dismiss();
  }

  Widget appbarwid() {
    return AppBar(
      backgroundColor: appbarcolor,
      leading: Builder(
        builder: (context) {
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
      title: TextFormField(
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
                  child: Text("PO No",
                      textScaleFactor: 1.7,
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        color: widgetcolor,
                      )),
                ),
                Expanded(
                  child: Text("Date",
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

  Widget bottomapp(double width, double height) {
    return BottomAppBar(
            color: appbarcolor,
            shape: CircularNotchedRectangle(),
            notchMargin: 6,
            child: Row(children: <Widget>[
              SizedBox(
                  width: width / 10,
                  child: IconButton(
                    icon: Image.asset('Images/search.png', color: widgetcolor),
                    onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                              height: height * .20,
                              child: TextFormField(
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
                                          duration: Duration(milliseconds: 300),
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
                icon: Image.asset('Images/Arrow-Left.png', color: widgetcolor),
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
                icon: Image.asset('Images/Arrow-Right.png', color: widgetcolor),
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
              enable = false;
              getcompanyMaster('');
              clearData(context);

              //setState(() {
              //   getCustomerJson();
              if ((_id != "") && (_id != null) && (_id != "0")) {
                _custIdController.text = _id.toString();
              } else {
                DateTime today = DateTime.now();
                dateCtl.text =
                    "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString()}";
                seldate =
                    "${today.year.toString()}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}";

                shipmentdateCtl.text =
                    "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString()}";
                selshipmentdate =
                    "${today.year.toString()}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}";
              }
            });
          }),
    );
  }

  purchaseorderdetl.PurchaseOrderDetails getitemdetails() {
    purchaseorderdetl.PurchaseOrderDetails _data;

    selamount = _custamountController.text;
    if (selamount != '' &&
        selamount != null &&
        ((selectedprodtype.toString().toLowerCase() == 'fabric' &&
                selectedfabric.toString() != '' &&
                selecteduom.toString() != '' &&
                selectedcolor.toString() != '' &&
                selectedfabknittype.toString() != '' &&
                selectedcomposition.toString() != '' &&
                selectedfabtype.toString() != '' &&
                selecteddia.toString() != '' &&
                _custgsmController.text.toString() != '' &&
                _custnoofboxController.text.toString() != '' &&
                _custweightController.text.toString() != '' &&
                _custrateController.text.toString() != '') ||
            (selectedprodtype.toString().toLowerCase() == 'yarn' &&
                selectedcolor.toString() != '' &&
                _custyarntypeController.text.toString() != '' &&
                selectedyarnmill.toString() != '' &&
                selectedyarncount.toString() != '' &&
                _custnoofboxController.text.toString() != '' &&
                _custweightController.text.toString() != '' &&
                _custrateController.text.toString() != ''))) {
      var convertDataToJson =
          (selectedprodtype.toString().toLowerCase() == 'fabric')
              ? json.decode('[{"fabric": ' +
                  '"' +
                  selectedfabric.toString() +
                  '" , ' +
                  '"FabricID": ' +
                  '"' +
                  fabricid.toString() +
                  '"' +
                  ' , "Amount": ' +
                  '' +
                  int.parse(_custamountController.text)
                      .toStringAsFixed(2)
                      .toString() +
                  '' +
                  ', "Composition": ' +
                  '"' +
                  selectedcomposition.toString() +
                  '"' +
                  ', "CompositionID": ' +
                  '"' +
                  compositionid.toString() +
                  '"' +
                  ', "Dia": ' +
                  '"' +
                  selecteddia.toString() +
                  '"' +
                  ', "DiaID": ' +
                  '"' +
                  diaid.toString() +
                  '"' +
                  ', "FabricType": ' +
                  '"' +
                  selectedfabtype.toString() +
                  '"' +
                  ', "FabricTypeID": ' +
                  '"' +
                  fabtypeid.toString() +
                  '"' +
                  ', "Color": ' +
                  '"' +
                  selectedcolor.toString() +
                  '"' +
                  ', "ColorID": ' +
                  '"' +
                  colorid.toString() +
                  '"' +
                  ', "gsm": ' +
                  '' +
                  _custgsmController.text.toString() +
                  '' +
                  ', "Kgsperbox": ' +
                  '' +
                  int.parse(_custkgsperboxController.text)
                      .toStringAsFixed(3)
                      .toString() +
                  '' +
                  ', "FabricKnitType": ' +
                  '"' +
                  selectedfabknittype.toString() +
                  '"' +
                  ', "FabricKnitTypeID": ' +
                  '"' +
                  fabknittypeid.toString() +
                  '"' +
                  ', "NoofBox": ' +
                  '' +
                  int.parse(_custnoofboxController.text)
                      .toStringAsFixed(0)
                      .toString() +
                  '' +
                  ', "Rate": ' +
                  '' +
                  int.parse(_custrateController.text)
                      .toStringAsFixed(2)
                      .toString() +
                  '' +
                  ', "Uom": ' +
                  '"' +
                  selecteduom.toString() +
                  '"' +
                  ', "UomID": ' +
                  '"' +
                  uomid.toString() +
                  '"' +
                  ', "Weight": ' +
                  '' +
                  int.parse(_custweightController.text)
                      .toStringAsFixed(3)
                      .toString() +
                  '' +
                  '}]')
              : json.decode('[{"YarnColor": ' +
                  '"' +
                  selectedcolor.toString() +
                  '"' +
                  ', "Amount": ' +
                  '"' +
                  (_custamountController.text).toString() +
                  '"' +
                  ', "YarnColorID": ' +
                  '"' +
                  colorid.toString() +
                  '"' +
                  ', "Kgsperbox": ' +
                  '"' +
                  (_custkgsperboxController.text).toString() +
                  '"' +
                  ', "NoofBox": ' +
                  '"' +
                  (_custnoofboxController.text).toString() +
                  '"' +
                  ', "Rate": ' +
                  '"' +
                  (_custrateController.text).toString() +
                  '"' +
                  ', "YarnMill": ' +
                  '"' +
                  selectedyarnmill.toString() +
                  '"' +
                  ', "YarnMillID": ' +
                  '"' +
                  yarnmillid.toString() +
                  '"' +
                  ', "YarnType": ' +
                  '"' +
                  _custyarntypeController.text.toString() +
                  '"' +
                  ', "YarnTypeId": ' +
                  '"' +
                  yarntypeid.toString() +
                  '"' +
                  ', "YarnCount": ' +
                  '"' +
                  selectedyarncount.toString() +
                  '"' +
                  ', "YarnCountID": ' +
                  '"' +
                  yarncountid.toString() +
                  '"' +
                  ', "Weight": ' +
                  '"' +
                  (_custweightController.text).toString() +
                  '"' +
                  '}]');

      final parsed = convertDataToJson.cast<Map<String, dynamic>>();
      _data = (selectedprodtype.toString().toLowerCase() == 'fabric')
          ? parsed
              .map<purchaseorderdetl.PurchaseOrderDetails>((json) =>
                  purchaseorderdetl.PurchaseOrderDetails.fromJSON(json))
              .first
          : parsed
              .map<purchaseorderdetl.PurchaseOrderDetails>((json) =>
                  purchaseorderdetl.PurchaseOrderDetails.fromyarnJSON(json))
              .first;
    }
    return _data;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sun Party',
        theme: new ThemeData(
          brightness: Brightness.light,
        ),
        home: LayoutBuilder(
            // key: key,
            builder: (context, BoxConstraints constraints) {
          var maxwidth = constraints.maxWidth;
          //  var minwidth = constraints.minWidth;
          var maxheight = constraints.maxHeight;
          // var minheight = constraints.minHeight;

          return ScreenTypeLayout.builder(
            //   key: key,
            // breakpoints:
            //     ScreenBreakpoints(desktop: 3840, tablet: 850, watch: null),
            tablet: (context) => showAddWidget == false
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
            mobile: (context) => showAddWidget == false
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
            desktop: (context) => showAddWidget == false
                ? Container(
                    width: maxwidth, //- 210,
                    // padding: EdgeInsets.only(left: 210),
                    height: maxheight,
                    child: Row(children: [
                      Expanded(
                          flex: 3,
                          child: Scaffold(
                            floatingActionButtonLocation:
                                FloatingActionButtonLocation.miniEndDocked,
                            floatingActionButton: addbutton(),
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
                        child: LayoutBuilder(
                            builder: (context, BoxConstraints constraints) {
                          var maxwidth = constraints.maxWidth;
                          //var minwidth = constraints.minWidth;
                          var maxheight = constraints.maxHeight;

                          ///var minheight = constraints.minHeight;

                          return addcustomerwid(maxwidth, maxheight);
                        }),
                      )
                    ]))
                : addcustomerwid(maxwidth, maxheight),
            watch: (context) => Container(color: Colors.purple),
          );
        })); //);
  }

  Future<String> getCustomerJson() async {
    if (this.mounted) {
      setState(() {
        _reportItems = [];
        totalPages = null;
      });
      String customerurl;

      if (searchtext == null || searchtext == '') {
        customerurl =
            "https://cors-anywhere.herokuapp.com/http://tap.suninfotechnologies.in/api/touch?&Mode=PO&spname=GetAndSubmitPODetails&intflag=3&pagesize=" +
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
      _reportItems = parsed
          .map<purchaseorderdetl.PurchaseOrderHeader>(
              (json) => purchaseorderdetl.PurchaseOrderHeader.fromJSON(json))
          .toList();

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
                itemBuilder: (context, int index) {
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
                              ' ' +
                                  _reportItems[index]
                                      .pono
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
                                  .podate
                                  .toLowerCase()
                                  .toString()
                                  .substring(0, 10),
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
                                  String id = _reportItems[index].headerid;
                                  _id = id;
                                  custselectedtype = selectedtype;
                                  custpageno = pageno;
                                  getfabricdetails('');
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
                                String id = _reportItems[index].headerid;

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
// }
// return null;
//     }
//     return widgets;
//   }
}
