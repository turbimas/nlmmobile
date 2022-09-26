class GoogleAddressModel {
  String buildingNo;
  String street;
  String district;
  String town;
  String city;
  String country;
  String postalCode;
  String formatAddress;

  GoogleAddressModel.fromJson(Map<String, dynamic> json)
      : buildingNo = json["BuildingNo"],
        street = json["Street"],
        district = json["District"],
        town = json["Town"],
        city = json["City"],
        country = json["Country"],
        postalCode = json["PostalCode"],
        formatAddress = json["format_adress"];

  toJson() {
    return {
      "BuildingNo": buildingNo,
      "Street": street,
      "District": district,
      "Town": town,
      "City": city,
      "Country": country,
      "PostalCode": postalCode,
      "format_adress": formatAddress,
    };
  }
}
