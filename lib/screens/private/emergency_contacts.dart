import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'download_photo_wrapper.dart';
import 'package:url_launcher/url_launcher.dart' as URL;
import 'package:dancer/globals.dart' as globals;

class EmergencyContact extends StatefulWidget {
  @override
  _EmergencyContactState createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> buildPhoneRow(String icon, String name, String phone) {
    return <Widget>[
        ClipOval(
          child: Container(
            child: Image.asset(
              icon,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Icon(Icons.phone, size: 24, color: Colors.black),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: RichText(
              text: TextSpan(
                text: phone,
                recognizer: TapGestureRecognizer()..onTap = () => _call(phone),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ];
  }

  void _call(String number) async {
    final url = 'tel://$number';
    if (await URL.canLaunch(url)) {
      await URL.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = Container(
      padding: EdgeInsets.fromLTRB(30, 20, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: ClipOval(
              child: Container(
                child: Image.asset(
                  'assets/images/profile.png',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                //globals.USER.firstName + " " + globals.USER.lastName,
                'Danaja Azman',
                style: TextStyle(fontSize: 27, color: Colors.black87, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
              ),
            ),
          ),
        ],
      ),
    );

    final emergencyWidgets = Container(
      padding: EdgeInsets.fromLTRB(30, 30, 20, 15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              children: <Widget>[
                Text(
                  '24/7 EMERGENCY SUPPORT',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              'In case of injury of attendee or damage to property immediately call the organizer.',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: buildPhoneRow("assets/images/profile.png", "Kristina Zaric", "+386 41 696 775"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: buildPhoneRow("assets/images/profile.png", "Anze Zaric", "+386 41 474 886"),
            ),
          ),
        ],
      ),
    );

    final receptionWidgets = Container(
      padding: EdgeInsets.fromLTRB(30, 30, 20, 15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              children: <Widget>[
                Text(
                  'RECEPTION DESK',
                  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              'For any questions regarding registration, lost & found, events or other service please contact the supporting staff.',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: buildPhoneRow("assets/images/profile.png", "Nina Filipic", "+386 64 126 565"),
          ),
        ],
      ),
    );

    return Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //title,
              //Container(height: 20, color: Color(0xffDFC494)),
              emergencyWidgets,
              Container(height: 20, color: Color(0xffDFC494)),
              receptionWidgets,
              SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
