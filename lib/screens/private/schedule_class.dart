import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'download_photo.dart';
import 'schedule_event_wrapper.dart';
import 'schedule_class_wrapper.dart';
import 'package:dancer/graphql/models/event.dart';
import 'package:dancer/graphql/private.dart' as gql;
import 'package:loader/src/loadingMixin.dart';
import 'package:loader/src/loadingStatelessWidget.dart';

class ScheduleClass extends StatefulWidget {
  @override
  _ScheduleClassState createState() => _ScheduleClassState();
}

class _ScheduleClassState extends State<ScheduleClass> with LoadingMixin<ScheduleClass> {
  List<Event> events;
  List<bool> isSelected;
  String selectedDayName;
  int selectedDay;

  @override
  void initState() {
    isSelected = [true, false];
    selectedDayName = "Sat";
    selectedDayName = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][DateTime.now().weekday - 1];
    selectedDay = 22;
    super.initState();
  }

  Widget createDateIcon(String name, int day_of_month) {
    //print("name: $name, selectedDay: $selectedDay");
    String color = name == selectedDayName ? "yellow" : "black";
    return Padding(
      padding: EdgeInsets.only(right: 5),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedDayName = name;
            selectedDay = day_of_month;
          });
        },
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(name, style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
          Stack(
            children: <Widget>[
              Image.asset(
                'assets/icons/week_icon_$color.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.only(top: 12, left: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(day_of_month.toString(), style: TextStyle(color: Colors.black, fontSize: 18)),
                 ),
                ),
             ],
           ),
          ],
        ),
      ),
    );
  }

  Widget timeSeparator(String hour) {
    return Container(
      color: Color(0xffDFC494),
      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
      height: 30,
      child: Text(
        hour,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget scheduleClass(String fromHour, String toHour, String teacherName, String eventName) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  fromHour,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  toHour,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 2,
            height: 25,
            color: Color(0xffDFC494),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '${teacherName.toUpperCase()} (${eventName})',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recurringEvent(String name) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
      height: 60,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          name.toUpperCase(),
          style: TextStyle(
            fontSize: 27,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget dateIcons() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          createDateIcon("Sat", 22),
          createDateIcon("Sun", 23),
          createDateIcon("Mon", 24),
          createDateIcon("Tue", 25),
          createDateIcon("Wed", 26),
          createDateIcon("Thu", 27),
        ],
      ),
    );
  }

  Widget toggleButtons() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ToggleButtons(
            borderColor: Colors.white,
            fillColor: Colors.white,
            borderWidth: 1,
            selectedBorderColor: Colors.white,
            selectedColor: Colors.black,
            borderRadius: BorderRadius.circular(0),
            color: Colors.white,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 61.0, right: 61.0),
                child: Text(
                  'Class',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60.0, right: 60.0),
                child: Text(
                  'Events',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
              });
              if (isSelected[index] == true) {
                Navigator.push(context, FadeRoute(page: ScheduleEventWrapper()));
              }
            },
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }

  @override
  Future<void> load() async {
    final r = await gql.Private.events();
    if (r.hasException) {
      throw Exception(r.exception);
    }
    events = List<Event>.from(r.data["events"]["data"].map((i) => Event.fromJson(i)));
    events.sort((a, b) => a.startsAt.compareTo(b.startsAt));
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      /*timeSeparator("09:00"),
      scheduleClass("09:00", "10:15", "VANESA MAJERIC", "Urban Choreography"),
      timeSeparator("10:30"),
      scheduleClass("10:30", "11:45", "VANESA MAJERIC", "Urban Choreography"),
      timeSeparator("12:00"),
      scheduleClass("12:00", "13:15", "VANESA MAJERIC", "Urban Choreography"),
      timeSeparator("13:30"),
      recurringEvent("LUNCH"),
      timeSeparator("15:30"),
      scheduleClass("15:30", "16:45", "VANESA MAJERIC", "Urban Choreography"),
      timeSeparator("17:00"),
      scheduleClass("17:00", "18:30", "VANESA MAJERIC", "Urban Choreography"),*/
    ];

    if (loading) {
      widgets.add(Center(child: Text("loading")));
    } else if (hasError) {
      widgets.add(Center(child: Text("error loading")));
      print("error loading: $error");
    } else {
      for (var event in events) {
        final now = DateTime.now();
        //final today = DateTime(now.year, now.month, now.day);
        final today = DateTime(2020, 8, selectedDay);
        final startDate = DateTime(event.startsAt.year, event.startsAt.month, event.startsAt.day);
        if (startDate != today) {
          continue;
        }
        if (event.type != "class") {
          continue;
        }
        final fromHour = "${event.startsAt.hour.toString().padLeft(2, '0')}:${event.startsAt.minute.toString().padLeft(2, '0')}";
        widgets.add(timeSeparator(fromHour));
        if (event.recurring) {
          widgets.add(recurringEvent(event.name));
        } else {
          final teacherName = event.teacher.name();
          final toHour = "${event.endsAt.hour.toString().padLeft(2, '0')}:${event.endsAt.minute.toString().padLeft(2, '0')}";
          widgets.add(scheduleClass(fromHour, toHour, teacherName, event.name));
        }
      }
    }

    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          toggleButtons(),
          dateIcons(),
        ] + widgets
      ),
    );
  }
}
