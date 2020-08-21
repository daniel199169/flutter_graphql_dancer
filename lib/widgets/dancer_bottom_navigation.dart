import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DancerBottomNavigation extends StatefulWidget {
  final Function setViewForIndex;
  DancerBottomNavigation(
    this.setViewForIndex,
  );
  @override
  _DancerBottomNavigationState createState() => _DancerBottomNavigationState();
}

class _DancerBottomNavigationState extends State<DancerBottomNavigation> {
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  void _bottomItemTapped(int tappedIndex) {
    setState(() {
      _selectedIndex = tappedIndex;
    });
    widget.setViewForIndex(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        iconSize: 40.0,
        elevation: 20.0,
        onTap: (int index) {
          _bottomItemTapped(index);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note,
              size: 40,
              color: Colors.black87,
            ),
            activeIcon: Icon(
              Icons.event_note,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_half,
              size: 40,
              color: Colors.black87,
            ),
            activeIcon: Icon(
              Icons.star_half,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: ClipOval(
              child: Container(
                child: Icon(Icons.account_circle, size: 40, color: Colors.black),
              ),
            ),
            activeIcon: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.account_circle, size: 40, color: Theme.of(context).primaryColor),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_alert,
              size: 40,
              color: Colors.black87,
            ),
            activeIcon: Icon(
              Icons.add_alert,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 40,
              color: Colors.black87,
            ),
            activeIcon: Icon(
              Icons.chat,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            title: Container(),
          ),
        ],
      ),
    );
  }
}
