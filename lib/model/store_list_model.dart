class StoreListModel {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final int minOrderPrice;
  final int deliveryFee;
  final String category;
  final bool favorite;

  StoreListModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.minOrderPrice,
    required this.deliveryFee,
    required this.category,
    required this.favorite,
  });

  factory StoreListModel.fromJson(Map<String, dynamic> json) => StoreListModel(
    id: json["id"],
    name: json["name"],
    imageUrl: json["imageUrl"],
    rating: json["rating"],
    minOrderPrice: json["minOrderPrice"],
    deliveryFee: json["deliveryFee"],
    category: json["category"],
    favorite: json["favorite"],
  );
}
