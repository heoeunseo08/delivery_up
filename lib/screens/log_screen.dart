import 'package:delivery_up/controller/order_controller.dart';
import 'package:delivery_up/model/order_model.dart';
import 'package:delivery_up/model/store_detail_model.dart';
import 'package:flutter/material.dart';

import '../utils/info.dart';
import '../utils/widget.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  OrderController orderController = OrderController();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await orderController.getOrderList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "주문내역",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: !isLogin
          ? Center(child: Text("home"))
          : orderController.isLoading
          ? loadingWidget()
          : Column(
              children: List.generate(orderController.ordersList.length, (index) {
                final model = orderController.ordersList[index];
                return card(model);
              },),
            ),
    );
  }

  Widget card(OrderModel model) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: subColor, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.storeName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  "배달완료",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${model.summary} - ${model.orderedAt}",
            style: TextStyle(color: subColor),

          ),
        ],
      ),
    );
  }
}
