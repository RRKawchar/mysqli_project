class ProductModal {
  String? id;
  String? productName;
  String? price;
  String? quentity;
  String? details;

  ProductModal(
      {this.id, this.productName, this.price, this.quentity, this.details});

  ProductModal.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    price = json['price'];
    quentity = json['quentity'];
    details = json['details'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['price'] = this.price;
    data['quentity'] = this.quentity;
    data['details'] = this.details;
    return data;
  }
}
