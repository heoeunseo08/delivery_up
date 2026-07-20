import 'package:delivery_up_test4/controller/order_controller.dart';
import 'package:delivery_up_test4/model/order_model.dart';
import 'package:delivery_up_test4/utils/info.dart';
import 'package:delivery_up_test4/utils/widget.dart';
import 'package:flutter/material.dart';

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
    await orderController.loadOrderList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "주문 내역",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: orderController.isLoading
          ? loading()
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  orderController.models.length,
                  (index) {
                    final model = orderController.models[index];
                    return card(model);
                  },
                ),
              ),
            ),
    );
  }

  Widget card(OrderModel model) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: subColor.withOpacity(0.1), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: MediaQuery.widthOf(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.storeName,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              Text(
                model.status,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            "${model.summary} · ${model.orderedAt}",
            style: TextStyle(color: subColor, fontSize: 15),
          ),
          SizedBox(height: 4),
          Text(
            "결제금액 ${model.totalPrice}원",
            style: TextStyle(color: subColor, fontSize: 15),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor, width: 1.5),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  "재주문",
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: model.reviewed
                        ? subColor.withOpacity(0.3)
                        : Colors.white,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(99),
                  color: model.reviewed ? Colors.white : mainColor,
                ),
                child: Text(
                  "리뷰작성",
                  style: TextStyle(
                    color: model.reviewed
                        ? subColor.withOpacity(0.3)
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showReviewSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [

          ],
        );
      },
    );
  }
}
