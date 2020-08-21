import 'package:flutter/material.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'download_photo_wrapper.dart';
import 'schedule_class_wrapper.dart';
import 'schedule_event_wrapper.dart';
import 'package:dancer/graphql/models/event.dart';
import 'package:dancer/graphql/private.dart' as gql;
import 'package:loader/src/loadingMixin.dart';
import 'package:loader/src/loadingStatelessWidget.dart';
import 'package:intl/intl.dart';

class ScheduleEvent extends StatefulWidget {
  @override
  _ScheduleEventState createState() => _ScheduleEventState();
}

class _ScheduleEventState extends State<ScheduleEvent> with LoadingMixin<ScheduleEvent> {
  List<Event> events;
  String selectedDay;
  List<bool> isSelected;

  @override
  void initState() {
    isSelected = [false, true];
    selectedDay = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][DateTime.now().weekday - 1];
    super.initState();
  }
  
  Widget createDateIcon(String name, int day_of_month) {
    String color = name == selectedDay ? "yellow" : "black";
    return Padding(
      padding: EdgeInsets.only(right: 5),
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
    );
  }

  Widget dayNameSeparator(String name) {
    return Container(
      color: Color(0xffDFC494),
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      height: 60,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  Widget scheduleEventHeader(String fromHour, String toHour, String name, String location) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(fromHour, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(toHour, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(width: 2, height: 25, color: Color(0xffDFC494)),
          ),
          Expanded(
            flex: 6,
            child: Text('$name ($location)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget scheduleEventDesc(String desc) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: SizedBox(width: 20),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(width: 2, height: 25, color: Colors.white),
          ),
          Expanded(
            flex: 6,
            child: Text(desc, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
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
                  Navigator.push(
                      context, FadeRoute(page: ScheduleClassWrapper()));
                }
              },
              isSelected: isSelected,
            ),
          ]),
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
      //dayNameSeparator("SUNDAY"),
      //scheduleEventHeader("20:00", "23:00", "MOVIE NIGHT", "Small Hall"),
      //scheduleEventDesc('About the event: Chill out. Eat some popcom. Enjoy the night with friends watching a dance flick.'),
      //dayNameSeparator("MONDAY"),
      //scheduleEventHeader("20:00", "23:00", "SHOWCASE PRESELECTION", "Arena"),
    ];

    if (loading) {
      widgets.add(Center(child: Text("loading")));
    } else if (hasError) {
      widgets.add(Center(child: Text("error loading")));
      print("error loading: $error");
    } else {
      String lastDayName = "";
      for (var event in events) {
        if (event.type != "event") {
          continue;
        }

        final currentDayName = DateFormat('EEEE').format(event.startsAt);
        print("current day name: $currentDayName");
        final fromHour = "${event.startsAt.hour.toString().padLeft(2, '0')}:${event.startsAt.minute.toString().padLeft(2, '0')}";
        final toHour = "${event.endsAt.hour.toString().padLeft(2, '0')}:${event.endsAt.minute.toString().padLeft(2, '0')}";
        if (lastDayName != currentDayName) {
          widgets.add(dayNameSeparator(currentDayName));
          lastDayName = currentDayName;
        }
        widgets.add(scheduleEventHeader(fromHour, toHour, event.name, event.location.name));
        if (event.description != null && event.description.isNotEmpty) {
          widgets.add(scheduleEventDesc(event.description));
        }
      }

      widgets.add(SizedBox(height: 30));
    }

    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          toggleButtons(),
          //dateIcons(),
          SizedBox(width: 10),
        ] + widgets,
      ),
    );
  }
}
