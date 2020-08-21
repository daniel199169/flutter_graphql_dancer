import 'package:dancer/graphql/models/user.dart';
import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'teachers_profile_wrapper.dart';
import 'package:dancer/graphql/private.dart' as gql;
import 'package:loader/loader.dart';

class Teachers extends StatefulWidget {
  @override
  _TeachersState createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> with LoadingMixin<Teachers> {
  List<User> teachers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> load() async {
    final r = await gql.Private.teachers();
    if (r.hasException) {
      print("teachers: error fetching: ${r.exception}");
      throw Exception(r.exception);
    }
    teachers = List<User>.from(r.data["teachers"].map((i) => User.fromJson(i)));
    teachers.sort((a, b) => a.lastName.compareTo(b.lastName) );
    return Future.delayed(Duration(seconds: 0));
  }

  Widget addTeacher(User teacher) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, FadeRoute(page: TeachersProfileWrapper(teacher: teacher)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: ClipOval(
                child: teacher.getProfileImage(
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              teacher.name(),
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
          'All teachers',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final widgets = <Widget>[
      header,
    ];

    if (loading) {
      widgets.add(Center(child: Text("Loading...")));
    } else if (hasError) {
      print("teachers: error loading teachers: $error");
      widgets.add(Center(child: Text("Error loading data")));
    } else {
      for (var teacher in teachers) {
        widgets.add(addTeacher(teacher));
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
