import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'package:dancer/widgets/display_star.dart';
import 'download_photo_wrapper.dart';
import 'package:dancer/graphql/models/user.dart';
import 'package:url_launcher/url_launcher.dart' as URL;
import 'package:intl/intl.dart';

class TeacherProfile extends StatefulWidget {
  final User teacher;

  TeacherProfile({this.teacher});

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  @override
  void initState() {
    super.initState();
  }

  void _launchURL(String url) async {
    print("opening $url ...");
    if (await URL.canLaunch(url)) {
      await URL.launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final teacherAvatar = GestureDetector(
      onTap: () {
        Navigator.push(context, FadeRoute(page: DownloadPhotoWrapper(idx: "")));
      },
      child: Container(
        height: 122,
        width: 122,
        child: CircleAvatar(
          radius: 58,
          backgroundColor: Color(0xffBF8A2A),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(55),
            child: widget.teacher.getProfileImage(
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xffDFC494), Color(0xffBF8A2A)]),
          borderRadius: BorderRadius.circular(61),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      ),
    );

    final socialMediaWidgets = <Widget>[];

    if (widget.teacher.linkInstagram != null && widget.teacher.linkInstagram.isNotEmpty) {
      final instagramIcon = Container(
        height: 50,
        width: 50,
        child: InkWell(
          onTap: () {
            _launchURL(widget.teacher.linkInstagram);
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: ClipRRect(
              child: Image.asset(
                'assets/icons/instagram_icon(50_50).png',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffBF8A2A)),
          borderRadius: BorderRadius.circular(25.0),
        ),
      );

      socialMediaWidgets.add(instagramIcon);
      socialMediaWidgets.add(SizedBox(width: 20));
    }

    if (widget.teacher.linkTiktok != null && widget.teacher.linkTiktok.isNotEmpty) {
      final tiktokIcon = Container(
        height: 50,
        width: 50,
        child: InkWell(
          onTap: () {
            _launchURL(widget.teacher.linkTiktok);
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Icon(
                Icons.music_note,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffBF8A2A),
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
      );

      socialMediaWidgets.add(tiktokIcon);
      socialMediaWidgets.add(SizedBox(width: 20));
    }

    if (widget.teacher.linkFacebook != null && widget.teacher.linkFacebook.isNotEmpty) {
      final facebookIcon = Container(
        height: 50,
        width: 50,
        child: InkWell(
          onTap: () {
            _launchURL(widget.teacher.linkFacebook);
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: ClipRRect(
              child: Image.asset(
                'assets/icons/facebook(50_50).png',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffBF8A2A)),
          borderRadius: BorderRadius.circular(25.0),
        ),
      );

      socialMediaWidgets.add(facebookIcon);
      socialMediaWidgets.add(SizedBox(width: 20));
    }

    final teacherName = Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                //'Kristina Zaric',
                widget.teacher.name(),
                style: TextStyle(
                  fontSize: 27,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              children: socialMediaWidgets,
            ),
          ],
        ),
      ),
    );

    final teacherHeader = Container(
      padding: EdgeInsets.fromLTRB(30, 20, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          teacherAvatar,
          teacherName,
        ],
      ),
    );

    final teacherAbout = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'About Teacher',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Color(0xffBF8A2A)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    widget.teacher.about ?? "N/A",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

    final teacherCountry = Container(
      padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    'Country',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Color(0xffBF8A2A)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.teacher.country ?? "N/A",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final scheduleWidgets = <Widget> [];

    for (var event in widget.teacher.events) {
      final startTime = DateFormat("EEEEE, d MMMM, HH:mm").format(event.startsAt);
      final endTime = DateFormat("HH:mm").format(event.endsAt);
      scheduleWidgets.add(Text(
        '$startTime - $endTime',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ));
    }

    final teacherSchedule = Container(
      padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Class schedule:',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Color(0xffBF8A2A)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                /*Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Icon(Icons.event, size: 50, color: Colors.black,
                  ),
                ),*/
                Padding(
                  //padding: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.only(left: 0),
                  child: Column(
                    children: scheduleWidgets,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final teacherRanking = Container(
      padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Padding(
              //padding: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(bottom: 0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Ranking:',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Color(0xffBF8A2A),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(size: 35),
                  child: StarDisplay(teacher: widget.teacher),
                ),
                /*Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Class #1',
                    style: TextStyle(fontSize: 16, color: Color(0xffBF8A2A), fontStyle: FontStyle.italic),
                  ),
                ),*/
              ],
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(size: 35),
                  child: StarDisplay(value: 5),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Class #2',
                    style: TextStyle(fontSize: 16, color: Color(0xffBF8A2A), fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),*/
          ],
        ),
      ),
    );

    return Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              teacherHeader,
              teacherAbout,
              teacherCountry,
              teacherSchedule,
              teacherRanking,
              SizedBox(height: 60),
            ],
          ),
        ],
      ),
    );
  }
}
