class UserModel {
  late int id;
  late String nameSurname;
  late String email;
  var phone;
  var password;
  var gender;
  var birthDate;
  String? imageUrl;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    nameSurname = json['Name'];
    email = json['Email'];
    phone = json['MobilePhone'];
    password = json["Password"];
    gender = json["Cinsiyet"];
    birthDate = json["BornDate"];
    imageUrl = json["imageUrl"];
  }
}
