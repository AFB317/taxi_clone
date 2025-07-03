class User {
  dynamic id, token, countryId;
  String? firstName, lastName, phone, email, address;

  User();

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    address = map['address'];
    email = map['email'];
    phone = map['phone'];
    countryId = map['country_id'];
    token = map['token'];
  }
}
