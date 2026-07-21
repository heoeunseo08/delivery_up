import 'dart:io';

import 'package:delivery_up_test4/controller/image_controller.dart';
import 'package:delivery_up_test4/controller/method_controller.dart';
import 'package:delivery_up_test4/controller/order_controller.dart';
import 'package:delivery_up_test4/controller/review_controller.dart';
import 'package:delivery_up_test4/model/order_model.dart';
import 'package:delivery_up_test4/utils/info.dart';
import 'package:delivery_up_test4/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  OrderController orderController = OrderController();
  ReviewController reviewController = ReviewController();
  ImageController imageController = ImageController();
  TextEditingController reviewTextController = TextEditingController();

  @override
  void dispose() {
    reviewTextController.dispose();
    super.dispose();
  }

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
                    return card(model, isFirst: index == 0);
                  },
                ),
              ),
            ),
    );
  }

  Widget card(OrderModel model, {bool isFirst = false}) {
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
              GestureDetector(
                key: isFirst ? Keys.step20 : null,
                onTap: () async {
                  await showReviewSheet(model);
                  setState(() {});
                },
                child: Container(
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
                    model.reviewed ? "작성 완료" : "리뷰 작성",
                    style: TextStyle(
                      color: model.reviewed
                          ? subColor.withOpacity(0.3)
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showReviewSheet(OrderModel model) async {
    imageController.reviewPath = null;
    int rating = 0;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, set) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerBar(),
                  Text(
                    "리뷰 작성",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                  ),
                  SizedBox(height: 6),
                  Text(
                    model.storeName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: subColor,
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    children: [
                      Text(
                        "별점",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (index) => GestureDetector(
                        key: index == 4 ? Keys.step22_star : null,
                        onTap: () => set(() => rating = index + 1),
                        child: Icon(
                          Icons.star,
                          color: index < rating ? mainColor : Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "사진 첨부",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  GestureDetector(
                    key: Keys.step21,
                    onTap: () async {
                      await imageController.reviewPick(ImageSource.gallery);
                      set(() {});
                    },
                    child: imageController.reviewPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.file(
                              File(imageController.reviewPath!),
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: subColor.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.square,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                  ),

                  Text(
                    "리뷰 내용",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    key: Keys.step22_review,
                    controller: reviewTextController,
                    decoration: InputDecoration(
                      border: border,
                      disabledBorder: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      hint: Text(
                        "맛과 배달에 대한 후기를 남겨주세요 (최대 300자)",
                        style: TextStyle(color: subColor, fontSize: 16),
                      ),
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  GestureDetector(
                    key: Keys.step22_add,
                    onTap: () async {
                      if (rating == 0) {
                        showMessage("별점은 1정이상 입력해주세요");
                        return;
                      }
                      if (reviewTextController.text.length > 300) {
                        showMessage("300자 까지만 입력할 수 있습니다.");
                        return;
                      }
                      await reviewController.review(
                        orderId: model.orderId,
                        rating: rating,
                        content: reviewTextController.text.trim(),
                      );
                      if (imageController.reviewPath != null) {
                        await reviewController.reviewImage(
                          reviewController.reviewId!,
                          File(imageController.reviewPath!),
                        );
                      }
                      await load();
                      Navigator.pop(context);
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
                        "등록",
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
        );
      },
    );
  }
}
