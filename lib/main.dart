import 'package:bandhan/providers/eventProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/calender.dart';
import 'providers/eventProvider.dart';
import 'screens/addEventScreen.dart';
import './screens/eventsOnSelectedDate.dart';
import './screens/eventDetail.dart';
import './providers/eventProvider.dart';
import './screens/editScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventProvider(),
      child: MaterialApp(
        routes: {
          AddEventScreen.screenName: (_) => AddEventScreen(),
          EventOnSelectedDate.routeName: (_) => EventOnSelectedDate(),
          EventDetail.routeName: (_) => EventDetail(),
          editEventScreen.screenName: (_) => editEventScreen(),
        },
        theme: ThemeData(
          accentColor: Colors.white,
          buttonColor: Colors.white,
          primaryColor: Colors.white,
        ),
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<void> refresh(BuildContext context) async {
    await Provider.of<EventProvider>(context, listen: false).loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        middle: Text(
          'Bandhan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: CupertinoButton(
          child: Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddEventScreen.screenName);
          },
        ),
        trailing: CupertinoButton(
          child: Icon(
            CupertinoIcons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            refresh(context);
          },
        ),
      ),
      child: Calender(),
    );
  }
}
