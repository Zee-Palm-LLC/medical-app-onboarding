import 'dart:convert';

import 'package:animation_app/models/course_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FavoriteItem {
  String id;
  String userId;
  CourseModel course;

  FavoriteItem({
    required this.id,
    required this.userId,
    required this.course,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'course': course.toMap(),
    };
  }

  factory FavoriteItem.fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      id: map['id'] as String,
      userId: map['userId'] as String,
      course: CourseModel.fromMap(map['course'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteItem.fromJson(String source) => FavoriteItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
