import '../utils/constants.dart';

class ServiceType {
  dynamic id;
  String? image, name, description;

  ServiceType({this.id, this.name, this.image});

  setDescription(String des) {
    description = des;
  }

  ServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  static List<ServiceType> defaults = [
    ServiceType(id: 1, name: "taxi", image: taxi),
    ServiceType(id: 2, name: "parcel_delivery", image: package),
  ];
}
