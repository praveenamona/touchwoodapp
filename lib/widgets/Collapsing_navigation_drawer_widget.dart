//import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:touchwoodapp/models/navigation_model.dart';
import 'package:touchwoodapp/widgets/collapsing_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:touchwoodapp/screens/dashboard.dart' as dashboard;
import 'package:touchwoodapp/screens/relative.dart' as relative;
import 'package:touchwoodapp/Widgets/custom_expansion_tile.dart' as custom;
import 'package:touchwoodapp/Widgets/sidebar.dart' as sidebar;
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
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  dashboard.HomePage("10", 1)));
                                    },
                                    leading: Image.asset(
                                      'images/people.png',
                                    ),
                                    title: Text("Party"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      //Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Master.HomePage("yarntype",
                                                      "Yarn Type")));
                                    },
                                    leading: Image.asset(
                                      'images/group.png',
                                    ),
                                    title: Text("Yarn Type"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      //Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Fabric.HomePage("10", 1)));
                                    },
                                    leading: Image.asset(
                                      'images/group.png',
                                    ),
                                    title: Text("Fabric"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      //Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Fabric.HomePage("10", 1)));
                                    },
                                    leading: Image.asset(
                                      'images/group.png',
                                    ),
                                    title: Text("Fabric"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      //Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Granite.HomePage("10", 1)));
                                    },
                                    leading: Image.asset(
                                      'images/group.png',
                                    ),
                                    title: Text("Granite"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      //Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  sidebar.MyApp()));
                                    },
                                    leading: Image.asset(
                                      'images/group.png',
                                    ),
                                    title: Text("side bar"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      //Navigator.of(context).pop();
                                      //Navigator.popAndPushNamed(context, Routes.Addparty(key: null,title:"Add Customer"));
                                    },
                                    leading: Image.asset('images/uom.png'),
                                    title: Text("UOM"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      //Navigator.of(context).pop();
                                      //Navigator.popAndPushNamed(context, Routes.Addparty(key: null,title:"Add Customer"));
                                    },
                                    leading: Image.asset('images/uom.png'),
                                    title: Text("Rapid Test"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      //Navigator.of(context).pop();
                                      //Navigator.popAndPushNamed(context, Routes.Addparty(key: null,title:"Add Customer"));
                                    },
                                    leading: Image.asset('images/additem.png'),
                                    title: Text("Item"),
                                  ),
                                  ListTile(),
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
                                ListTile(
                                  onTap: () {
                                    //Navigator.of(context).pop();
                                    //Navigator.popAndPushNamed(context, Routes.Addparty(key: null,title:"Add Customer"));
                                  },
                                  leading: Image.asset(
                                    'images/pricelist.png',
                                  ),
                                  title: Text("Price List"),
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
                                  leading: Image.asset(
                                    'images/pricelist.png',
                                  ),
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
