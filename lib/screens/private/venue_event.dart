import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'check_in_breakfast_wrapper.dart';
import 'download_photo_wrapper.dart';
import 'check_in_qrscan_wrapper.dart';
import 'package:loader/loader.dart';
import 'package:dancer/graphql/models/location.dart';
import 'package:dancer/graphql/private.dart' as gql;
import 'package:dancer/utils.dart';
import 'package:toast/toast.dart';

class VenueEvent extends StatefulWidget {
  @override
  _VenueEventState createState() => _VenueEventState();
}

class _VenueEventState extends State<VenueEvent> with LoadingMixin<VenueEvent> {
  List<Location> locations = List<Location>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> load() async {
    final r = await gql.Private.locations();
    if (r.hasException) {
      print("venue_event: error fetching: ${r.exception.graphqlErrors[0].message}");
      throw Exception(r.exception);
    }
    locations = List<Location>.from(r.data["locations"]["data"].map((i) => Location.fromJson(i)));
    return Future.delayed(Duration(seconds: 0));
  }

  Widget addRow(Location venue) {
    return InkWell(
      onTap: () {
        try {
          final lat = double.parse(venue.geoLat);
          final lng = double.parse(venue.geoLng);
          MapUtils.openMap(lat, lng);
        } catch (Exception) {
          Toast.show("Error opening maps", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  venue.name.toUpperCase(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Located at ${venue.address}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.schedule, size: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Event time: ${venue.openingHours ?? "N/A"}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
            Text('Events', style: Theme.of(context).textTheme.headline2),
            SizedBox(width: 10),
            Icon(Icons.whatshot, size: 30,),
            Expanded(child: SizedBox(width: 15), flex: 4,),
            Icon(Icons.expand_more, size: 40,),
          ],
        ),
      ),
    );

    final image = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/icons/google_map.jpg'),
        ),
      ),
    );

    final separator = Container(height: 15, color: Color(0xffDFC494),);

    final children = <Widget>[
      header,
      image,
    ];

    if (loading) {
      children.add(Center(child: Text("Loading...")));
    } else if (hasError) {
      print("venue_event: error loading venues: $error");
      children.add(Center(child: Text("Error loading data")));
    } else {
      for (var location in locations) {
        if (location.category == "events") {
          children.add(addRow(location));
          children.add(separator);
        }
      }
    }

    children.add(Container(height: 50, color: Colors.white));

    return Container(
      color: Color(0xffEBEBEB),
      child: ListView(
        children: children,
      ),
    );
  }
}
