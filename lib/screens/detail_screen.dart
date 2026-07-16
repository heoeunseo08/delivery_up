import 'package:delivery_up/controller/store_controller.dart';
import 'package:delivery_up/model/store_detail_model.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:delivery_up/utils/widget.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.storeId});

  final int storeId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  StoreController storeController = StoreController();
  ValueNotifier<int> totalPrice = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await storeController.loadList();
    await storeController.loadDetail(widget.storeId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: storeController.isDetailLoading
          ? loadingWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [titleWidget()],
                    ),
                  ),
                  cartButton(),
                ],
              ),
            ),
    );
  }

  AppBar appBar() => AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    leading: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(Icons.arrow_back_ios_new, size: 30),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          storeController.isDetailLoading || storeController.isListLoading
              ? ""
              : storeController.detailModel!.name,
        ),
        GestureDetector(
          onTap: () async {
            await storeController.setHeart(widget.storeId);
            setState(() {});
          },
          child: Icon(
            storeController.detailModel?.favorite == true
                ? Icons.favorite
                : Icons.favorite_border,
            size: 25,
          ),
        ),
      ],
    ),
  );

  Widget titleWidget() {
    final model = storeController.detailModel;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(14),
            child: Image.network(model!.imageUrl,),
          ),
          SizedBox(height: 20),
          Text(
            model.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.star_purple500_outlined,
                size: 20,
                color: mainColor,
              ),
              Text(
                "${model.rating}",
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "최소 ${model.minOrderPrice}원",
                style: TextStyle(
                  color: subColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
          SizedBox(width: 10),
          Text(
            "배달팁 ${model.deliveryFee}원",
            style: TextStyle(
              color: subColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardWidget(MenusModel model) {

    return GestureDetector(
      onTap:() {

      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: subColor, width: 1.5)),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(14),
              child: Image.network(model.imageUrl, width: 100, height: 75),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star_purple500_outlined,
                        size: 20,
                        color: mainColor,
                      ),
                      Text(
                        "${model.rating}",
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "최소 ${model.minOrderPrice}원",
                        style: TextStyle(
                          color: subColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "배달 ${model.deliveryFee}원",
                    style: TextStyle(
                      color: subColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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

  Widget cartButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 30),
        width: MediaQuery.widthOf(context),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, color: Colors.white, size: 30),
            ValueListenableBuilder(
              valueListenable: totalPrice,
              builder: (context, value, child) {
                return Text(
                  "장바구니 보기 · ${totalPrice.value}원",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
