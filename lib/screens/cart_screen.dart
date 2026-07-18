import 'package:delivery_up/controller/address_controller.dart';
import 'package:delivery_up/controller/cart_controller.dart';
import 'package:delivery_up/controller/method_controller.dart';
import 'package:delivery_up/controller/order_controller.dart';
import 'package:delivery_up/screens/log_screen.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, size: 30),
        ),
        title: Text("장바구니"),
      ),
      body: cartController.items.isEmpty
          ? Center(
              child: Text("장바구니가 비었습니다."),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${cartController.storeName}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          ...List.generate(
                            cartController.items.length,
                            (index) => card(cartController.items[index], index),
                          ),
                          totalPriceWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20), child: orderButton()),
              ],
            ),
    );
  }

  Widget card(cartItem item, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.menuName),
                    GestureDetector(
                      onTap: () {
                        cartController.remove(index);
                        setState(() {});
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
                item.optionNames.isNotEmpty
                    ? Text(item.optionNames.join('/'))
                    : Text("기본"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("${item.totalPrice}원"),
                    SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          key: index == 0 ? Key(Keys.cart_qty_minus) : null,
                          onTap: () {
                            cartController.updateUpDown(index, false);
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: mainColor.withOpacity(0.2),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(12),
                              ),
                              border: Border.all(color: subColor, width: 1.5),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: mainColor,
                              size: 25,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10.5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: subColor, width: 1.5),
                            ),
                            child: Text("${item.quantity}"),
                          ),
                        ),
                        GestureDetector(
                          key: index == 0 ? Key(Keys.cart_qty_plus) : null,
                          onTap: () {
                            cartController.updateUpDown(index, true);
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: mainColor.withOpacity(0.2),
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(12),
                              ),
                              border: Border.all(color: subColor, width: 1.5),
                            ),
                            child: Icon(
                              Icons.add,
                              color: mainColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget totalPriceWidget() {
    return Column(
      spacing: 20,
      children: [
        Divider(color: subColor, height: 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("주문금액"), Text("${cartController.itemsTotal}원")],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("배달팁"), Text("${cartController.fee}원")],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("총 결제금액"), Text("${cartController.totalPrice}원")],
        ),
        if (!cartController.canOrder)
          Container(
            width: MediaQuery.widthOf(context),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              textAlign: TextAlign.start,
              "최소주문금액까지 ${cartController.minPrice - cartController.itemsTotal}원 남았어요\n(최소주문금액 ${cartController.minPrice}원)",
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget orderButton() {
    return GestureDetector(
      key: Key(Keys.cart_order),
      onTap: () async {
        AddressController addressController = AddressController();
        await addressController.loadAddress();
        if (!cartController.canOrder) {
          showMessage("최소주문금액을 충족해주세요.");
          return;
        }
        if (addressController.models.isEmpty) {
          showMessage("배송지를 먼저 선택해주세요.");
          return;
        }
        final addressId = addressController.models.firstWhere(
          (element) => element.isDefault,
          orElse: () => addressController.models.first,
        );
        OrderController orderController = OrderController();
        final success = await orderController.order(addressId.id);

        if (!success) {
          showMessage("주문에 실패했습니다.");
          return;
        }

        cartController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LogScreen(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.widthOf(context),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: !cartController.canOrder
              ? subColor.withOpacity(0.2)
              : mainColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "주문하기",
          style: TextStyle(
            color: !cartController.canOrder ? subColor : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
