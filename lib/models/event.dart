import 'package:flutter/material.dart';

class Event {
  final String type;
  final String name;
  final String address;
  final String phone;
  final String cnic;
  int gents;
  int ladies;
  double perHead;
  double advance;
  final String others;
  final DateTime bookingDate;
  final DateTime functionDate;
  final DateTime from;
  final DateTime to;
  List<dynamic> items;
  List<dynamic> services;
  Color color;
  final String id;

  void setColor(Color clr) {
    color = clr;
  }

  Event({
    required this.id,
    required this.bookingDate,
    required this.functionDate,
    required this.type,
    required this.name,
    required this.address,
    required this.phone,
    required this.cnic,
    required this.gents,
    required this.ladies,
    required this.perHead,
    required this.advance,
    required this.others,
    required this.from,
    required this.to,
    required this.color,
    required this.items,
    required this.services,
  });
}
