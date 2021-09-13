import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> events) {
    this.appointments = events;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).functionDate;

  @override
  DateTime getEndTime(int index) => getEvent(index).functionDate;

  @override
  String getSubject(int index) => getEvent(index).name;

  @override
  Color getColor(int index) => getEvent(index).color;
}
