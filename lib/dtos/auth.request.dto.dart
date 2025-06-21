class AuthRequestDto {
  String? email;
  String? password;
  String? name;

  AuthRequestDto({this.email, this.password, this.name});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, "name": name};
  }

  factory AuthRequestDto.fromJson(Map<String, dynamic> json) {
    return AuthRequestDto(
      email: json['email'],
      password: json['password'],
      name: json['name'],
    );
  }

  bool isValid() {
    return email != null &&
        email!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty;
  }
}
