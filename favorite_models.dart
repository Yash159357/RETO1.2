//Details of Product we will show in Favorite Screen

class FavoriteModel {
  final String productName;

  final int productPrice;

  final List imageUrl;

  final String productId;

  FavoriteModel({
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.productId,
  });
  // conversion to json for local storage
  Map<String, dynamic> toJson() => {
    'productName': productName,
    'productPrice': productPrice,
    'imageUrl': imageUrl,
    'productId': productId,
  };
  // conversion from storage to convert it into cartmodel instances
  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    productName: json['productName'],
    productPrice: json['productPrice'],
    imageUrl: List<String>.from(json['imageUrl']),
    productId: json['productId'],
  );
}
