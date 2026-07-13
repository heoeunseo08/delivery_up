class ProfileModel {
  final int orderCount;
  final int favoriteCount;
  final int reviewCount;

  ProfileModel({
    required this.orderCount,
    required this.favoriteCount,
    required this.reviewCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    orderCount: json["orderCount"],
    favoriteCount: json["favoriteCount"],
    reviewCount: json["reviewCount"],
  );
}
