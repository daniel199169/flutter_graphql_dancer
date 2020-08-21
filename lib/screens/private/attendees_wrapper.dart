import 'package:dancer/screens/private/home_screen.dart';
import 'package:dancer/screens/private/ranking.dart';
import 'package:dancer/widgets/dancer_bottom_navigation.dart';
import 'package:dancer/screens/private/dancer_profile.dart';
import 'message.dart';
import 'package:flutter/material.dart';
import 'attendees.dart';
import 'notification.dart';

class AttendeesWrapper extends StatefulWidget {
  @override
  _AttendeesWrapperState createState() => _AttendeesWrapperState();
}

class _AttendeesWrapperState extends State<AttendeesWrapper> {
  List<Widget> attendeeWidgets = List<Widget>();

  int _curreentIndex;
  bool flag = false;
  int label = 0;
  bool isFreshOne = false;

  @override
  void initState() {
    _curreentIndex = 5;

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
        return Profile();
        break;
      case 3:
        return NotifiAlarm();
        break;
      case 4:
        return Message();
        break;

      default:
        return Attendees();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendees'),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 25),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
      body: _resolveBody(_curreentIndex),
      bottomNavigationBar: DancerBottomNavigation(resolveBodyIndex),
    );
  }
}
