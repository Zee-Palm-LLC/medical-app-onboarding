// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:animation_app/data/enums/user_type.dart';

class UserModel {
  String? id;
  String? email;
  String? fullName;
  String? profilePic;
  UserType? userType;
  UserModel(
      {this.id, this.email, this.fullName, this.profilePic, this.userType});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullName': fullName,
      'profilePic': profilePic,
      'userType': userType?.index,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
      userType:
          map['userType'] != null ? UserType.values[map['userType']] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
