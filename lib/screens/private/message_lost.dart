import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'download_photo_wrapper.dart';

class MessageLost extends StatefulWidget {
  @override
  _MessageLostState createState() => _MessageLostState();
}

class _MessageLostState extends State<MessageLost> {
  List<Widget> attendeeWidgets = List<Widget>();

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Lost & Found',
                      style: Theme.of(context).textTheme.headline2),
                  SizedBox(width: 10),
                  Icon(
                    Icons.sentiment_satisfied,
                    size: 30,
                  ),
                  Expanded(
                    child: SizedBox(width: 15),
                    flex: 4,
                  ),
                  Icon(
                    Icons.expand_more,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(30, 20, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    child: Image.asset(
                      'assets/images/profile.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Ziva Spevc',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'EDC Team',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontStyle: FontStyle.italic,
                            fontFamily: "Poppins",
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 20,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        '23 Aug 2020',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontFamily: "Poppins",
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        '17:30',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: "Poppins",
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
            color: Colors.white,
            child: Text(
              'V jedilnici se je nasel telefon Apple 11 crne barve. Telefon je na recepciji',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Icon(Icons.favorite_border, size: 24),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '20',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.message, size: 24),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
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
