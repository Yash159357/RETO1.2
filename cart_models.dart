//Details of Product we will show in our Cart

class CartModel {
  final String productName;

  final double productPrice;

  final String categoryName;

  final List imageUrl;

  int quantity; //Number of quantities of product the customer want to buy

  final int instock; //Number of quantities of product are in stock for sell

  final String productId;

  final String productSize;

  final int discount;

  final String description;

  final String vendorId;

  CartModel({
    required this.productName,
    required this.productPrice,
    required this.categoryName,
    required this.imageUrl,
    required this.quantity,
    required this.instock,
    required this.productId,
    required this.productSize,
    required this.discount,
    required this.description,
    required this.vendorId,
  });

  // conversion to json for local storage
  Map<String, dynamic> toJson() => {
    'productName': productName,
    'productPrice': productPrice,
    'categoryName': categoryName,
    'imageUrl': imageUrl,
    'quantity': quantity,
    'instock': instock,
    'productId': productId,
    'productSize': productSize,
    'discount': discount,
    'description': description,
    'vendorId': vendorId,
  };

  // conversion from storage to convert it into cartmodel instances
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    productName: json['productName'],
    productPrice: json['productPrice'].toDouble(),
    categoryName: json['categoryName'],
    imageUrl: List<String>.from(json['imageUrl']),
    quantity: json['quantity'],
    instock: json['instock'],
    productId: json['productId'],
    productSize: json['productSize'],
    discount: json['discount'],
    description: json['description'],
    vendorId: json['vendorId'],
  );
}
