import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as qweqwe1;
import 'package:async/async.dart' as qweqwe2;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'download_photo_wrapper.dart';
import 'package:dancer/globals.dart';
import 'package:dancer/graphql/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dancer/globals.dart' as globals;
import 'package:dancer/graphql/private.dart' as gql;


class Profile extends StatefulWidget {
  User user;
  final bool editMode;

  Profile({this.user, this.editMode = false}) {
    if (user == null) {
      user = USER;
    }
  }

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _editingController = TextEditingController();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final image = File(pickedFile.path);
    uploadFile(image);
  }

  void uploadFile(File image) async {
    final postUri = Uri.parse(globals.API_URI + "/api/upload");
    final request = http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      "Authorization": "Bearer " + gql.Private.token,
      'Content-Type': 'multipart/form-data',
      "Accept": "application/json",
    });
    final stream = http.ByteStream(qweqwe2.DelegatingStream.typed(image.openRead()));
    final length = await image.length();
    final multipartFile = new http.MultipartFile('file', stream, length, filename: image.path);

    request.files.add(multipartFile);

    request.send().then((response) async {
      if (response.statusCode == 200) {
        final j = jsonDecode(await response.stream.bytesToString());
        final url = j["url"];
        final imageId = j["id"] as int;
        print("body: $j");

        final r = await gql.Private.updateUser(widget.user, imageId: imageId);
        if (r.hasException) {
          print("error updating profile: ${r.exception}");
          return;
        }
        print("profile updated");
      } else {
        print("failed to upload? ${response.statusCode} ${response.reasonPhrase}");
      }
    });
  }

  void _showDialog(String field, {maxLength = 200, multiline = false}) async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(16.0),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                //initialValue: defaultText,
                maxLength: maxLength,
                autofocus: true,
                maxLines: multiline ? 10 : null,
                controller: _editingController,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            }),
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              final text = _editingController.text;
              if (text == null || text.isEmpty) {
                Navigator.pop(context);
                return;
              }
              switch (field) {
                case "about": widget.user.about = text; break;
                case "age": {
                    try {
                      widget.user.age = int.parse(text);
                    } catch (Exception) {
                    }
                  }
                  break;
                case "country": widget.user.country = text; break;
                case "currentSchool": widget.user.currentSchool = text; break;
                case "linkInstagram": widget.user.linkInstagram = text; break;
                case "linkTiktok": widget.user.linkTiktok = text; break;
                case "linkFacebook": widget.user.linkFacebook = text; break;
                case "emergencyContacts": {
                  if (widget.user.contact1 == null || widget.user.contact1.isEmpty) {
                    widget.user.contact1 = text;
                  }
                  else if (widget.user.contact2 == null || widget.user.contact2.isEmpty) {
                    widget.user.contact2 = text;
                  }
                }
                break;
              }
              _editingController.text = "";

              // TODO: mutate user, refetch?
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profilePicture = GestureDetector(
      onTap: () {
        //Navigator.push(context, FadeRoute(page: DownloadPhotoWrapper(idx: "0")));
        print("onTap");
        getImage();
      },
      child: Container(
        height: 122,
        width: 122,
        child: CircleAvatar(
          radius: 58,
          backgroundColor: Color(0xffBF8A2A),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(55),
            child: widget.user.getProfileImage(
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffDFC494), Color(0xffBF8A2A)]
          ),
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

    final socialMediaWidgets = <Widget> [];

    if (widget.editMode || widget.user.linkInstagram != null && widget.user.linkInstagram.isNotEmpty) {
      final instagramIcon = Container(
        height: 50,
        width: 50,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35.0,
          child: ClipRRect(
            child: InkWell(
              onTap: () {
                if (widget.editMode) {
                  _showDialog("linkInstagram");
                }
              },
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
          border: Border.all(
            color: Color(0xffBF8A2A),
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
      );

      socialMediaWidgets.add(instagramIcon);
      socialMediaWidgets.add(SizedBox(width: 20));
    }

    if (widget.editMode || widget.user.linkTiktok != null && widget.user.linkTiktok.isNotEmpty) {
      final tiktokIcon = Container(
        height: 50,
        width: 50,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                if (widget.editMode) {
                  _showDialog("linkTiktok");
                }
              },
              child: Icon(Icons.music_note, color: Colors.black, size: 30),
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

    if (widget.editMode || widget.user.linkFacebook != null && widget.user.linkFacebook.isNotEmpty) {
      final facebookIcon = Container(
        height: 50,
        width: 50,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
          child: ClipRRect(
            child: InkWell(
              onTap: () {
                if (widget.editMode) {
                  _showDialog("linkFacebook");
                }
              },
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
          border: Border.all(
            color: Color(0xffBF8A2A),
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
      );

      socialMediaWidgets.add(facebookIcon);
      socialMediaWidgets.add(SizedBox(width: 20));
    }

    final profileNameAndIcons = Expanded(
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
                widget.user.name(),
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
            )
          ],
        ),
      ),
    );

    final profileHeader = Container(
      padding: EdgeInsets.fromLTRB(30, 20, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          profilePicture,
          profileNameAndIcons,
        ],
      ),
    );

    final profileAbout = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: GestureDetector(
        onTap: () => _showDialog("about", multiline: true, maxLength: 1000),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'About',
                    maxLines: 10,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffBF8A2A),
                    ),
                  ),
                  flex: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  //'Hip Hop dancer from Kranj',
                  widget.user.about ?? "N/A",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final profileAge = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: GestureDetector(
        onTap: () => _showDialog("age"),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Age',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffBF8A2A),
                    ),
                  ),
                  flex: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  //'16',
                  widget.user.age != null ? widget.user.age.toString() : "N/A",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final profileCountry = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: GestureDetector(
        onTap: () => _showDialog("country"),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Country',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffBF8A2A),
                    ),
                  ),
                  flex: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.user.country ?? "N/A",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final profileDanceSchool = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: GestureDetector(
        onTap: () => _showDialog("currentSchool"),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Current dance school',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffBF8A2A),
                    ),
                  ),
                  flex: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  //'Spice Dance Studio',
                  widget.user.currentSchool ?? "N/A",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final profileSchedule = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Today\'s schedule',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffBF8A2A),
                    ),
                  ),
                  flex: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.event,
                  size: 28,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    '4',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final profileTopRankedTeachers = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'My top ranked teachers',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffBF8A2A),
                    ),
                  ),
                  flex: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '5/20',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final profileEmergencyContacts = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: GestureDetector(
        onTap: () {
          if (widget.editMode) {
            _showDialog("emergencyContacts");
          }
        },
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Emergency contacts',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffBF8A2A),
                    ),
                  ),
                  flex: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //Icon(Icons.phone, size: 28, color: Colors.black),
                Text(
                  "N/A", //'24/7 EDC support',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (widget.editMode) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit profile'),
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 25),
            child: GestureDetector(
              onTap: () { Navigator.pop(context); },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  profileHeader,
                  profileAbout,
                  profileAge,
                  profileCountry,
                  profileDanceSchool,
                  //profileSchedule,
                  //profileTopRankedTeachers,
                  profileEmergencyContacts,
                  SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              profileHeader,
              profileAbout,
              profileAge,
              profileCountry,
              profileDanceSchool,
              profileSchedule,
              profileTopRankedTeachers,
              profileEmergencyContacts,
              SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
