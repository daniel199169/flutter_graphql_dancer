import 'package:flutter/material.dart';
import 'package:dancer/screens/private/home_screen.dart';
import 'package:dancer/widgets/dancer_bottom_navigation.dart';
import 'package:dancer/screens/private/dancer_profile.dart';
import 'download_photo.dart';
import 'message.dart';
import 'notification.dart';
import 'ranking.dart';

class DownloadPhotoWrapper extends StatefulWidget {
  DownloadPhotoWrapper({this.idx});
  final String idx;
  @override
  _DownloadPhotoWrapperState createState() => _DownloadPhotoWrapperState();
}

class _DownloadPhotoWrapperState extends State<DownloadPhotoWrapper> {
  int _curreentIndex;
  bool flag = false;
  int label = 0;
  bool isFreshOne = false;

  @override
  void initState() {
    print("-----=================");
    print(widget.idx);
    super.initState();
  }

  void _changeFlag(bool f) {
    setState(() {
      flag = f;
      isFreshOne = !isFreshOne;
    });
  }

  Widget _resolveBody(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return Ranking();
        break;
      case 2:
        return Profile();
        break;
      case 3:
        return NotifiAlarm();
        break;
      case 4:
        return Message();
        break;

      default:
        return DownloadPhoto(index: widget.idx);
    }
  }

  void resolveBodyIndex(int index) {
    setState(() {
      _curreentIndex = index;
      flag = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 25),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
      body: _resolveBody(_curreentIndex),
      bottomNavigationBar: DancerBottomNavigation(resolveBodyIndex),
    );
  }
}
