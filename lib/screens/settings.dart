import 'package:flutter/material.dart';
import 'package:number_your_days/widgets/bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Settings'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
        ),
        bottomNavigationBar: MyBottomNavBar(
          selectedIndex: 2,
        ));
  }
}
