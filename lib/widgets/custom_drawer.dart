import 'package:flutter/material.dart';
import 'package:touchwoodapp/screens/Customer.dart' as dashboard;
import 'package:touchwoodapp/screens/relative.dart' as relative;
import 'package:touchwoodapp/Widgets/custom_expansion_tile.dart' as custom;
import 'package:touchwoodapp/Widgets/sidebar.dart' as sidebar;

void main() {
  runApp(MyApp());
}

StatelessWidget swidget;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static const BASE_URL = "http://api.suninfotechnologies.in/";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String routeName = '/custom_drawer';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            //  child: Image.asset('Images/menu.png'),
            onPressed: () {
              setState(() {});
            }),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, //Colors.black.withAlpha(100),
      child: Center(
        child: Text(
          //
          "",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;
  final StatelessWidget s1;

  const CustomDrawer({Key key, this.closeDrawer, this.s1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
        color: Colors.blue[200],
        width: 250, //mediaQuery.size.width * 0.40,
        height: mediaQuery.size.height,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Sun Info Technologies"),
                accountEmail: Text("www.suninfotechnologies.in"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    "S",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              custom.ExpansionTile(
                  title: ListTile(
                    onTap: () {
                      //  mastertapped = (mastertapped) ? false : true;
                    },
                    //  leading: Icon(Icons.settings_applications),
                    title: Text("Master"),
                  ),
                  iconColor: Colors.white,
                  children: <Widget>[
                    ListTile(
                      onTap: () {},
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
                                builder: (context) => relative.Example()));
                      },
                      leading: Image.asset(
                        'images/group.png',
                      ),
                      title: Text("Group"),
                    ),
                    ListTile(
                      onTap: () {
                        //Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sidebar.SidebarPage()));
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
                color: Colors.black,
              ),
              custom.ExpansionTile(
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
                color: Colors.black,
              ),
              custom.ExpansionTile(
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
                color: Colors.black,
              ),
              // ListTile(
              //   onTap: () {
              //     debugPrint("User Management");
              //   },
              //   leading: Icon(Icons.supervised_user_circle),
              //   title: Text("User Management"),
              // ),
              // Divider(
              //   height: 1,
              //   color: Colors.black,
              // ),
              // // ListTile(
              //   onTap: () {
              //     debugPrint("Tapped Notifications");
              //   },
              //   leading: Icon(Icons.settings_applications),
              //   title: Text("Utilities"),
              // ),
              // Divider(
              //   height: 1,
              //   color: Colors.black,
              // ),
              // ExpansionTile(
              //   title: ListTile(
              //     onTap: () {
              //       debugPrint("Tapped settings");
              //     },
              //     leading: Icon(Icons.settings),
              //     title: Text("Reports"),
              //   ),
              //   children: [
              //     ListTile(
              //       onTap: () {
              //         //Navigator.of(context).pop();
              //         //Navigator.popAndPushNamed(context, Routes.Addparty(key: null,title:"Add Customer"));
              //         // Navigator.push(
              //         //     context,
              //         //     MaterialPageRoute(
              //         //         builder: (context) =>
              //         //             PriceListReport.AddPricelistPage()));
              //       },
              //       leading: Icon(Icons.account_balance),
              //       title: Text("Price List Report"),
              //     ),
              //   ],
              // ),
              // Divider(
              //   height: 1,
              //   color: Colors.black,
              // ),
              // ListTile(
              //   onTap: () {
              //     debugPrint("Tapped Log Out");
              //   },
              //   leading: Icon(Icons.exit_to_app),
              //   title: Text("Log Out"),
              // ),
            ],
          ),
        ));
  }
}
