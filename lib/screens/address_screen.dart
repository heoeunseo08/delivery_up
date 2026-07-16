import 'package:delivery_up/controller/address_controller.dart';
import 'package:delivery_up/controller/method_controller.dart';
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
  TextEditingController addressTextController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  int selectIndex = 0;

  @override
  void dispose() {
    addressTextController.dispose();
    addressDetailController.dispose();
    super.dispose();
  }

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
                    onTap: () async {
                      await showAddressSheet();
                      setState(() {});
                    },
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
    return model.label;
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

  Future<void> showAddressSheet() async {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, set) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                titleText("배송지 추가"),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "주소",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                TextField(
                  controller: addressTextController,
                  decoration: InputDecoration(
                    border: border,
                    disabledBorder: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    hint: hintTexts("예) 서울시 강남구 테헤란로123"),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "상세주소",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: addressDetailController,
                  decoration: InputDecoration(
                    border: border,
                    disabledBorder: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    hint: hintTexts("동·호수를 입력하세요 (최대 50자)"),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "라벨",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24),
                Wrap(
                  children: List.generate(
                    addressController.addressLabels.length,
                    (index) {
                      final label = addressController.addressLabels[index];
                      bool select =
                          label == addressController.addressLabels[selectIndex];
                      return GestureDetector(
                        onTap: () => set(() => selectIndex = index),
                        child: Container(
                          margin: EdgeInsets.only(right: 6),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: select
                                ? mainColor
                                : subColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: select ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 24),
                buttons(
                  context: context,
                  text: "저장",
                  onTap: () async {
                    if (addressTextController.text.isEmpty) {
                      showMessage("주소를 입력새주세요.");
                      return;
                    }
                    if (addressDetailController.text.length > 50) {
                      showMessage("최대 50자 까지만 입력할 수 있습니다.");
                      return;
                    }
                    await addressController.addAddress(
                      addressText: addressTextController.text.trim(),
                      addressDetailText: addressDetailController.text.trim(),
                      labelText: addressController.addressLabels[selectIndex],
                    );
                    await addressController.loadAddress();
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
