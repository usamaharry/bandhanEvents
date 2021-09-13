import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/eventDetail.dart';
import '../models/event.dart';

class MyListTile extends StatelessWidget {
  final Event event;

  MyListTile({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, EventDetail.routeName,
                  arguments: event);
            },
            title: Text(event.name),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DateFormat.jm().format(event.from) + '-'),
                Text(
                  DateFormat.jm().format(event.to),
                ),
              ],
            ),
            trailing: Text(
              (event.ladies + event.gents).toString(),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
