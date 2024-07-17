class AuthDTO {
  final String email;
  final String password;
  final String? username;

  AuthDTO({required this.email, required this.password, this.username});

  factory AuthDTO.fromJson(Map<String, dynamic> json) {
    return AuthDTO(
      email: json['email'],
      password: json['password'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'username': username,
      };
}
