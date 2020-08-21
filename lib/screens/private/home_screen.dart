import 'package:dancer/screens/private/message_wrapper.dart';
import 'package:dancer/screens/public/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'attendees_wrapper.dart';
import 'check_in_wrapper.dart';
import 'emergency_contacts_wrapper.dart';
import 'gallery_wrapper.dart';
import 'message_wrapper.dart';
import 'ranking_wrapper.dart';
import 'teachers_wrapper.dart';
import 'venue_wrapper.dart';
import 'schedule_class_wrapper.dart';
import 'package:dancer/globals.dart';
import 'package:dancer/screens/private/dancer_profile.dart';
import 'package:dancer/graphql/models/user.dart';

class HomeScreen extends StatefulWidget {
  User user;

  HomeScreen({this.user}) {
    if (user == null) {
      user = USER;
    }
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildListItem(String text, IconData icon, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, FadeRoute(page: nextPage));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 15, 40, 15),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 26),
            SizedBox(width: 15),
            Expanded(
              flex: 4,
              child: Text(
                text,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 26),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editProfileAction = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Edit profile',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.left,
        ),
        Container(
          height: 32,
          width: 32,
          margin: EdgeInsets.only(top:5),
          child: InkWell(
            onTap: () {
              Navigator.push(context, FadeRoute(page: Profile(user: widget.user, editMode: true,)));
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Icon(Icons.edit, color: Color(0xffDFC494), size: 20),
              ),
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffDFC494)),
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ],
    );

    final logoutAction = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sign out',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.left,
        ),
        Container(
          height: 32,
          width: 32,
          margin: EdgeInsets.only(top:5),
          child: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()), (Route<dynamic> route) => route is RegisterScreen
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Icon(Icons.power_settings_new, color: Color(0xffDFC494), size: 30),
              ),
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffDFC494)),
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ],
    );

    final headerActionButtons = Row(
      children: <Widget>[
        editProfileAction,
        SizedBox(width: 20),
        logoutAction,
      ],
    );

    final header = Container(
      padding: EdgeInsets.fromLTRB(30, 0, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, right: 20),
            child: ClipOval(
              child: Container(
                child: widget.user.getProfileImage(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.user.name(),
                  style: TextStyle(fontSize: 26, color: Colors.black87, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                headerActionButtons,
              ],
            ),
          )
        ],
      ),
    );

    final separator = Container(height: 2, color: Color(0xffDFC494));

    final gallery = buildListItem("Gallery", Icons.camera_alt, GalleryWrapper());
    final schedule = buildListItem("Schedule", Icons.date_range, ScheduleClassWrapper());
    final attendees = buildListItem("Attendees", Icons.people, AttendeesWrapper());
    final teachers = buildListItem("Teachers", Icons.school, TeachersWrapper());
    final messages = buildListItem("Messages", Icons.send, MessageWrapper());
    final rankings = buildListItem("Rankings", Icons.star, RankingWrapper());
    final venues = buildListItem("Venues", Icons.location_on, VenueWrapper());
    final checkIn = buildListItem("Check in", Icons.directions_run, CheckInWrapper());
    final emergencyContacts = buildListItem("Emergency contacts", Icons.phone, EmergencyContactWrapper());

    final children = <Widget> [
      header,
      separator,
      schedule,
      separator,
      teachers,
      separator,
      attendees,
      separator,
      messages,
      separator,
      rankings,
      separator,
      venues,
      separator,
      gallery,
      separator,
      checkIn,
      separator,
      emergencyContacts,
    ];

    return Container(
      color: Colors.white,
      child: new ListView(
        children: children,
      ),
    );
  }
}
