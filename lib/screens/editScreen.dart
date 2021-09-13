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

class editEventScreen extends StatefulWidget {
  static var screenName = '/editEventScreen';

  String name = '';
  String address = '';
  String phone = '';
  String cnic = '';
  String type = '';

  List<dynamic> items = [];
  List<dynamic> services = [];
  String others = '';

  double perhead = 0;
  double advance = 0;

  var from;
  var to;
  var currentDate;
  var date;
  var ladies;
  var gents;

  bool isFirstTime = false;
  @override
  _editEventScreenState createState() => _editEventScreenState();
}

class _editEventScreenState extends State<editEventScreen> {
  @override
  initState() {
    super.initState();
    widget.isFirstTime = true;
  }

  final controller = TextEditingController();

  dynamic myDateSerializer(dynamic object) {
    if (object is DateTime) {
      return object.toIso8601String();
    }
    return object;
  }

  var otherCOntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Event;

    if (widget.isFirstTime) {
      widget.name = argument.name;
      widget.address = argument.address;
      widget.phone = argument.phone;
      widget.cnic = argument.cnic;
      widget.type = argument.type;

      widget.items = argument.items;
      widget.services = argument.services;

      widget.others = argument.others;
      widget.perhead = argument.perHead;
      widget.advance = argument.advance;

      widget.from = argument.from;
      widget.to = argument.to;
      widget.currentDate = argument.bookingDate;
      widget.date = argument.functionDate;
      widget.ladies = argument.ladies;
      widget.gents = argument.gents;

      controller.text = widget.others;

      widget.isFirstTime = false;
    }

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
          'Save',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          event.delete(argument.id);

          final url = Uri.https(
              'bandhanevents-bf075-default-rtdb.asia-southeast1.firebasedatabase.app',
              '/event.json');

          if (widget.name != 'Name' &&
              widget.name != '' &&
              widget.address != 'Address' &&
              widget.address != '' &&
              widget.phone != 'Phone' &&
              widget.phone != '' &&
              widget.cnic != 'Cnic' &&
              widget.cnic != '' &&
              widget.perhead != 0 &&
              widget.type != 'Unselected') {
            print('gege');
            http
                .post(
              url,
              body: json.encode(
                {
                  'name': widget.name,
                  'address': widget.address,
                  'phone': widget.phone,
                  'cnic': widget.cnic,
                  'gents': widget.gents,
                  'ladies': widget.ladies,
                  'advance': widget.advance,
                  'perhead': widget.perhead,
                  'type': widget.type,
                  'functiondate': widget.date,
                  'bookingdate': widget.currentDate,
                  'starttime': widget.from,
                  'endtime': widget.to,
                  'others': widget.others,
                  'items': widget.items,
                  'services': widget.services,
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
                  functionDate: widget.date,
                  type: widget.type,
                  services: widget.services,
                  perHead: widget.perhead,
                  phone: widget.phone,
                  items: widget.items,
                  ladies: widget.ladies.toInt(),
                  gents: widget.gents.toInt(),
                  cnic: widget.cnic,
                  advance: widget.advance,
                  address: widget.address,
                  name: widget.name,
                  others: widget.others,
                  from: widget.from,
                  to: widget.to,
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
                widget.name,
                (String val) {
                  widget.name = val;
                },
              ),
              tx.TextField(
                widget.address,
                (String val) {
                  widget.address = val;
                },
              ),
              tx.TextField(
                widget.phone,
                (String val) {
                  widget.phone = val;
                },
              ),
              tx.TextField(
                widget.cnic,
                (String val) {
                  widget.cnic = val;
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
                    Textt(color: Colors.white, text: '${widget.gents.toInt()}'),
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
                  value: widget.gents + .0,
                  onChanged: (newVal) {
                    setState(() {
                      widget.gents = newVal;
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
                    Textt(
                        color: Colors.white, text: '${widget.ladies.toInt()}'),
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
                  value: widget.ladies + .0,
                  onChanged: (newVal) {
                    setState(() {
                      widget.ladies = newVal;
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
                          widget.date,
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
                        text: widget.type,
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
                        text: DateFormat.jm().format(widget.from),
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
                        text: DateFormat.jm().format(widget.to),
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
                      widget.perhead.toStringAsFixed(0),
                      (String val) {
                        widget.perhead = double.tryParse(val) ?? 0.0;
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 60)),
                  Flexible(
                    flex: 1,
                    child: tx.TextField(
                      widget.advance.toStringAsFixed(0),
                      (String val) {
                        widget.advance = double.tryParse(val) ?? 0;
                      },
                    ),
                  )
                ],
              ),
              DynamicTextFields('Items', widget.items),
              DynamicTextFields('Services', widget.services),
              Container(
                margin: EdgeInsets.all(8.0),
                // hack textfield height
                padding: EdgeInsets.only(bottom: 40.0),
                child: CupertinoTextField(
                  controller: controller,
                  onChanged: (String val) => widget.others = val,
                  placeholder: widget.others,
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
          initialDateTime: widget.date,
          minimumDate: widget.currentDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (newDate) {
            setState(() {
              widget.date = newDate;
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
              ? widget.from
              : widget.from.add(
                  Duration(
                    hours: 2,
                  ),
                ),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (newDate) {
            setState(() {
              if (isStart) {
                widget.from = newDate;
                widget.to = widget.from.add(Duration(hours: 2));
              } else
                widget.to = newDate;
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
              if (index == 0) widget.type = 'Others';
              if (index == 1) widget.type = 'Mehndi';
              if (index == 2) widget.type = 'Barat';
              if (index == 3) widget.type = 'Valima';
              if (index == 4) widget.type = 'Birthday';
              if (index == 5) widget.type = 'Lucky Draw';
              if (index == 6) widget.type = 'Meeting';
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
