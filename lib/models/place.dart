class Place {
  dynamic id, name, address, latitude, longitude;

  Place();

  Place.fromJson(Map json) {
    name = json['name'] ?? json['address_components'][0]['long_name'];
    address = json['formatted_address'];
    latitude = double.parse("${json['geometry']['location']['lat']}");
    longitude = double.parse("${json['geometry']['location']['lng']}");
  }
  Place.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    address = map['address'];
    latitude = map['lat'];
    longitude = map['lng'];
  }
}
