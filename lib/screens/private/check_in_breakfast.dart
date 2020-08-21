import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'download_photo_wrapper.dart';

class CheckInBreakfast extends StatefulWidget {
  @override
  _CheckInBreakfastState createState() => _CheckInBreakfastState();
}

class _CheckInBreakfastState extends State<CheckInBreakfast> {
  List<Widget> attendeeWidgets = List<Widget>();
  List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
    getAttendees();
  }

  getAttendees() {
    for (int i = 0; i < 15; i++) {
      attendeeWidgets.add(Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.png',
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'Anja Major',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ]),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
                color: Color(0xffDFC494),
                child: Row(
                  children: <Widget>[
                    Text('Breakfast',
                        style: Theme.of(context).textTheme.headline2),
                    SizedBox(width: 10),
                    Icon(
                      Icons.restaurant_menu,
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
            ] +
            [
              Container(
                color: Colors.black,
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ToggleButtons(
                        borderColor: Colors.white,
                        fillColor: Colors.white,
                        borderWidth: 1,
                        selectedBorderColor: Colors.white,
                        selectedColor: Colors.black,
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 46.0, right: 46.0),
                            child: Text(
                              'Checked',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40.0, right: 40.0),
                            child: Text(
                              'Unchecked',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < isSelected.length; i++) {
                              isSelected[i] = i == index;
                            }
                          });
                        },
                        isSelected: isSelected,
                      ),
                    ]),
              )
            ] +
            attendeeWidgets,
      ),
    );
  }
}
