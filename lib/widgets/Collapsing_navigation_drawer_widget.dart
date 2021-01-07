//import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:touchwoodapp/models/navigation_model.dart';
//import 'package:touchwoodapp/widgets/collapsing_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:touchwoodapp/screens/Supplierdashboard.dart' as supplier;
import 'package:touchwoodapp/screens/AddPurchaseOrder.dart' as PurchaseOrder;
import 'package:touchwoodapp/screens/CustomerDashboard.dart' as customer;
//import 'package:touchwoodapp/screens/relative.dart' as relative;
import 'package:touchwoodapp/Widgets/custom_expansion_tile.dart' as custom;
import 'package:touchwoodapp/Widgets/sidebar.dart' as sidebar;
import 'package:touchwoodapp/screens/AddUom.dart' as Uom;
import 'package:touchwoodapp/screens/AddYarn.dart' as Yarn;
import 'package:touchwoodapp/screens/AddMaster.dart' as Master;
import 'package:touchwoodapp/screens/AddFabric.dart' as Fabric;
import 'package:touchwoodapp/screens/AddGranite.dart' as Granite;
import 'package:touchwoodapp/repository/assigncolor.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 210;
  double minWidth = 70;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

// Widget innerwidget(){
//   return   ListView(
//                 shrinkWrap: true,
//                 children: <Widget>[
//                   Row(
//                     children: [
//                       Spacer(),
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             isCollapsed = !isCollapsed;
//                             isCollapsed
//                                 ? _animationController.forward()
//                                 : _animationController.reverse();
//                           });
//                         },
//                         child: AnimatedIcon(
//                           icon: AnimatedIcons.close_menu,
//                           progress: _animationController,
//                           color: widgetcolor,
//                           size: 50.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                   UserAccountsDrawerHeader(
//                     accountName: Text("Sun Info Technologies"),
//                     accountEmail: Text("www.suninfotechnologies.in"),
//                     currentAccountPicture: CircleAvatar(
//                       backgroundColor:
//                           Theme.of(context).platform == TargetPlatform.iOS
//                               ? Colors.blue
//                               : Colors.white,
//                       child: Text(
//                         "S",
//                         style: TextStyle(fontSize: 40.0),
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     color: Colors.grey,
//                     height: 40.0,
//                   ),
//                   custom.ExpansionTile(
//                       title: ListTile(
//                         onTap: () {
//                           //  mastertapped = (mastertapped) ? false : true;
//                         },
//                         //  leading: Icon(Icons.settings_applications),
//                         title: Text("Master"),
//                       ),
//                       iconColor: Colors.white,
//                       children: <Widget>[
//                         ListTile(
//                           onTap: () {},
//                           leading: Image.asset(
//                             'images/people.png',
//                           ),
//                           title: Text("Party"),
//                         ),
//                         ListTile(
//                           onTap: () {
//                             //Navigator.of(context).pop();
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Yarn.HomePage("10", 1)));
//                           },
//                           leading: Image.asset(
//                             'images/group.png',
//                           ),
//                           title: Text("Yarn"),
//                         ),
//                         ListTile(
//                           onTap: () {
//                             //Navigator.of(context).pop();
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Fabric.HomePage("10", 1)));
//                           },
//                           leading: Image.asset(
//                             'images/group.png',
//                           ),
//                           title: Text("Fabric"),
//                         ),
//                         ListTile(
//                           onTap: () {
//                             //Navigator.of(context).pop();
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Fabric.HomePage("10", 1)));
//                           },
//                           leading: Image.asset(
//                             'images/group.png',
//                           ),
//                           title: Text("Fabric"),
//                         ),
//                         ListTile(
//                           onTap: () {
//                             //Navigator.of(context).pop();
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Granite.HomePage("10", 1)));
//                           },
//                           leading: Image.asset(
//                             'images/group.png',
//                           ),
//                           title: Text("Granite"),
//                         ),
//                         ListTile(
//                           onTap: () {
//                             //Navigator.of(context).pop();
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => sidebar.MyApp()));
//                           },
//                           leading: Image.asset(
//                             'images/group.png',
//                           ),
//                           title: Text("side bar"),
//                         ),
//                         ListTile(
//                           onTap: () {
//                             //Navigator.of(context).pop();
//                             //Navigator.popAndPushNamed(context, Routes.Addparty(key: null,title:"Add Customer"));
//                           },
//                           leading: Image.asset('images/uom.png'),
//                           title: Text("UOM"),
//                         ),
//                         ListTile(
//                           onTap: () {
//                             //Navigator.of(context).pop();
//                             //Navigator.popAndPushNamed(context, Routes.Addparty(key: null,title:"Add Customer"));
//                           },
//                           leading: Image.asset('images/uom.png'),
//                           title: Text("Rapid Test"),
//                         ),
//                         ListTile(
//                           onTap: () {
//                             //Navigator.of(context).pop();
//                             //Navigator.popAndPushNamed(context, Routes.Addparty(key: null,title:"Add Customer"));
//                           },
//                           leading: Image.asset('images/additem.png'),
//                           title: Text("Item"),
//                         ),
//                         ListTile(),
//                       ]),
//                   Divider(
//                     height: 1,
//                     color: Colors.black,
//                   ),
//                   custom.ExpansionTile(
//                     title: ListTile(
//                       onTap: () {
//                         debugPrint("Tapped settings");
//                       },
//                       // leading: Icon(Icons.settings),
//                       title: Text("Transaction"),
//                     ),
//                     children: [
//                       ListTile(
//                         onTap: () {
//                           //Navigator.of(context).pop();
//                           //Navigator.popAndPushNamed(context, Routes.Addparty(key: null,title:"Add Customer"));
//                         },
//                         leading: Image.asset(
//                           'images/pricelist.png',
//                         ),
//                         title: Text("Price List"),
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     height: 1,
//                     color: Colors.black,
//                   ),
//                   custom.ExpansionTile(
//                     title: ListTile(
//                       onTap: () {
//                         debugPrint("Tapped settings");
//                       },
//                       // leading: Icon(Icons.settings),
//                       title: Text("Reports"),
//                     ),
//                     children: [
//                       ListTile(
//                         onTap: () {},
//                         leading: Image.asset(
//                           'images/pricelist.png',
//                         ),
//                         title: Text("PriceList Report"),
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     height: 1,
//                     color: Colors.black,
//                   ),
//                 ],
//               );
// }

  Widget getWidget(context, widget) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Material(
      elevation: 80.0,
      child: Container(
        width: widthAnimation.value,
        color: widgetcolor,
        child: Column(
          children: <Widget>[
            Container(
                color: appbarcolor,
                width: 250, //mediaQuery.size.width * 0.40,
                height: mediaQuery.size.height,
                //child: Drawer(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView(
                        //scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: <Widget>[
                          Row(
                            children: [
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isCollapsed = !isCollapsed;
                                    isCollapsed
                                        ? _animationController.forward()
                                        : _animationController.reverse();
                                  });
                                },
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.close_menu,
                                  progress: _animationController,
                                  color: widgetcolor,
                                  size: 40.0,
                                ),
                              ),
                            ],
                          ),
                          UserAccountsDrawerHeader(
                            decoration: BoxDecoration(color: widgetcolor),
                            accountName: Text("Sun Info Technologies"),
                            accountEmail: Text("www.suninfotechnologies.in"),
                            currentAccountPicture: CircleAvatar(
                              // backgroundColor: widgetcolor,
                              child: Text(
                                "S",
                                style: TextStyle(fontSize: 40.0),
                              ),
                            ),
                          ),
                          // Divider(
                          //   color: widgetcolor,
                          //   height: 40.0,
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: ListView(
                          //  scrollDirection: Axis.vertical,
                          children: [
                            custom.ExpansionTile(
                                initiallyExpanded: true,
                                headerBackgroundColor: widgetcolor,
                                title: ListTile(
                                  onTap: () {
                                    //  mastertapped = (mastertapped) ? false : true;
                                  },
                                  //  leading: Icon(Icons.settings_applications),
                                  title: Text("Master"),
                                ),
                                iconColor: appbarcolor,
                                children: <Widget>[
                                  custom.ExpansionTile(
                                      backgroundColor: appbarcolor,
                                      // initiallyExpanded: true,
                                      headerBackgroundColor: widgetcolor,
                                      title: ListTile(
                                        //   tileColor: Colors.pink,
                                        onTap: () {
                                          //  mastertapped = (mastertapped) ? false : true;
                                        },
                                        //  leading: Icon(Icons.settings_applications),
                                        title: Text("General"),
                                      ),
                                      iconColor: appbarcolor,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Product Type",
                                                tablename: "producttypemaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Product Type"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            //   contentPadding: EdgeInsets.all(2),
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Currency",
                                                tablename: "currencymaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Currency"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Port of Discharge",
                                                tablename:
                                                    "portofdischargemaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Port of Discharge"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Port of Loading",
                                                tablename:
                                                    "portofloadingmaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Port of Loading"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Shipment",
                                                tablename: "shipmentmodemaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Shipment"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Color",
                                                tablename: "colormaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Color"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Uom.HomePage ad =
                                                  new Uom.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Uom.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Uom"),
                                          ),
                                        ),
                                      ]),
                                  custom.ExpansionTile(
                                      backgroundColor: appbarcolor,
                                      // initiallyExpanded: true,
                                      headerBackgroundColor: widgetcolor,
                                      title: ListTile(
                                        //   tileColor: Colors.pink,
                                        onTap: () {
                                          //  mastertapped = (mastertapped) ? false : true;
                                        },
                                        //  leading: Icon(Icons.settings_applications),
                                        title: Text("Fabric Master"),
                                      ),
                                      iconColor: appbarcolor,
                                      children: <Widget>[
                                        Container(
                                          child: ListTile(
                                            //    leading: Text("Master"),
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Fabric Knit Type",
                                                tablename:
                                                    "fabricdknittypemaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Fabric Knit Type"),
                                          ),
                                          padding: EdgeInsets.only(bottom: 5),
                                          //constraints: BoxConstraints(),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          child: ListTile(
                                            //    leading: Text("Master"),
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername:
                                                    "Fabric Composition",
                                                tablename:
                                                    "fabriccompositionmaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Fabric Composition"),
                                          ),
                                          padding: EdgeInsets.only(bottom: 5),
                                          //constraints: BoxConstraints(),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Fabric Type",
                                                tablename: "fabrictypemaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Fabric Type"),
                                          ),
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Fabric Name",
                                                tablename: "fabricnamemaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Fabric Name"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Fabric Dia",
                                                tablename: "fabricdiamaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Fabric Dia"),
                                          ),
                                        ),
                                      ]),
                                  custom.ExpansionTile(
                                      backgroundColor: appbarcolor,
                                      // initiallyExpanded: true,
                                      headerBackgroundColor: widgetcolor,
                                      title: ListTile(
                                        //   tileColor: Colors.pink,
                                        onTap: () {
                                          //  mastertapped = (mastertapped) ? false : true;
                                        },
                                        //  leading: Icon(Icons.settings_applications),
                                        title: Text("Yarn Master"),
                                      ),
                                      iconColor: appbarcolor,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Yarn Count",
                                                tablename: "yarncountmaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                            headername:
                                                                "Yarn Count",
                                                            tablename:
                                                                "yarncountmaster",
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Counts"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Yarn Type",
                                                tablename: "yarntypemaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                            headername:
                                                                "Yarn Type",
                                                            tablename:
                                                                "yarntypemaster",
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Yarn Type"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Master.HomePage ad =
                                                  new Master.HomePage(
                                                selectedType: "10",
                                                pageNo: 1,
                                                headername: "Yarn Mill",
                                                tablename: "yarnmillmaster",
                                              );
                                              ad.custid;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Master.HomePage(
                                                            selectedType: "10",
                                                            pageNo: 1,
                                                            headername:
                                                                "Yarn Mill",
                                                            tablename:
                                                                "yarnmillmaster",
                                                          )));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Yarn Mill"),
                                          ),
                                        ),
                                      ]),
                                  custom.ExpansionTile(
                                      backgroundColor: appbarcolor,
                                      // initiallyExpanded: true,
                                      headerBackgroundColor: widgetcolor,
                                      title: ListTile(
                                        //   tileColor: Colors.pink,
                                        onTap: () {
                                          //  mastertapped = (mastertapped) ? false : true;
                                        },
                                        //  leading: Icon(Icons.settings_applications),
                                        title: Text("Party"),
                                      ),
                                      iconColor: appbarcolor,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          supplier.HomePage(
                                                              "10", 1)));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Supplier"),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: widgetcolor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          customer.HomePage(
                                                              "10", 1)));
                                            },
                                            // leading: Image.asset(
                                            //   'images/people.png',
                                            // ),
                                            title: Text("Customer"),
                                          ),
                                        ),
                                      ]),
                                  // Divider(
                                  //   height: 1,
                                  //   color: widgetcolor,
                                  // ),
                                  // ListTile(
                                  //   onTap: () {
                                  //     //Navigator.of(context).pop();
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 Master.HomePage(
                                  //                     selectedType: "10",
                                  //                     pageNo: 1)));
                                  //   },
                                  //   // leading: Image.asset(
                                  //   //   'images/group.png',
                                  //   // ),
                                  //   title: Text("Yarn Type"),
                                  // ),
                                  // Divider(
                                  //   height: 1,
                                  //   color: widgetcolor,
                                  // ),
                                  // ListTile(
                                  //   onTap: () {
                                  //     //Navigator.of(context).pop();
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 Fabric.HomePage("10", 1)));
                                  //   },
                                  //   // leading: Image.asset(
                                  //   //   'images/group.png',
                                  //   // ),
                                  //   title: Text("Fabric"),
                                  // ),
                                  // Divider(
                                  //   height: 1,
                                  //   color: widgetcolor,
                                  // ),
                                  // ListTile(
                                  //   onTap: () {
                                  //     //Navigator.of(context).pop();
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 Fabric.HomePage("10", 1)));
                                  //   },
                                  //   // leading: Image.asset(
                                  //   //   'images/group.png',
                                  //   // ),
                                  //   title: Text("Fabric"),
                                  // ),
                                  // Divider(
                                  //   height: 1,
                                  //   color: widgetcolor,
                                  // ),
                                  // ListTile(
                                  //   onTap: () {
                                  //     //Navigator.of(context).pop();
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 Granite.HomePage("10", 1)));
                                  //   },
                                  //   // leading: Image.asset(
                                  //   //   'images/group.png',
                                  //   // ),
                                  //   title: Text("Granite"),
                                  // ),
                                  // Divider(
                                  //   height: 1,
                                  //   color: widgetcolor,
                                  // ),
                                  // ListTile(
                                  //   onTap: () {
                                  //     //Navigator.of(context).pop();
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 sidebar.MyApp()));
                                  //   },
                                  //   // leading: Image.asset(
                                  //   //   'images/group.png',
                                  //   // ),
                                  //   title: Text("side bar"),
                                  // ),
                                  // Divider(
                                  //   height: 1,
                                  //   color: widgetcolor,
                                  // ),
                                  //ListTile(),
                                ]),
                            Divider(
                              height: 1,
                              color: widgetcolor,
                            ),
                            custom.ExpansionTile(
                              headerBackgroundColor: widgetcolor,
                              title: ListTile(
                                onTap: () {
                                  debugPrint("Tapped settings");
                                },
                                // leading: Icon(Icons.settings),
                                title: Text("Transaction"),
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: ListTile(
                                    onTap: () {
                                      PurchaseOrder.HomePage ad =
                                          new PurchaseOrder.HomePage(
                                        selectedType: "10",
                                        pageNo: 1,
                                      );
                                      ad.custid;

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PurchaseOrder.HomePage(
                                                    selectedType: "10",
                                                    pageNo: 1,
                                                  )));
                                    },
                                    // leading: Image.asset(
                                    //   'images/people.png',
                                    // ),
                                    title: Text("Purchase Order"),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: widgetcolor,
                            ),
                            custom.ExpansionTile(
                              headerBackgroundColor: widgetcolor,
                              title: ListTile(
                                onTap: () {
                                  debugPrint("Tapped settings");
                                },
                                // leading: Icon(Icons.settings),
                                title: Text("Reports"),
                              ),
                              children: [
                                ListTile(
                                  onTap: () {},
                                  // leading: Image.asset(
                                  //   'images/pricelist.png',
                                  // ),
                                  title: Text("PriceList Report"),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: widgetcolor,
                            ),
                          ],
                        ))
                  ],
                )
                //)
                ),
          ],
        ),
      ),
    );
  }
}
