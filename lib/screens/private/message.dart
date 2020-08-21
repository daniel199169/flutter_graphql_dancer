import 'package:dancer/screens/private/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'message_guardian_wrapper.dart';
import 'message_lost_wrapper.dart';
import 'message_mykid_wrapper.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffEBEBEB),
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
              color: Color(0xffDFC494),
              child: Row(
                children: <Widget>[
                  Text('Guardian',
                      style: Theme.of(context).textTheme.headline2),
                  SizedBox(width: 10),
                  Icon(
                    Icons.whatshot,
                    size: 30,
                  ),
                  Expanded(
                    child: SizedBox(width: 15),
                    flex: 4,
                  ),
                  /*Icon(
                    Icons.expand_less,
                    size: 40,
                  ),*/
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, FadeRoute(page: MessageLostWrapper()));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Lost & Found',
                      style: Theme.of(context).textTheme.headline2),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, FadeRoute(page: MessageGuardianWrapper()));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Guardian',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, FadeRoute(page: MessageMyKidsWrapper()));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('My Kids', style: Theme.of(context).textTheme.headline2),
                  // Expanded(
                  //   child: SizedBox(width: 10),
                  //   flex: 2,
                  // ),
                  // Icon(
                  //   Icons.check,
                  //   size: 30,
                  // ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
