import 'package:dancer/screens/private/home_screen.dart';
import 'package:dancer/screens/private/home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'download_photo_wrapper.dart';
import 'package:dancer/graphql/models/user.dart';
import 'package:dancer/graphql/private.dart' as gql;
import 'package:loader/loader.dart';
import 'package:dancer/screens/private/dancer_profile.dart';

class Attendees extends StatefulWidget {
  @override
  _AttendeesState createState() => _AttendeesState();
}

class _AttendeesState extends State<Attendees> with LoadingMixin<Attendees> {
  List<User> attendees = List<User>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> load() async {
    final r = await gql.Private.attendees();
    if (r.hasException) {
      print("attendees: error fetching: ${r.exception.graphqlErrors[0].message}");
      throw Exception(r.exception);
    }
    attendees = List<User>.from(r.data["users"].map((i) => User.fromJson(i)));
    return Future.delayed(Duration(seconds: 0));
  }

  Widget addAttendee(User attendee) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(context, FadeRoute(page: HomeWrapper(user: attendee, currentIndex: 2,)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: ClipOval(
                child: attendee.getProfileImage(
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              attendee.name(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final header = Container(
      height: 30,
      color: Color(0xffDFC494),
      child: Padding(
        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
        child: Text(
          'All attendees',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final widgets = <Widget> [
      header,
    ];

    if (loading) {
        widgets.add(Center(child: Text("Loading...")));
    } else if (hasError) {
      print("attendees: error loading attendees: $error");
      widgets.add(Center(child: Text("Error loading data")));
    } else {
      for (var user in attendees) {
        widgets.add(addAttendee(user));
      }
    }

    return Container(
      color: Colors.white,
      child: ListView(
        children: widgets,
      ),
    );
  }
}
