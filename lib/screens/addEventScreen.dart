import 'dart:convert';

import 'package:bandhan/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/eventProvider.dart';
import '../widgets/textAddEvent.dart';
import '../widgets/textField.dart' as tx;
import '../widgets/dynamicTextField.dart';

class AddEventScreen extends StatefulWidget {
  static var screenName = '/addEventScreen';

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String name = "Name";
  String address = "Address";
  String phone = "Phone";
  String cnic = "Cnic";
  String type = 'Others';

  List<String> items = [];
  List<String> services = [];

  String others = 'Others';

  double perhead = 0;
  double advance = 0;

  var from = DateTime.now();
  var to = DateTime.now().add(
    Duration(hours: 2),
  );

  var currentDate = DateTime.now();
  var date = DateTime.now();
  var ladies = 0.0;
  var gents = 0.0;

  @override
  initState() {
    super.initState();

    items.add('Item');
    services.add('Service');
  }

  dynamic myDateSerializer(dynamic object) {
    if (object is DateTime) {
      return object.toIso8601String();
    }
    return object;
  }

  var otherCOntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<EventProvider>(context);

    var naviBar = CupertinoNavigationBar(
      backgroundColor: Colors.black,
      middle: Text(
        'Add Event',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      leading: CupertinoButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Icon(
          CupertinoIcons.back,
          color: Colors.white,
        ),
      ),
      trailing: CupertinoButton(
        padding: EdgeInsets.all(10),
        child: Text(
          'Add',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          final current = DateTime.now();

          final url = Uri.https(
              'bandhanevents-bf075-default-rtdb.asia-southeast1.firebasedatabase.app',
              '/event.json');

          if (name != 'Name' &&
              name != '' &&
              address != 'Address' &&
              address != '' &&
              phone != 'Phone' &&
              phone != '' &&
              cnic != 'Cnic' &&
              cnic != '' &&
              perhead != 0 &&
              type != 'Unselected') {
            print('gege');
            http
                .post(
              url,
              body: json.encode(
                {
                  'name': name,
                  'address': address,
                  'phone': phone,
                  'cnic': cnic,
                  'gents': gents,
                  'ladies': ladies,
                  'advance': advance,
                  'perhead': perhead,
                  'type': type,
                  'functiondate': date,
                  'bookingdate': DateTime.now(),
                  'starttime': from,
                  'endtime': to,
                  'others': others,
                  'items': items,
                  'services': services,
                },
                toEncodable: myDateSerializer,
              ),
            )
                .then((value) {
              print('hehe');
              event.addEvent(
                Event(
                  id: json.decode(value.body)['name'],
                  bookingDate: DateTime.now(),
                  functionDate: date,
                  type: type,
                  services: services,
                  perHead: perhead,
                  phone: phone,
                  items: items,
                  ladies: ladies.toInt(),
                  gents: gents.toInt(),
                  cnic: cnic,
                  advance: advance,
                  address: address,
                  name: name,
                  others: others,
                  from: from,
                  to: to,
                  color: Colors.white,
                ),
              );
              Navigator.of(context).pop();
            });
          }
        },
      ),
    );

    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tx.TextField(
                name != '' ? 'Name' : name,
                (String val) {
                  name = val;
                },
              ),
              tx.TextField(
                address != '' ? 'Address' : address,
                (String val) {
                  address = val;
                },
              ),
              tx.TextField(
                phone != '' ? 'Phone' : phone,
                (String val) {
                  phone = val;
                },
              ),
              tx.TextField(
                cnic != '' ? 'Cnic' : cnic,
                (String val) {
                  cnic = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Textt(
                      text: 'Gents',
                      color: Colors.white,
                    ),
                    Textt(color: Colors.white, text: '${gents.toInt()}'),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: CupertinoSlider(
                  thumbColor: Colors.white,
                  activeColor: Colors.white,
                  divisions: 100,
                  min: 0,
                  max: 500,
                  value: gents,
                  onChanged: (newVal) {
                    setState(() {
                      gents = newVal;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Textt(
                      text: 'Ladies',
                      color: Colors.white,
                    ),
                    Textt(color: Colors.white, text: '${ladies.toInt()}'),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: CupertinoSlider(
                  thumbColor: Colors.white,
                  activeColor: Colors.white,
                  divisions: 100,
                  min: 0,
                  max: 500,
                  value: ladies,
                  onChanged: (newVal) {
                    setState(() {
                      ladies = newVal;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Textt(
                      text: 'Function Date',
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onTap: () {
                        bottomSheetDate();
                      },
                      child: Textt(
                        text: DateFormat.yMMMMd().format(
                          date,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Textt(
                      text: 'Type',
                      color: Colors.white,
                    ),
                    GestureDetector(
                      onTap: () {
                        bottomSheetPicker(context);
                      },
                      child: Textt(
                        color: Colors.white,
                        text: type,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Textt(
                      text: 'Start',
                      color: Colors.green,
                    ),
                    GestureDetector(
                      onTap: () {
                        bottomSheetTime(true);
                      },
                      child: Textt(
                        color: Colors.white,
                        text: DateFormat.jm().format(from),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Textt(
                      text: 'End',
                      color: Colors.red,
                    ),
                    GestureDetector(
                      onTap: () {
                        bottomSheetTime(false);
                      },
                      child: Textt(
                        color: Colors.white,
                        text: DateFormat.jm().format(to),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: tx.TextField(
                      'Per Head',
                      (String val) {
                        perhead = double.tryParse(val) ?? 0.0;
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 60)),
                  Flexible(
                    flex: 1,
                    child: tx.TextField(
                      'Advance',
                      (String val) {
                        advance = double.tryParse(val) ?? 0;
                      },
                    ),
                  )
                ],
              ),
              DynamicTextFields('Items', items),
              DynamicTextFields('Services', services),
              Container(
                margin: EdgeInsets.all(8.0),
                // hack textfield height
                padding: EdgeInsets.only(bottom: 40.0),
                child: CupertinoTextField(
                  onChanged: (String val) => others = val,
                  placeholder: others,
                  placeholderStyle: TextStyle(
                    color: Colors.grey[350],
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  maxLines: 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      navigationBar: naviBar,
    );
  }

  void bottomSheetDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          actions: [
            datePicker(),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }

  Widget datePicker() {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          initialDateTime: date,
          minimumDate: currentDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (newDate) {
            setState(() {
              date = newDate;
            });
          },
        ),
      ),
    );
  }

  void bottomSheetTime(bool isStart) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          actions: [
            timePicker(isStart),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }

  Widget timePicker(bool isStart) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          initialDateTime: isStart
              ? from
              : from.add(
                  Duration(
                    hours: 2,
                  ),
                ),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (newDate) {
            setState(() {
              if (isStart) {
                from = newDate;
                to = from.add(Duration(hours: 2));
              } else
                to = newDate;
            });
          },
        ),
      ),
    );
  }

  void bottomSheetPicker(BuildContext ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            cupertinoPicker(),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }

  Widget cupertinoPicker() {
    return SizedBox(
      height: 150,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            pickerTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            dateTimePickerTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        child: CupertinoPicker(
          itemExtent: 30,
          onSelectedItemChanged: (int index) {
            setState(() {
              if (index == 0) type = 'Others';
              if (index == 1) type = 'Mehndi';
              if (index == 2) type = 'Barat';
              if (index == 3) type = 'Valima';
              if (index == 4) type = 'Birthday';
              if (index == 5) type = 'Lucky Draw';
              if (index == 6) type = 'Meeting';
            });
          },
          children: [
            Text('Others'),
            Text('Mehndi'),
            Text('Barat'),
            Text('Valima'),
            Text('Birthday'),
            Text('Lucky Draw'),
            Text('Meeting'),
          ],
        ),
      ),
    );
  }
}
