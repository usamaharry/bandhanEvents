import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

import '../providers/eventProvider.dart';
import '../widgets/eventDataSource.dart';
import '../screens/eventsOnSelectedDate.dart';
import './statefulWraper.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context);

    Future<void> refresh() async {
      await events.loadEvents();
    }

    return StatefulWrapper(
      onInit: () {
        events.loadEvents();
      },
      child: SafeArea(
        child: SfCalendar(
          onTap: (details) {
            Navigator.pushNamed(context, EventOnSelectedDate.routeName,
                arguments: details.date);
          },
          selectionDecoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
          ),
          dataSource: EventDataSource(events.events),
          todayHighlightColor: Colors.white,
          cellBorderColor: Colors.transparent,
          view: CalendarView.month,
          headerHeight: 100,
          headerStyle: CalendarHeaderStyle(textAlign: TextAlign.start),
          showDatePickerButton: true,
          showNavigationArrow: true,
        ),
      ),
    );
  }
}
