import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DancerDatepickerService extends StatefulWidget {
  final Function onClose;
  final Function onSet;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTime initDate;
  DancerDatepickerService(
      {this.onClose, this.onSet, this.minDate, this.maxDate, this.initDate});
  @override
  _DancerDatepickerServiceState createState() => _DancerDatepickerServiceState();
}

class _DancerDatepickerServiceState extends State<DancerDatepickerService> {
  DateTime selectedDateTime;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border.symmetric(
                horizontal: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 2,
            )),
          ),
          height: MediaQuery.of(context).size.height / 4,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: widget.initDate,
            minimumDate: widget.minDate,
            maximumDate: widget.maxDate,
            backgroundColor: Colors.grey[300],
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                selectedDateTime = newDateTime;
              });
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.18,
          left: MediaQuery.of(context).size.width * 0.66,
          child: FloatingActionButton(
            mini: true,
            foregroundColor: Colors.white,
            onPressed: () {
              widget.onSet(selectedDateTime);
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.check),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.18,
          child: FloatingActionButton(
            mini: true,
            foregroundColor: Colors.white,
            onPressed: () {
              widget.onClose(selectedDateTime);
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.close),
          ),
        )
      ],
    );
  }
}