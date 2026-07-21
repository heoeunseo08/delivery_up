import 'package:delivery_up_test4/controller/address_controller.dart';
import 'package:delivery_up_test4/controller/method_controller.dart';
import 'package:delivery_up_test4/model/address_model.dart';
import 'package:delivery_up_test4/utils/info.dart';
import 'package:flutter/material.dart';

import '../utils/widget.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  AddressController addressController = AddressController();
  TextEditingController address_controller = TextEditingController();
  TextEditingController addressDetail_controller = TextEditingController();

  int selectIndex = 0;

  @override
  void dispose() {
    address_controller.dispose();
    addressDetail_controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    load();
    setState(() {});
  }

  Future<void> load() async {
    await addressController.loadAddress();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 25,
                color: subColor,
              ),
            ),
            SizedBox(width: 20),
            Text(
              '배송지 관리',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: addressController.isLoading
            ? loading()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      addressController.models.length,
                      (index) {
                        final model = addressController.models[index];
                        return card(model);
                      },
                    ),
                    SizedBox(height: 30),
                    addButton(),
                  ],
                ),
              ),
      ),
    );
  }

  String addressLabel(AddressModel model) {
    for (int i = 0; i < addressController.labelCodes.length; i++) {
      if (model.label == addressController.labelCodes[i]) {
        return addressController.labelTexts[i];
      }
    }
    return '';
  }

  Widget card(AddressModel model) {
    return GestureDetector(
      onTap: () async {
        await addressController.setDefault(model.id);
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),

        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: subColor.withOpacity(0.2), width: 1.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on_outlined, color: mainColor, size: 30),
            Expanded(
              child: Column(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            addressLabel(model),
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                          if (model.isDefault)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: mainColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Text(
                                "대표",
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          await addressController.remove(model.id);
                          setState(() {});
                        },
                        child: Icon(
                          Icons.delete_outline_outlined,
                          color: subColor,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    model.address,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    model.addressDetail,
                    style: TextStyle(
                      color: subColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addButton() {
    return GestureDetector(
      key: Keys.step25,
      onTap: () => addAddressSheet(),
      child: Container(
        alignment: AlignmentGeometry.center,
        width: MediaQuery.widthOf(context),
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: mainColor, size: 25),
            SizedBox(width: 20),
            Text(
              "배송지 추가",
              style: TextStyle(
                fontSize: 18,
                color: mainColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addAddressSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, set) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerBar(),
                Text(
                  "배송지 추가",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "주소",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(" *", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(height: 4),
                TextFormField(
                  key: Keys.step26_address,
                  controller: address_controller,
                  decoration: InputDecoration(
                    border: border,
                    disabledBorder: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    hint: Text(
                      "예) 서울시 강남구 테헤란로 123",
                      style: TextStyle(color: subColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "상세주소",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                SizedBox(height: 4),
                TextFormField(
                  controller: addressDetail_controller,
                  decoration: InputDecoration(
                    border: border,
                    disabledBorder: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    hint: Text(
                      "동 · 호수를 입력하세요 (최대 50자)",
                      style: TextStyle(color: subColor),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Wrap(
                  spacing: 10,
                  children: List.generate(addressController.labelCodes.length, (
                    index,
                  ) {
                    final label = addressController.labelTexts[index];
                    final select =
                        label == addressController.labelTexts[selectIndex];

                    return GestureDetector(
                      onTap: () => set(() => selectIndex = index),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: select ? mainColor : subColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            color: select ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 24),
                GestureDetector(
                  key: Keys.step26_add,
                  onTap: () async {
                    if (address_controller.text.isEmpty) {
                      showMessage("주소를 입력해주세요.");
                      return;
                    }
                    if (addressDetail_controller.text.length > 50) {
                      showMessage("50자 까지만 입력 할 수 있습니다.");
                      return;
                    }
                    await addressController.add(
                      addressText: address_controller.text,
                      addressDetailText: addressDetail_controller.text,
                      labelText: addressController.labelCodes[selectIndex],
                    );
                    await load();
                    Navigator.pop(context);
                    if (testMode) Navigator.pop(context);
                  },
                  child: Container(
                    alignment: AlignmentGeometry.center,
                    width: MediaQuery.widthOf(context),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "저장",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
