class OrderModel2 {
  String? totalPrice;
  String? name;
  String? phone;
  String? address;
  String? orderBy;
  String? orderDate;
  String? orderNo;
  String? orderStatus;
  String? paymentMethod;
  List<String>? products;
  Map<String, String>? sizes;
  Map<String, String>? color;

  OrderModel2({
    required this.totalPrice,
    required this.orderBy,
    required this.orderDate,
    required this.orderNo,
    required this.phone,
    required this.name,
    required this.address,
    this.orderStatus = "Pending",
    required this.paymentMethod,
    required this.products,
    required this.sizes,
    required this.color,
  });

  OrderModel2.fromJson(Map<String, dynamic> json) {
    totalPrice = json["totalPrice"];
    name = json["name"];
    phone = json["phone"];
    address = json["address"];
    orderBy = json["orderBy"];
    orderDate = json["orderDate"];
    orderNo = json["orderNo"];
    orderStatus = json["orderStatus"];
    paymentMethod = json["paymentMethod"];
    if (json['products'] != null) {
      products!.clear();
      json['products'].forEach((element) {
        products!.add(element);
      });
    }
    if (json['sizes'] != null) {
      // sizes!.clear();
      json['sizes'].forEach((key, value) {
        sizes!.addAll(
          {
            key: value,
          },
        );
      });
    }
    if (json['color'] != null) {
      // color!.clear();
      json['color'].forEach((key, value) {
        color!.addAll(
          {
            key: value,
          },
        );
      });
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "totalPrice": totalPrice,
      "name": name,
      "phone": phone,
      "address": address,
      "orderBy": orderBy,
      "orderDate": orderDate,
      "orderNo": orderNo,
      "orderStatus": orderStatus,
      "paymentMethod": paymentMethod,
      "products": products,
      "sizes": sizes,
      "color": color,
    };
  }
}
