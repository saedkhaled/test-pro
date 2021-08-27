import 'dart:convert';

class MyUser {
  String? email;
  String? password;
  String? name;
  String? uid;
  bool? gender;
  int? age;
  int? length;
  int? weight;

  MyUser({
    this.email,
    this.password,
    this.name,
    this.uid,
    this.gender,
    this.age,
    this.length,
    this.weight,
  });

  factory MyUser.fromJson(String str) => MyUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyUser.fromMap(Map<String, dynamic> json) => MyUser(
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        name: json["name"] == null ? null : json["name"],
        uid: json["uid"] == null ? null : json["uid"],
        gender: json["gender"] == null ? null : json["gender"],
        age: json["age"] == null ? null : json["age"],
        length: json["length"] == null ? null : json["length"],
        weight: json["weight"] == null ? null : json["weight"],
      );

  Map<String, dynamic> toMap() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "name": name == null ? null : name,
        "uid": uid == null ? null : uid,
        "gender": gender == null ? null : gender,
        "age": age == null ? null : age,
        "length": length == null ? null : length,
        "weight": weight == null ? null : weight,
      };
}
