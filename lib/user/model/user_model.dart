import 'dart:developer';

class UserModel {
  final String email;
  final String username;
  final String fullName;
  final String avatarUrl;

  UserModel({
    required this.email,
    required this.username,
    required this.fullName,
    required this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    log(json.runtimeType.toString(), name: "user model json");
    return UserModel(
      email: json['email'],
      username: json['username'],
      fullName: json['full_name'],
      avatarUrl: json['avatar_url'],
    );
  }
}
