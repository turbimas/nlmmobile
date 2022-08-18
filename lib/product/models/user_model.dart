import 'dart:math';

class UserModel {
  String id = Random().nextInt(200).toString();
  // String nameSurname;
  // String mail;
  // String phone;
  // String password;
  String? gender;
  DateTime? birthDate;
  String? imageUrl;

  // UserModel.fromJson(Map<String, dynamic> json) {
  // id = json['id'];
  // nameSurname = json['nameSurname'];
  // mail = json['mail'];
  // phone = json['phone'];
  // password = json['password'];
  // }
  UserModel();
}
