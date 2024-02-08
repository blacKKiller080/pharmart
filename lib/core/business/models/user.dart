import 'dart:convert';

class User {
  final int? id;
  final String? fname;
  final String? lname;
  final String? phone;
  final String? email;
  final String? token;
  // final String? iin;
  // final String? birhday;

  User({
    this.id,
    this.fname,
    this.lname,
    this.phone,
    this.email,
    this.token,
  });

  User copyWith({
    int? id,
    String? fname,
    String? lname,
    String? phone,
    String? email,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (fname != null) {
      result.addAll({'name': fname});
    }
    if (lname != null) {
      result.addAll({'surname': lname});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (token != null) {
      result.addAll({'accessToken': token});
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      fname: map['name'],
      lname: map['surname'],
      phone: map['phone'],
      email: map['email'],
      token: map['accessToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $fname, surname: $lname, phone: $phone, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.fname == fname &&
        other.lname == lname &&
        other.phone == phone &&
        other.email == email &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fname.hashCode ^
        lname.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        token.hashCode;
  }
}
