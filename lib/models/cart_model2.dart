class CartModel2 {
  String? id;
  String? name;
  String? description;
  String? image;
  int? totalPrice;
  int? price;
  int? price2;
  bool? onSale;
  int? count;

  CartModel2(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.totalPrice,
      required this.count,
      required this.price,
      required this.onSale,
      required this.price2});

  CartModel2.fromJson(Map<String, dynamic> map) {
    id = map['id'];

    price2 = map['price2'];
    print("  ${price2}");
    onSale = map['onSale'];
    name = map['name'];
    description = map['description'];
    image = map['image'];
    totalPrice = map['totalPrice'];
    price = map['price'];
    count = map['count'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "price2": price2,
      "onSale": onSale,
      "name": name,
      "description": description,
      "image": image,
      "count": count,
      "totalPrice": totalPrice,
      "price": price,
    };
  }
}
