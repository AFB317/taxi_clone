class Country {
  dynamic id;
  String? name, prefix, code, currency;

  Country({this.id, this.prefix, this.name, this.code, this.currency});

  static List<Country> defaultCountries = [
    Country(
        id: 1, name: "Burundi", code: "BI", prefix: "+257", currency: "BIF"),
    Country(
        id: 8, name: "Canada", code: "CAD", prefix: "+1", currency: "CAD"),
  ];

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    prefix = json['prefix'];
    code = json['code'];
    currency = json['currency'];
  }
}
