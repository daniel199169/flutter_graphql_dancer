import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'check_in_breakfast_wrapper.dart';
import 'download_photo.dart';
import 'check_in_qrscan_wrapper.dart';
import 'package:dancer/globals.dart';

class CheckIn extends StatefulWidget {
  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final header = GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
        color: Color(0xffDFC494),
        child: Row(
          children: <Widget>[
            Text('Check in',
                style: Theme.of(context).textTheme.headline2),
            SizedBox(width: 10),
            Icon(Icons.directions_run, size: 30,),
            Expanded(
              child: SizedBox(width: 15),
              flex: 4,
            ),
            Icon(Icons.expand_less, size: 40,),
          ],
        ),
      ),
    );

    final separator = Container(
      height: 1,
      color: Colors.black,
    );

    final scanWidget = GestureDetector(
      onTap: () {
        Navigator.push(context, FadeRoute(page: CheckInQRScanWrapper()));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Scan', style: Theme.of(context).textTheme.headline2),
            SizedBox(width: 10),
          ],
        ),
      ),
    );

    final mealsCheckList = GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(width: 10),
              flex: 3,
            ),
            Text(
              'Meals check list',
              style: Theme.of(context).textTheme.headline2),
            Expanded(
              child: SizedBox(width: 10),
              flex: 2,
            ),
            Icon(
              Icons.check,
              size: 30,
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );

    final mealsBreakfast = GestureDetector(
      onTap: () {
        Navigator.push(
            context, FadeRoute(page: CheckInBreakfastWrapper()));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Breakfast',
              style: TextStyle(
                color: Color(0xffDFC494),
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );

    final mealsLunch = GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lunch',
              style: TextStyle(
                color: Color(0xffDFC494),
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );

    final mealsDinner = GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Dinner',
              style: TextStyle(
                color: Color(0xffDFC494),
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );

    final eventsCheckList = GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Events check list',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );

    final children = <Widget>[
      header,
      separator,
      scanWidget,
      separator,
    ];

    if (USER.isGuardian()) {
      children.addAll([
        mealsCheckList,
        separator,
        mealsBreakfast,
        separator,
        mealsLunch,
        separator,
        mealsDinner,
        separator,
        eventsCheckList,
        separator,
      ]);
    }

    return Container(
      color: Color(0xffEBEBEB),
      child: ListView(
        children: children,
      ),
    );
  }
}
