// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Chapter {
  String id;
  String title;
  String description;
  String videoUrl;
  Chapter({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      videoUrl: map['videoUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source) as Map<String, dynamic>);
}
