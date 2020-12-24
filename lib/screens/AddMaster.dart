import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:sunparty/models/Master.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sunparty/repository/Master_repository.dart';
import 'package:sunparty/widgets/custom_drawer.dart' as drawer;
import 'package:sunparty/models/Paging.dart';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sunparty/main.dart';

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
String id;
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

Master _category;

class HomePage extends StatefulWidget {
  // reference to our single class that manages the database

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
      title: 'Group Master',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset(
                  'images/menu.png',
                  color: Colors.orange,
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
              decoration: InputDecoration(
                hintText: "Search...",
                suffixIcon: IconButton(
                    icon:
                        Image.asset('Images/search.png', color: Colors.orange),
                    onPressed: () {
                      setState(() {
                        pageno = 1;
                      });

                      generateReport();
                      getPagingDetails();
                    }),
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  pageno = 1;
                  searchtext = value;
                  //data = _reportItems;
                  // _reportItems = (data
                  //     .where((element) => element.columnname
                  //         .toLowerCase()
                  //         .contains(value.toLowerCase()))
                  //     .toList());
                  // if (value == "") _reportItems = data;
                  generateReport();
                  getPagingDetails();
                });
                // _reportItems = data;
              }),
          // centerTitle: true,
        ),
        bottomNavigationBar: BottomAppBar(
            //    titleSpacing: 0.0,
            color: Colors.transparent,
            //elevation: 5.0,
            //  backgroundColor: Color(0xff201F23),
            // title:
            shape: CircularNotchedRectangle(),
            child: Row(children: <Widget>[
              SizedBox(
                  width: 50,
                  child: IconButton(
                    icon:
                        Image.asset('Images/search.png', color: Colors.orange),
                    onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => Container(
                              height: 500,
                              child: TextField(
                                  // focusNode: idFocusNode,
                                  style: TextStyle(fontSize: 15),
                                  decoration:
                                      InputDecoration(hintText: "GO TO"),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    if (int.parse(value) <=
                                        int.parse(totalPages)) {
                                      setState(() {
                                        pageno = int.parse(value);
                                        generateReport();
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
                width: 10,
              ),
              SizedBox(
                width: 90,
                child: DropdownButton<String>(
                    icon: Image.asset('Images/arrow_drop_down.png',
                        color: Colors.white),
                    value: selectedtype,
                    hint: SizedBox(width: 4, child: Text('Rows Per Page')),
                    items: ['5', '7', '10', '20', '30', '40', '50']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: 60.0,
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
                        getPagingDetails();
                        generateReport();
                      });
                    }),
              ),
              new IconButton(
                icon:
                    Image.asset('Images/Arrow-Left.png', color: Colors.orange),
                iconSize: 20,
                color: Colors.orange,
                splashColor: Colors.green,
                onPressed: () {
                  setState(() {
                    if ((pageno != 1) && (pageno != 0)) pageno = pageno - 1;
                    generateReport();
                    _controller.animateToPage(
                      pageno,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  });
                },
              ),
              Text((pageno == 0 ? 1 : pageno).toString() +
                  '  of  ' +
                  totalPages.toString()),
              new IconButton(
                icon:
                    Image.asset('Images/Arrow-Right.png', color: Colors.orange),
                iconSize: 20,
                color: Colors.orange,
                splashColor: Colors.green,
                onPressed: () {
                  setState(() {
                    if ((pageno < int.parse(totalPages))) pageno = pageno + 1;
                    generateReport();
                    _controller.animateToPage(
                      pageno,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  });
                },
              ),
            ])),
        drawer: drawer.CustomDrawer(),
        body: SingleChildScrollView(
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
                          if ((id == '0' || (id == null) || (id == "")) &&
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
                            _insert(false);
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
                            Image.asset('Images/cancel.png',
                                color: Colors.black),
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
            ])),
      ),
    );
  }

  void _insert(bool del) async {
    String custName = _masterNameController.text;
    //  String id = _masterIdController.text;
    if (id == null || (id == '')) id = '0';
    if (custName != '' && id != '') {
      Stream<String> stream = await insertMaster(
          id, 'groupMaster', '1', custName, (del == true ? '1' : '0'));
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
          "https://cors-anywhere.herokuapp.com/http://posmmapi.suninfotechnologies.in/api/master?&intflag=4&strTableName=groupmaster&pagesize=" +
              selectedtype.toString();
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
    id = '';
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
                                  id = _reportItems[index]
                                      .columnMasterid
                                      .toString();
                                  _masterNameController.text =
                                      _reportItems[index].columnname.toString();
                                  // _insert();
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
                                id = _reportItems[index]
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
                                            if (id != '0' || id != null) {
                                              _insert(true);
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
                                // _insert();

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
//     Stream<Master> stream = await getMasters(
//         pagesize: (selectedtype == "" ? '10' : selectedtype),
//         pagenum: ((pageno.toString() != 'null' &&
//                 pageno.toString() != '' &&
//                 pageno.toString() != '0')
//             ? pageno.toString()
//             : '1'),
//         text: searchtext);
//     stream.forEach((element) => setState(() {
//           _reportItems.add(element);
//         }));
    String customerurl1;

    if (searchtext == null || searchtext == '') {
      customerurl1 =
          "https://cors-anywhere.herokuapp.com/http://posmmapi.suninfotechnologies.in/api/master?&intflag=4&strTableName=groupmaster&pagesize=" +
              selectedtype.toString() +
              "&pagenumber=" +
              ((pageno.toString() != 'null' &&
                      pageno.toString() != '' &&
                      pageno.toString() != '0')
                  ? pageno.toString()
                  : '1');
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
