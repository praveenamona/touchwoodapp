import 'package:touchwoodapp/widgets/Collapsing_navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:touchwoodapp/widgets/collapsing_list_tile_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Navigation Drawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: CustomDrawer(),
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

    return CollapsingNavigationDrawer();
  }
}
