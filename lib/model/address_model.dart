class AddressModel {
  final int id;
  final String label;
  final String address;
  final String addressDetail;
   bool isDefault;

  AddressModel({
    required this.id,
    required this.label,
    required this.address,
    required this.addressDetail,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    label: json["label"],
    address: json["address"],
    addressDetail: json["addressDetail"],
    isDefault: json["isDefault"],
  );
}
