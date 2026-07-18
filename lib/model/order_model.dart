class OrderModel {
  final int orderId;
  final String storeName;
  final String summary;
  final String orderedAt;
  final int totalPrice;
  final String status;
  bool reviewed;

  OrderModel({
    required this.orderId,
    required this.storeName,
    required this.summary,
    required this.orderedAt,
    required this.totalPrice,
    required this.status,
    required this.reviewed,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json["orderId"],
    storeName: json["storeName"],
    summary: json["summary"],
    orderedAt: json["orderedAt"],
    totalPrice: json["totalPrice"],
    status: json["status"],
    reviewed: json["reviewed"],
  );
}
