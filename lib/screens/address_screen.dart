import 'package:delivery_up/controller/address_controller.dart';
import 'package:delivery_up/model/address_model.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:delivery_up/utils/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  AddressController addressController = AddressController();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await addressController.loadAddress();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "배송지 관리",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
      ),
      body: addressController.isLoading
          ? loadingWidget()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ...List.generate(
                    addressController.models.length,
                    (index) {
                      final model = addressController.models[index];
                      return addressWidget(model);
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.widthOf(context),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: mainColor, width: 1.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: mainColor, size: 30),
                          SizedBox(width: 10),
                          Text(
                            "배송지 추가",
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String addressTitle(AddressModel model) {
    for (int i = 0; i < addressController.addressCode.length; i++) {
      if (model.label == addressController.addressCode[i]) {
        return addressController.addressLabels[i];
      }
    }
    return "";
  }

  Widget addressWidget(AddressModel model) {
    return GestureDetector(
      onTap: () {
        addressController.setDefault(model.id);
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.only(top: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: subColor.withOpacity(0.5), width: 1.5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on_outlined, color: mainColor, size: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            addressTitle(model),
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 8),
                          model.isDefault
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.2),
                                    borderRadius: .circular(99),
                                  ),
                                  child: Text(
                                    "대표",
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          addressController.removeAddress(model.id);
                          setState(() {});
                        },
                        child: Icon(
                          CupertinoIcons.delete_simple,
                          color: subColor,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    model.address,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    model.addressDetail,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: subColor,
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
