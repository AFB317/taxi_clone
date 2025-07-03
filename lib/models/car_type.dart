class CarType {
  dynamic id, persons,price;
  String? name, image,currency;

  CarType({this.persons, this.id, this.name, this.image,this.price,this.currency});

  CarType.fromJson({required Map<String, dynamic> json, required dynamic p,required String c}) {
    id = json['id'];
    name = json['name'];
    image = json['photo'];
    persons = json['max_person'];
    price = p;
    currency = c;
  }
}