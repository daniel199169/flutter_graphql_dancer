import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'download_photo_wrapper.dart';
import 'package:dancer/globals.dart';
import 'package:loader/loader.dart';

class NotifiAlarm extends StatefulWidget {
  @override
  _NotifiAlarmState createState() => _NotifiAlarmState();
}

class _NotifiAlarmState extends State<NotifiAlarm> with LoadingMixin<NotifiAlarm> {
  List<Widget> attendeeWidgets = List<Widget>();

  Widget buildRow(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Container(
              child: Image.asset(
                'assets/images/profile.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            flex: 4,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(icon, size: 28),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> load() async {
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final children = <Widget>[
      buildRow("New message by your Guardian", Icons.send),
      buildRow("Kristina Zaric class in 15 min", Icons.date_range),
      buildRow("New message by your Guardian", Icons.send),
      buildRow("New ranking open", Icons.star),
      buildRow("20 new photos in gallery", Icons.camera_alt),
    ];

    if (loading) {
      children.add(Center(child: Text("Loading...")));
    } else if (hasError) {
      print("notifications: error loading events: $error");
      children.add(Center(child: Text("Error loading data")));
    } else {
      if (USER != null && USER.events != null) {
        final now = DateTime.now();
        for (var event in USER.events) {
          if (event.type == "event") {
            continue;
          }
          if (event.startsAt.difference(now).inMinutes <= 15) {
            children.add(buildRow("${event.teacher.name()} class in 15 mins", Icons.date_range));
          }
        }
      }
    }

    height -= children.length * 100;

    children.add(Container(height: height, color: Colors.white));
    return Container(
      color: Color(0xffEBEBEB),
      child: ListView(
        children: children,
      ),
    );
  }
}
