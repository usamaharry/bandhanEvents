import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../models/event.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [];

  void delete(String id) async {
    final url = Uri.https(
        'bandhanevents-bf075-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/event/$id.json');

    await http.delete(url).then((value) {
      print(value.body);
      _events.removeWhere((element) {
        print(element.id + '    ' + id);
        return element.id == id;
      });

      notifyListeners();
    });
  }

  List<Event> eventOnSelectedDate(DateTime date) {
    return events
        .where((element) =>
            element.functionDate.year == date.year &&
            element.functionDate.month == date.month &&
            element.functionDate.day == date.day)
        .toList();
  }

  List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.purple];
  int index = 0;

  Future<void> loadEvents() async {
    print('in Load Events');
    final url = Uri.https(
        'bandhanevents-bf075-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/event.json');
    var response = await http.get(url);
    try {
      final data = json.decode(response.body) as Map<String, dynamic>;
      _events.clear();
      data.forEach((key, value) {
        addEvent(
          Event(
            color: Colors.white,
            id: key,
            bookingDate: DateTime.parse(value['bookingdate']),
            functionDate: DateTime.parse(value['functiondate']),
            type: value['type'],
            name: value['name'],
            address: value['address'],
            phone: value['phone'],
            cnic: value['cnic'],
            gents: value['gents'].toInt(),
            ladies: value['ladies'].toInt(),
            perHead: value['perhead'],
            advance: value['advance'],
            others: value['others'],
            from: DateTime.parse(value['starttime']),
            to: DateTime.parse(value['endtime']),
            items: value['items'],
            services: value['services'],
          ),
        );
      });
    } catch (error) {
      throw (error);
    }
    notifyListeners();
  }

  List<Event> get events {
    return [..._events];
  }

  void addEvent(Event event) {
    index = index % 4;

    print(event.name);
    print(event.address);
    print(event.phone);
    print(event.cnic);
    print(event.gents);
    print(event.ladies);
    print(DateFormat.yMMMMd().format(event.bookingDate));
    print(DateFormat.yMMMMd().format(event.functionDate));
    print(DateFormat.jm().format(event.from));
    print(DateFormat.jm().format(event.to));
    print(event.perHead);
    print(event.advance);
    print(event.others);

    event.items.forEach((element) {
      print(element);
    });

    event.services.forEach((element) {
      print(element);
    });

    event.setColor(colors[index]);
    index++;
    _events.add(event);
    notifyListeners();
  }
}
