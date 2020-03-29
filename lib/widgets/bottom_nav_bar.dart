import 'package:flutter/material.dart';
import '../translation.i18n.dart';

class MyBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  MyBottomNavBar({@required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('List'.i18n),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          title: Text('Calculator'.i18n),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Setting'.i18n),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.green,
      onTap: (index) {
        if (index == selectedIndex) {
          return;
        }
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/calculator');
            break;
          case 2:
            Navigator.pushNamed(context, '/settings');
            break;
          default:
        }
      },
    );
  }
}
