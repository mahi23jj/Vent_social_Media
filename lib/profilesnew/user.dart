import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;

  final String username;
  final String? profileImageUrl;
  final String? bio;

  UserModel({
    required this.id,
    required this.profileImageUrl,
    required this.username,
    this.bio,

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'bio': bio,

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] as String,
        username: map['username'] as String,
        profileImageUrl: map['profileImageUrl'] != null
            ? map['profileImageUrl'] as String
            : null,

        );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}