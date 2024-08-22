class AuthDTO {
  final String email;
  final String password;
  final String? username;
  final String? fullName;

  AuthDTO({required this.email, required this.password, this.username, this.fullName});

  factory AuthDTO.fromJson(Map<String, dynamic> json) {
    return AuthDTO(
      email: json['email'],
      password: json['password'],
      username: json['username'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'username': username,
        'fullName': fullName,
      };
}
