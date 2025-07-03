import 'package:duma_taxi/utils/constants.dart';

class PaymentMethod {
  dynamic id, discount;
  String? name, image;

  PaymentMethod({this.id, this.discount, this.name, this.image});

  static List<PaymentMethod> defaultPaymentMethods = [
    PaymentMethod(
      id: 1,
      discount: 0,
      name: "Cash",
      image: null,
    ),
    PaymentMethod(
      id: 2,
      discount: 20,
      name: "Afripay",
      image: afripayImage,
    ),
  ];

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['logo'];
    if (json['discount'] != null) {
      discount = json['discount'];
    }
  }
}
