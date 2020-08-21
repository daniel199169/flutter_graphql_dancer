import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'package:dancer/widgets/display_star.dart';
import 'package:loader/loader.dart';
import 'package:dancer/graphql/models/user.dart';
import 'package:dancer/graphql/private.dart' as gql;
import 'package:dancer/globals.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> with LoadingMixin<Ranking> {
  List<User> teachers = List<User>();

  @override
  void initState() {
    gql.Private.resetCache();
    super.initState();
  }

  @override
  Future<void> load() async {
    final r = await gql.Private.teachers();
    if (r.hasException) {
      print("ranking: error fetching: ${r.exception}");
      throw Exception(r.exception);
    }
    teachers = List<User>.from(r.data["teachers"].map((i) => User.fromJson(i)));
    teachers.sort((a, b) => b.ranking.compareTo(a.ranking));
    return Future.delayed(Duration(seconds: 0));
  }

  Widget addRow(User teacher, {votable = false}) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 20, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: teacher.getProfileImage(
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              teacher.name(),
              style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(width: 5),
          ),
          StarDisplay(teacher: teacher, votable: votable),
        ],
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
            Text('All ranking', style: Theme.of(context).textTheme.headline2),
            SizedBox(width: 10),
            Icon(Icons.star, size: 30),
            Expanded(child: SizedBox(width: 15), flex: 4),
            //Icon(Icons.expand_more, size: 40),
          ],
        ),
      ),
    );

    final children = <Widget>[
      header,
      Container(height: 1, color: Colors.black),
    ];

    final myVotesText = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 10, 15),
      child: Text(
        'My teachers',
        style: TextStyle(fontSize: 18, color: Color(0xffDFC494)),
      ),
    );

    final top5text = Container(
      padding: EdgeInsets.fromLTRB(30, 15, 10, 15),
      child: Text(
        'Top 5',
        style: TextStyle(fontSize: 18, color: Color(0xffDFC494)),
      ),
    );

    final divider = Container(
      height: 10,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      color: Color(0xffDFC494),
    );

    if (loading) {
      children.add(Center(child: Text("Loading...")));
    } else if (hasError) {
      print("ranking: error loading teachers: $error");
      children.add(Center(child: Text("Error loading data")));
    } else {
      if (USER.isDancer()) {
        final now = DateTime.now();
        bool voteHeaderAdded = false;
        for (var teacher in teachers) {
          if (teacher.myRank != null) {
            continue;
          }
          for (var event in teacher.events) {
            if (now.difference(event.endsAt).inSeconds > 0) {
              if (!voteHeaderAdded) {
                children.add(myVotesText);
                voteHeaderAdded = true;
              }
              children.add(addRow(teacher, votable: true));
            }
          }
        }
        if (voteHeaderAdded) {
          children.add(divider);
        }
      }

      children.add(top5text);
      for (var teacher in teachers.sublist(0, 5)) {
        children.add(addRow(teacher));
      }
      children.add(divider);
      for (var teacher in teachers.sublist(5)) {
        children.add(addRow(teacher));
      }
    }

    return Container(
      color: Colors.white,
      child: ListView(
        children: children,
      ),
    );
  }
}
