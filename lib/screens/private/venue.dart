import 'package:dancer/graphql/models/location.dart';
import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'check_in_breakfast_wrapper.dart';
import 'venue_event_wrapper.dart';
import 'venue_merch_wrapper.dart';


class Venue extends StatefulWidget {
  @override
  _VenueState createState() => _VenueState();
}

class _VenueState extends State<Venue> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final separator = Container(
      height: 1,
      color: Colors.black,
    );

    final header = GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
        color: Color(0xffDFC494),
        child: Row(
          children: <Widget>[
            Text('Events', style: Theme.of(context).textTheme.headline2),
            SizedBox(width: 10),
            Icon(Icons.whatshot, size: 30,),
            Expanded(child: SizedBox(width: 15), flex: 4,),
            Icon(Icons.expand_less, size: 40),
          ],
        ),
      ),
    );

    final merchWidget = GestureDetector(
      onTap: () {
        Navigator.push(context, FadeRoute(page: VenueMerchWrapper()));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Merch & Shop',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );

    final eventsWidget = GestureDetector(
      onTap: () {
        Navigator.push(context, FadeRoute(page: VenueEventWrapper()));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Expanded(child: SizedBox(width: 10), flex: 3,),
            Text(
              'Events',
              style: Theme.of(context).textTheme.headline2,
            ),
            //Expanded(child: SizedBox(width: 10), flex: 2,),
            //Icon(Icons.check, size: 30,),
            //SizedBox(width: 10),
          ],
        ),
      ),
    );

    final poolWidget = GestureDetector(
      onTap: () {
        Navigator.push(context, FadeRoute(page: CheckInBreakfastWrapper()));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pool',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );

    final children = <Widget> [
      header,
      separator,
      merchWidget,
      separator,
      eventsWidget,
      separator,
      poolWidget,
      separator,
    ];

    return Container(
      color: Color(0xffEBEBEB),
      child: ListView(
        children: children,
      ),
    );
  }
}
