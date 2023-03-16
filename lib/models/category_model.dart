// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  String image;
  String id;
  String category;
  int totalCourses;

  CategoryModel({
    required this.image,
    required this.id,
    required this.category,
    required this.totalCourses
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'id': id,
      'category': category,
      'totalCourses': totalCourses,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      image: map['image'] as String,
      id: map['id'] as String,
      category: map['category'] as String,
      totalCourses: map['totalCourses'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }
