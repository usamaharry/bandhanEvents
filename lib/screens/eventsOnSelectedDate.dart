import 'package:bandhan/screens/editScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/eventProvider.dart';
import '../widgets/listTile.dart';

class EventOnSelectedDate extends StatelessWidget {
  static const routeName = '/eventOnSelectedDate';

  @override
  Widget build(BuildContext context) {
    final DateTime date =
        ModalRoute.of(context)?.settings.arguments as DateTime;

    final events = Provider.of<EventProvider>(context);

    final eventOnDate = events.eventOnSelectedDate(date);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        leading: CupertinoButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        middle: Text(
          DateFormat.yMMMd().format(date),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      child: Scaffold(
        body: ListView.builder(
          itemCount: eventOnDate.length,
          itemBuilder: (ctx, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 9.0),
                  child: IconSlideAction(
                    color: Colors.white,
                    icon: CupertinoIcons.delete,
                    caption: 'Edit',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          editEventScreen.screenName,
                          arguments: eventOnDate[index]);
                    },
                  ),
                ),
              ],
              secondaryActions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 9.0),
                  child: IconSlideAction(
                    color: Colors.red,
                    icon: CupertinoIcons.delete,
                    caption: 'Delete',
                    onTap: () => showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        content: Text('Are you sure you want to delete?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                          CupertinoDialogAction(
                            child: Text('Yes'),
                            onPressed: () {
                              events.delete(eventOnDate[index].id);
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
              child: MyListTile(
                event: eventOnDate[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
