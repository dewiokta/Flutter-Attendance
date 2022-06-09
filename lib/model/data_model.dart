class LoginAuth {
  late String message;
  late TokenAuth data;

  LoginAuth({required this.message, required this.data});
  LoginAuth.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = TokenAuth.fromJson(json['data']);
  }
}

class TokenAuth {
  late String token;
  TokenAuth({required this.token});

  TokenAuth.fromJson(Map<String, dynamic> data) {
    token = data['token'];
  }
}

class User {
  late String name;
  late String email;
  late int id;

  User({required this.name, required this.email, required this.id});

  User.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      name = json['name'];
      email = json['email'];
      id = json['id'];
    } else {
      name = "";
      email = "";
    }
  }
}

class Logout {
  late String message;

  Logout({required this.message});

  Logout.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
