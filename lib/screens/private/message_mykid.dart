import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'message_mykidnewmessage_wrapper.dart';

class MessageMyKids extends StatefulWidget {
  @override
  _MessageMyKidsState createState() => _MessageMyKidsState();
}

class _MessageMyKidsState extends State<MessageMyKids> {
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
                  Text('My kids', style: Theme.of(context).textTheme.headline2),
                  SizedBox(width: 10),
                  Icon(
                    Icons.wc,
                    size: 30,
                  ),
                  Expanded(
                    child: SizedBox(width: 15),
                    flex: 4,
                  ),
                  Icon(
                    Icons.expand_less,
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
              'Vsi takoj v jedilnico!',
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
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.2,
                    15,
                    MediaQuery.of(context).size.width * 0.2,
                    15),
                child: MaterialButton(
                  onPressed: () => {
                    Navigator.push(context,
                        FadeRoute(page: MessageMyKidsNewMessageWrapper())),
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                          'Write new',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  color: Color(0xffEBEBEB),
                  padding: EdgeInsets.all(0),
                  elevation: 3,
                  height: 40,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
