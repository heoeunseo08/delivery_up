class StoreDetailModel {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final int minOrderPrice;
  final int deliveryFee;
  final String category;
  bool favorite;
  final List<MenusModel> menus;

  StoreDetailModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.minOrderPrice,
    required this.deliveryFee,
    required this.category,
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
        category: json["category"],
        favorite: json["favorite"],
        menus: (json["menus"] as List)
            .map((e) => MenusModel.fromJson(e))
            .toList(),
      );
}

class MenusModel {
  final int id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final String menuCategory;
  final List<optionsModel> options;

  MenusModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.menuCategory,
    required this.options,
  });

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    menuCategory: json["menuCategory"],
    options: (json["options"] as List)
        .map((e) => optionsModel.fromJson(e))
        .toList(),
  );
}

class optionsModel {
  final String group;
  final bool required;
  final List<itemsModel> items;

  optionsModel({
    required this.group,
    required this.required,
    required this.items,
  });

  factory optionsModel.fromJson(Map<String, dynamic> json) => optionsModel(
    group: json["group"],
    required: json["required"],
    items: (json["items"] as List).map((e) => itemsModel.fromJson(e)).toList(),
  );
}

class itemsModel {
  final int id;
  final String name;
  final int price;

  itemsModel({required this.id, required this.name, required this.price});

  factory itemsModel.fromJson(Map<String, dynamic> json) => itemsModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
  );
}
