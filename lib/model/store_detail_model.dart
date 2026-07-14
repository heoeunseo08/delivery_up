class StoreDetailModel {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final int minOrderPrice;
  final int deliveryFee;
   bool favorite;
  final List<dynamic> menus;

  StoreDetailModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.minOrderPrice,
    required this.deliveryFee,
    required this.favorite,
    required this.menus,
  });

  factory StoreDetailModel.fromJson(Map<String, dynamic> json) =>
      StoreDetailModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        rating: json["rating"],
        minOrderPrice: json["minOrderPrice"],
        deliveryFee: json["deliveryFee"],
        favorite: json["favorite"],
        menus: json["menus"],
      );
}
