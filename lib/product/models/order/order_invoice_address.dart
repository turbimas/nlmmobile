class OrderInvoiceAddress {
  late final int ID;
  String? AdresBasligi;
  String? Address;
  String? MobilePhone;
  String? Email;
  String? RelatedPerson;
  String? TaxOffice;
  String? TaxNumber;
  bool? isPerson;
  String? TCKNo;
  DateTime? DeliveryDate;

  OrderInvoiceAddress.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    AdresBasligi = json['AdresBasligi'];
    Address = json['Address'];
    MobilePhone = json['MobilePhone'];
    Email = json['Email'];
    RelatedPerson = json['RelatedPerson'];
    TaxOffice = json['TaxOffice'];
    TaxNumber = json['TaxNumber'];
    isPerson = json['isPerson'];
    TCKNo = json['TCKNo'];
    DeliveryDate = json["DeliveryDate"] != null
        ? DateTime.parse(json['DeliveryDate'])
        : null;
  }
}
