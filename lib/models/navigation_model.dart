import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Master", icon: Icons.insert_chart),
  NavigationModel(title: "Transaction", icon: Icons.error),
  NavigationModel(title: "Reports", icon: Icons.search),
];
