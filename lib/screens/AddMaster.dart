import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:touchwoodapp/models/Master.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:touchwoodapp/repository/Master_repository.dart';
import 'package:touchwoodapp/widgets/custom_drawer.dart' as drawer;
import 'package:touchwoodapp/models/Paging.dart';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:touchwoodapp/screens/main.dart';
import 'package:touchwoodapp/widgets/collapsing_navigation_drawer_widget.dart'
    as drawer;
import 'package:responsive_builder/responsive_builder.dart';
import 'package:touchwoodapp/repository/assigncolor.dart';

bool ShowAddWidget = false;

bool enable = false;

void main() => runApp(new MaterialApp(
      home: new HomePage(),
      theme: new ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
    ));

String name = "";

TextEditingController _masterIdController;
FocusNode idFocusNode;
String _id;
String searchtext = '';

PageController controller = PageController();
Paging _pagingdetails = new Paging();
List<Master> data = <Master>[];
List<Master> _reportItems = <Master>[]; //dbHelper.getAllBudget();
int pageno;
bool del = false;

List<Paging> paging = new List<Paging>();
String selectedtype = "10";
String totalCount;
String pageSize;
String currentPage;
String totalPages;
String previousPage;
String nextPage;
String tableName;
Master _category;
String headerName;

class HomePage extends StatefulWidget {
  // reference to our single class that manages the database
  String tablename;
  String headername;
  HomePage({Key key, this.tablename, this.headername}) : super(key: key);

  String get gettablename {
    tableName = tablename;
    headerName = headername;
  }

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final _masterNameController = TextEditingController();

  @override
  void initState() {
    generateReport();
    getPagingDetails();
//myFocusNode = FocusNode();
    super.initState();
  }

  PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  void dispose() {
    _masterNameController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
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
                                        //                    getCustomerJson();
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
                          //        getCustomerJson();
                        });
                      }),
                ),
              SizedBox(
                width: width / 40,
              ),
              new IconButton(
                icon: Image.asset('Images/Arrow-Left.png', color: widgetcolor),
                iconSize: 20,
                color: Colors.blue,
                splashColor: Colors.green,
                onPressed: () {
                  setState(() {
                    if ((pageno != 1) && (pageno != 0)) pageno = pageno - 1;
                    //    getCustomerJson();
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
                    //      getCustomerJson();
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
      tooltip: 'Add new ' + headerName + ' entry',
      child: IconButton(
          icon: Image.asset('images/add.png', color: Colors.black),
          onPressed: () {
            setState(() {
              //  ShowAddWidget = true;
              // _id = '0';
              // custpageno = pageno;
              // custselectedtype = selectedtype;
              // getAddCustomerJson();
              // getGroupMaster('');
              //setState(() {
              //   getCustomerJson();
              // if ((_id != "") && (_id != null) && (_id != "0"))
              //   _custIdController.text = _id.toString();
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
                  // getCustomerJson();
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
              //  getCustomerJson();
            });
          }),
    );
  }

  Widget bodywid(double maxwidth, double maxheight) {
    return SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
          // SizedBox(
          //   height: 20,
          // ),

          SizedBox(
            height: 20,
          ),

          Row(children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: 20,
                  minWidth: 250,
                  maxWidth: 400,
                  // maxWidth: (MediaQuery.of(context).size.width) <= 280
                  //     ? (MediaQuery.of(context).size.width)
                  //     : (MediaQuery.of(context).size.width) * 0.,
                  maxHeight: double.infinity),
              width: (MediaQuery.of(context).size.width),
              child: TextField(
                focusNode: idFocusNode,
                controller: _masterNameController,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    border: InputBorder.none,
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20.0)),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
            Spacer(),
          ]),
          SizedBox(
            height: 10,
          ),

          Row(children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: 20,
                  minWidth: 250,
                  maxWidth: 400,
                  maxHeight: double.infinity),
              width: (MediaQuery.of(context).size.width),
              height: 30,
              child: Row(
                children: <Widget>[
                  // SizedBox(
                  //   height: 10,
                  //   width: 220,
                  // ),
                  Spacer(),
                  RaisedButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      if ((_id == '0' || (_id == null) || (_id == "")) &&
                          (_reportItems
                              .where((element) =>
                                  element.columnname.toLowerCase() ==
                                  _masterNameController.text.toLowerCase())
                              .isNotEmpty)) {
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
                                  clearData(context);
                                  generateReport();

                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                width: 120,
                              )
                            ]).show();
                        clearData(context);
                      } else {
                        saveItems(false);
                        generateReport();
                        clearData(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'Images/save.png',
                          color: Colors.black,
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          "SAVE",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  RaisedButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      clearData(context);
                      idFocusNode.dispose();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('Images/cancel.png', color: Colors.black),
                        SizedBox(width: 12.0),
                        Text(
                          "CANCEL",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //tableView(),
                ],
              ),
            ),
          ]),
          Divider(),

          Row(children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: 20,
                  minWidth: 280,
                  maxWidth: 500,
                  maxHeight: double.infinity),
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                // pageSnapping: false,
                // dragStartBehavior: DragStartBehavior.start,
                children: tableView(),
                onPageChanged: (index) {
                  setState(() {
                    pageno = (index == 0 ? 1 : index);
                    generateReport();
                  });
                },
              ),
            ),
            Spacer(),
          ])
        ]));
    // );
  }

  void saveItems(bool del) async {
    String custName = _masterNameController.text;
    //  String id = _masterIdController.text;
    if (_id == null || (_id == '')) _id = '0';
    if (custName != '' && _id != '') {
      Stream<String> stream = await insertMaster(
          _id, 'groupMaster', '1', custName, (del == true ? '1' : '0'));
      stream.listen((String message) => setState(() {
            if (message.contains("""[{"RESULT":1}]""") ||
                message.contains("""[{"RESULT":2}]""")) {
              Alert(
                  context: context,
                  title: "Done!",
                  desc: (del == true)
                      ? "Data deleted Successfully"
                      : "Data saved successfully",
                  type: AlertType.success,
                  style: AlertStyle(isCloseButton: false),
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        clearData(context);
                        generateReport();

                        Navigator.of(context, rootNavigator: true).pop();
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
                  style: AlertStyle(isCloseButton: false),
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      width: 120,
                    )
                  ]).show();
            }
          }));
    } else {
      Alert(
          context: context,
          type: AlertType.error,
          title: "Error",
          desc: "Enter Customer ID and Name",
          style: AlertStyle(isCloseButton: false),
          buttons: [
            DialogButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              width: 120,
            )
          ]).show();
    }
  }

  getPagingDetails() async {
    setState(() {
      _pagingdetails = null;
      totalPages = null;
    });
    String customerurl;
    if (searchtext == null || searchtext == '') {
      customerurl =
          'https://cors-anywhere.herokuapp.com/http://tap.suninfotechnologies.in/api/touch?&pagenumber=1&pagesize=20&Mode=master&spname=GetAndSubmitMasterTable&intflag=1&strTableName=YarnCountMaster&strColumnData=30s&intOrganizationMasterID=1';
    } else {
      customerurl =
          "https://cors-anywhere.herokuapp.com/http://posmmapi.suninfotechnologies.in/api/master?&intflag=4&strTableName=groupmaster&pagesize=" +
              selectedtype.toString() +
              "&strColumnData=" +
              searchtext;
    }

    final response = await http.get(
      Uri.encodeFull(customerurl),
      headers: {
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var convertDataToJson;
      convertDataToJson = json.decode(response.headers['paging-headers']);

      final paparsed = convertDataToJson.cast<String, dynamic>();
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

  void clearData(context) {
    _masterNameController.text = '';
    _id = '';
    // Navigator.pop(context);
    //  FocusScope.of(context).requestFocus(idFocusNode);
  }

  List<Widget> tableView() {
    //getPagingDetails(pagesize: selectedtype);
    List<Widget> widgets = <Widget>[];
    //totalPages = "14";
    if (totalPages != null) {
      for (int i = 0; i < int.parse(totalPages); i++) {
        if (_reportItems.length > 0) {
          widgets.add(SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _reportItems.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    height: 60,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Expanded(
                              child: Text(
                                _reportItems[index]
                                    .columnname
                                    .toLowerCase()
                                    .toString(),
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.left,
                              ),
                            ),

                            Expanded(
                              child: IconButton(
                                icon: Image.asset('Images/edit.png',
                                    color: Colors.orange),
                                highlightColor: Colors.pink,
                                onPressed: () {
                                  _id = _reportItems[index]
                                      .columnMasterid
                                      .toString();
                                  _masterNameController.text =
                                      _reportItems[index].columnname.toString();
                                  // saveItems();
                                  setState(() {
                                    generateReport();
                                  });
                                  //
                                  //
                                },
                              ),
                            ),
                            Expanded(
                                child: IconButton(
                              icon: Image.asset('Images/delete.png',
                                  color: Colors.orange),
                              highlightColor: Colors.pink,
                              onPressed: () {
                                clearData(context);
                                _id = _reportItems[index]
                                    .columnMasterid
                                    .toString();
                                _masterNameController.text =
                                    _reportItems[index].columnname.toString();

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
                                          del = true;
                                          if (yesflag) {
                                            if (_id != '0' || _id != null) {
                                              saveItems(true);
                                            }
                                          }
                                          getPagingDetails();

                                          generateReport();
                                          clearData(context);
                                          del = false;
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

                                // del = true;
                                // saveItems();

                                // setState(() {
                                //   generateReport();
                                // });

                                // clearData(context);
                                // //
                                // del = false;
                              },
                            )),
                          ],
                        ), //,
                      ),
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

  Widget addcustomerwid(double maxwidth, double maxheight) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text(
              'Add ' + headerName,
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
                                                  labelText: "Name",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20.0)),
                                              keyboardType: TextInputType.text,
                                              //style: textStyle,
                                              controller: _masterIdController,
                                              //focusNode: custidFocusNode,

                                              readOnly: enable,
                                              //enableInteractiveSelection: enable,
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
                        saveItems(false);
                      } else {
                        final String customerurl =
                            "http://posmmapi.suninfotechnologies.in/api/partymaster?&intflag=5&strPartyname=" +
                                _masterIdController.text;

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
                          saveItems(false);

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

  List<Master> _masters;

  // Future<String> generateReport() async {
  //   setState(() {
  //     _reportItems = [];
  //   });
  //   final String customerurl =
  //       MyApp.BASE_URL + '/master?&intflag=4&strTableName=groupmaster';

  //   var response = await http.get(Uri.encodeFull(customerurl),
  //       headers: {"Accept": "application/json"});

  //   var convertDataToJson;
  //   List<Master> customer = new List<Master>();

  //   convertDataToJson = json.decode(response.body);
  //   final parsed = convertDataToJson.cast<Map<String, dynamic>>();
  //   customer = parsed.map<Master>((json) => Master.fromJSON(json)).toList();
  //   _masters = customer;
  //   _masters.forEach((element) => setState(() {
  //         _reportItems.add(element);
  //       }));

  //   data = _reportItems;
  //   return "customer";
  // }

  void generateReport() async {
    setState(() {
      _reportItems = [];
    });
    String customerurl1;

    if (searchtext == null || searchtext == '') {
      customerurl1 =
          'https://cors-anywhere.herokuapp.com/http://tap.suninfotechnologies.in/api/touch?&pagenumber=' +
              ((pageno.toString() != 'null' &&
                      pageno.toString() != '' &&
                      pageno.toString() != '0')
                  ? pageno.toString()
                  : '1') +
              '&pagesize=' +
              selectedtype.toString() +
              '&Mode=master&spname=GetAndSubmitMasterTable&intflag=4' +
              '&strTableName=' +
              tableName +
              '&intOrganizationMasterID=1&strcolumnname=test';
    } else {
      customerurl1 =
          "https://cors-anywhere.herokuapp.com/http://posmmapi.suninfotechnologies.in/api/master?&intflag=4&strTableName=groupmaster&pagesize=" +
              selectedtype.toString() +
              '&strColumnData=' +
              searchtext +
              "&pagenumber=" +
              ((pageno.toString() != 'null' &&
                      pageno.toString() != '' &&
                      pageno.toString() != '0')
                  ? pageno.toString()
                  : '1');
    }

    var response = await http.get(Uri.encodeFull(customerurl1),
        headers: {"Accept": "application/json"});

    var convertDataToJson1 = json.decode(response.body);
    final parsed = convertDataToJson1.cast<Map<String, dynamic>>();
    setState(() {
      _reportItems =
          parsed.map<Master>((json) => Master.fromJSON(json)).toList();
      data = _reportItems;
    });

    data = _reportItems;
  }

  TextEditingController returntext(String value) {
    TextEditingController usercontroller = new TextEditingController();
    if (value == "null" || value == "") {
//usercontroller//.text = 'fgf';
    } else {
      //   usercontroller.clear();
      usercontroller.text = value;
    }
    return usercontroller;
  }
}
