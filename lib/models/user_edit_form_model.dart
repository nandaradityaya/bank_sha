class UserEditFormModel {
  final String? username;
  final String? name;
  final String? email;
  final String? password;
  // final String? pin;

// constructor
  UserEditFormModel({
    this.username,
    this.name,
    this.email,
    this.password,
    // this.pin,
  });

// method untuk mengubah ke bentuk Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'username': username,
      // 'pin': pin,
    };
  }
}
