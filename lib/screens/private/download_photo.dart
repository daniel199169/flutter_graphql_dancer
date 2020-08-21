import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'teachers_profile_wrapper.dart';


class DownloadPhoto extends StatefulWidget {
  final String index;
  DownloadPhoto({this.index});
  @override
  _DownloadPhotoState createState() => _DownloadPhotoState();
}

class _DownloadPhotoState extends State<DownloadPhoto> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        child: Image.asset(
          'assets/images/profile.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
        child: Column(
          children: <Widget>[
            MaterialButton(
              onPressed: () => {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Text(
                      'Download photo',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              color: Color(0xffEBEBEB),
              padding: EdgeInsets.all(0),
              elevation: 3,
              height: 50,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(
                  width: 0.5,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                  Navigator.pop(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              color: Color(0xffEBEBEB),
              padding: EdgeInsets.all(0),
              elevation: 3,
              height: 50,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(
                  width: 0.5,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
