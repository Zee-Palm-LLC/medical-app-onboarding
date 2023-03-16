// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:animation_app/models/course_model.dart';

class PurchasedCourses {
  String id;
  DateTime purchaseDate;
  CourseModel course;
  double totalValue;
  double completedValue;
  PurchasedCourses({
    required this.id,
    required this.purchaseDate,
    required this.course,
    required this.totalValue,
    required this.completedValue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'purchaseDate': purchaseDate.millisecondsSinceEpoch,
      'course': course.toMap(),
      'totalValue': totalValue,
      'completedValue': completedValue,
    };
  }

  factory PurchasedCourses.fromMap(Map<String, dynamic> map) {
    return PurchasedCourses(
      id: map['id'] as String,
      purchaseDate: DateTime.fromMillisecondsSinceEpoch(map['purchaseDate'] as int),
      course: CourseModel.fromMap(map['course'] as Map<String,dynamic>),
      totalValue: map['totalValue'] as double,
      completedValue: map['completedValue'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchasedCourses.fromJson(String source) =>
      PurchasedCourses.fromMap(json.decode(source) as Map<String, dynamic>);
}
