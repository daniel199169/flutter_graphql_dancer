import 'package:dancer/screens/private/home_screen.dart';
import 'package:dancer/screens/private/dancer_profile.dart';
import 'package:dancer/widgets/dancer_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'message.dart';
import 'notification.dart';
import 'ranking.dart';
import 'package:dancer/globals.dart';
import 'package:dancer/graphql/models/user.dart';

class HomeWrapper extends StatefulWidget {
  User user;
  int currentIndex;

  HomeWrapper({this.user, this.currentIndex = 0}) {
    if (user == null) {
      user = USER;
    }
  }

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _curreentIndex;
  bool flag = false;
  int label = 0;
  bool isFreshOne = false;

  @override
  void initState() {
    _curreentIndex = widget.currentIndex;
    super.initState();
  }

  void _changeFlag(bool f) {
    setState(() {
      flag = f;
      isFreshOne = !isFreshOne;
    });
  }

  Widget _resolveBody(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return Ranking();
        break;
      case 2:
        return Profile(user: widget.user);
        break;
      case 3:
        return NotifiAlarm();
        break;
      case 4:
        return Message();
        break;
      default:
        return HomeScreen();
    }
  }

  void resolveBodyIndex(int index) {
    setState(() {
      _curreentIndex = index;
      flag = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('EMPIRE DANCE CAMP 2020'),
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: Container(),/*Padding(
            padding: EdgeInsets.only(left: 25),
            child: GestureDetector(
              /*onTap: () {
                Navigator.pop(context);
              },*/
              /*child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 40,
              ),*/
            ),
          ),*/
        ),
        body: _resolveBody(_curreentIndex),
        bottomNavigationBar: DancerBottomNavigation(resolveBodyIndex),
      ),
    );
  }
}
