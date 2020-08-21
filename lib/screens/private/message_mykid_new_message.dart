import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'download_photo.dart';

class MessageMyKidsNewMessage extends StatefulWidget {
  @override
  _MessageMyKidsNewMessageState createState() =>
      _MessageMyKidsNewMessageState();
}

class _MessageMyKidsNewMessageState extends State<MessageMyKidsNewMessage> {
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
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Color(0xffDFC494),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New Message',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: TextFormField(
                                style: TextStyle(
                                  fontFamily: 'Roboto Reqular',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 7, 7, 7),
                            child: Container(
                              height: 35,
                              width: 35,
                              child: CircleAvatar(
                                backgroundColor: Color(0xffDFC494),
                                radius: 17.5,
                                child: ClipRRect(
                                  child: Icon(Icons.arrow_upward, size: 30, color: Colors.black,),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
