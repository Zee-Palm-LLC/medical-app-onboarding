// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:algolia/algolia.dart';
import 'package:animation_app/models/chapter_model.dart';
import 'category_model.dart';

class CourseModel {
  String id;
  String title;
  String description;
  String uploadedBy;
  String uploaderPic;
  String ownerId;
  CategoryModel category;
  String thumbnail;
  double price;
  String objectives;
  double rating;
  List<Chapter> chapters;
  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.uploadedBy,
    required this.uploaderPic,
    required this.ownerId,
    required this.category,
    required this.thumbnail,
    required this.price,
    required this.objectives,
    required this.rating,
    required this.chapters,
  });


 
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'uploadedBy': uploadedBy,
      'uploaderPic': uploaderPic,
      'ownerId': ownerId,
      'category': category.toMap(),
      'thumbnail': thumbnail,
      'price': price,
      'objectives': objectives,
      'rating': rating,
      'chapters': chapters.map((x) => x.toMap()).toList(),
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        uploadedBy: map['uploadedBy'] as String,
        uploaderPic: map['uploaderPic'] as String,
        ownerId: map['ownerId'] as String,
        category: CategoryModel.fromMap(map['category']),
        thumbnail: map['thumbnail'] as String,
        price: map['price'] as double,
        objectives: map['objectives'] as String,
        rating: map['rating'] as double,
        chapters: List<Chapter>.from(
          (map['chapters'] as List<dynamic>).map<Chapter>(
            (x) => Chapter.fromMap(x as Map<String, dynamic>),
          ),
        ),
     );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CourseModel.fromAlgolia(AlgoliaObjectSnapshot snapshot) {
    final data = snapshot.data;
    return CourseModel(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        uploadedBy: data['uploadedBy'],
        uploaderPic: data['uploaderPic'],
        ownerId: data['ownerId'],
        category:
            CategoryModel.fromMap(data['category'] as Map<String, dynamic>),
        thumbnail: data['thumbnail'],
        price: data['price'],
        objectives: data['objectives'],
        rating: data['rating'],
        chapters: List<Chapter>.from(data['chapters'].map(
          (chapterData) => Chapter.fromMap(chapterData),
        )),
        );
  }
}
