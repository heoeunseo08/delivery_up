class StoreDetailModel {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final int minOrderPrice;
  final int deliveryFee;
  bool favorite;
  final List<MenusModel> menus;

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
  final List<OptionsModel> options;

  MenusModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.options,
  });

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    options: (json["options"] as List)
        .map((e) => OptionsModel.fromJson(e))
        .toList(),
  );
}

class OptionsModel {
  final String group;
  final bool required;
  final List<itemsModel> items;

  OptionsModel({
    required this.group,
    required this.required,
    required this.items,
  });

  factory OptionsModel.fromJson(Map<String, dynamic> json) => OptionsModel(
    group: json["group"],
    required: json["required"],
    items: (json["items"] as List)
        .map(
          (e) => itemsModel.fromJson(e),
        )
        .toList(),
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
