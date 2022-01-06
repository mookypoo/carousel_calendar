import 'dart:io';

import 'package:flutter/material.dart';
import 'package:portfolio/controllers/calendarCt.dart';
import 'package:provider/provider.dart';

import 'androidCalendar.dart';
import 'iosCalendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CalendarCt _calendarCt = Provider.of<CalendarCt>(context);

    return Platform.isAndroid
      ? AndroidCalendar(calendarCt: _calendarCt)
      : IosCalendar();
  }
}
