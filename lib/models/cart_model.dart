// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:animation_app/models/course_model.dart';

class Cart {
  String userId;
  List<CourseModel> items;

  Cart({
    required this.userId,
    required this.items,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      userId: map['userId'] as String,
      items: List<CourseModel>.from((map['items'] as List<dynamic>).map<CourseModel>((x) => CourseModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}
