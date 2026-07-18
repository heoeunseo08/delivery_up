class cartItem {
  final int menuId;
  final String menuName;
  final String imageUrl;
  final List<String> optionNames;
  final List<int> optionIds;
  final int unitPrice;
  int quantity;

  cartItem({
    required this.menuId,
    required this.menuName,
    required this.imageUrl,
    required this.optionNames,
    required this.optionIds,
    required this.unitPrice,
    required this.quantity,
  });

  int get totalPrice => unitPrice * quantity;
}

CartController cartController = CartController();

class CartController {
  int? storeId;
  int? orderId;
  String? storeName;
  int minPrice = 0;
  int fee = 0;
  List<cartItem> items = [];

  int get itemsTotal => items.fold(0, (i, e) => i + e.totalPrice);

  int get totalPrice => itemsTotal + fee;

  bool get canOrder => itemsTotal >= minPrice;

  bool anotherStore(int another) => storeId != null && storeId != another;

  void set({
    required int storeId,
    required String storeName,
    required int minPrice,
    required int fee,
  }) {
    this.storeId = storeId;
    this.storeName = storeName;
    this.minPrice = minPrice;
    this.fee = fee;
  }

  void add(cartItem item) => items.add(item);

  void updateUpDown(int index, bool type) {
    if (type) {
      items[index].quantity++;
    } else {
      if (items[index].quantity > 1) {
        items[index].quantity--;
      }
    }
  }

  void remove(int index) => items.removeAt(index);

  void clear() {
    storeId = null;
    storeName = null;
    minPrice = 0;
    fee = 0;
    items.clear();
  }
}
