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

  User({required this.name, required this.email});

  User.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      name = json['name'];
      email = json['email'];
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

class Anggota {
  late String name;
  late String alamat;
  late String ttl;
  late String jenisKelamin;
  late String jabatan;

  Anggota(
      {required this.name,
      required this.alamat,
      required this.ttl,
      required this.jenisKelamin,
      required this.jabatan});

  Anggota.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      name = json['name'];
      alamat = json['alamat'];
      ttl = json['ttl'];
      jenisKelamin = json['jenisKelamin'];
      jabatan = json['jabatan'];
    } else {
      name = "";
      alamat = "";
      ttl = "";
      jenisKelamin = "";
      jabatan = "";
    }
  }
}
