import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TimeAndDate extends StatefulWidget {
  @override
  _TimeAndDateState createState() => _TimeAndDateState();
}

class _TimeAndDateState extends State<TimeAndDate> {
  String _timer = "";
  String _date = "";
  @override
  void initState() {
    _initTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: Icon(
          Icons.dashboard,
          color: Theme.of(context).hintColor,
          size: 30,
        ),
        title: Text(
          'Fecha Actual: ${_date.toString()}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline2,
        ),
        subtitle: Text(
          'Hora actual: ${_timer.toString()}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }

  void _initTimer() {
    var _now = DateTime.now();
    _date = formatDate(_now, [dd, '/', mm, '/', yyyy]);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = _now.add(Duration(seconds: 1));
          _timer = DateFormat('HH:mm:ss ').format(_now);
        });
      }
    });
  }
}
