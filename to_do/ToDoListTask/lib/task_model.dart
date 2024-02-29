// ignore: unused_import
import 'package:flutter/foundation.dart';

class Task {
  final String name;
  final String design;
  final String date;

  Task({
    required this.name,
    required this.design,
    required this.date,
  });

   factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
      design: map['design'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'design': design,
      'date': date,
    };
  }
}
