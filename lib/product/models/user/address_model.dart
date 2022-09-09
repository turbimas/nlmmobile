class AddressModel {
  int id;
  String addressHeader;
  String country;
  String city;
  String town;
  String address;

  // from json
  AddressModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        addressHeader = json['AdressHeader'],
        country = json['Country'],
        city = json['City'],
        town = json['Town'],
        address = json['Adress'];

  @override
  operator ==(o) => o is AddressModel && o.id == id;
}
