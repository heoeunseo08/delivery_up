import 'package:delivery_up_test4/controller/cart_controller.dart';
import 'package:delivery_up_test4/controller/method_controller.dart';
import 'package:delivery_up_test4/controller/store_controller.dart';
import 'package:delivery_up_test4/model/store_detail_model.dart';
import 'package:delivery_up_test4/screen/cart_screen.dart';
import 'package:delivery_up_test4/utils/info.dart';
import 'package:delivery_up_test4/utils/widget.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.storeId});

  final int storeId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  StoreController storeController = StoreController();

  @override
  void initState() {
    super.initState();
    load();

  }

  Future<void> load() async {
    await storeController.loadListStore();
    await storeController.loadDetailStore(widget.storeId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: storeController.isDetailLoading
          ? loading()
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    titleWidget(),
                    Text(
                      "인기 메뉴",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    ...List.generate(
                      storeController.storeDetailModel!.menus.length,
                          (index) => cardWidget(
                        storeController.storeDetailModel!.menus[index],
                        index == 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (cartController.totalPrice > 0) cartButton(),
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
              : storeController.storeDetailModel!.name,
        ),
        GestureDetector(
          // key: Key(Keys.tab_heart_on),
          onTap: () async {
            await storeController.setHeart(widget.storeId);
            setState(() {});
          },
          child: Icon(
            storeController.storeDetailModel?.favorite == true
                ? Icons.favorite
                : Icons.favorite_border,
            size: 25,
          ),
        ),
      ],
    ),
  );

  Widget titleWidget() {
    final model = storeController.storeDetailModel;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(model!.imageUrl),
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

  Widget cardWidget(MenusModel model, [bool isFirst = false]) {
    return GestureDetector(
      // key: isFirst ? Key(Keys.tab_menu) : null,
      onTap: () => checkCart(model),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: subColor, width: 1.5)),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                model.imageUrl,
                width: 85,
                height: 85,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    model.description,
                    style: TextStyle(
                      color: subColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${model.price}원",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
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
      // key: Key(Keys.tab_cart),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartScreen(),
          ),
        );
      },
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
            SizedBox(width: 12),
            Text(
              "장바구니 보기 · ${cartController.totalPrice}원",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkCart(MenusModel model) {
    if (cartController.anotherStore(widget.storeId)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("장바구니 초기화"),
          content: Text("다른 가게의 메뉴를 담으려 할 경우 장바구니 초기화됩니다."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                cartController.clear();
                Navigator.pop(context);
                addCartSheet(model);
              },
              child: Text("확인"),
            ),
          ],
        ),
      );
      return;
    }
    addCartSheet(model);
  }

  void addCartSheet(MenusModel model) {
    final select = {for (final i in model.options) i.group: <int>{}};
    int currentIndex = 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) => StatefulBuilder(
        builder: (context, set) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerBar(),
                Text(model.name,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
                Text(
                  "${model.price}원",
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 16),
                ...model.options.map((e) {
                  if (e.required) {
                    final groupValue = select[e.group]!.isEmpty
                        ? null
                        : select[e.group]!.first;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              e.group,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("*", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        RadioGroup<int>(
                          groupValue: groupValue,
                          onChanged: (value) {
                            set(() => select[e.group] = {value!});
                          },
                          child: Column(
                            children: e.items.map((i) {
                              return RadioListTile<int>(
                                contentPadding: EdgeInsets.zero,
                                activeColor: mainColor,
                                title: Text(
                                  "${i.name}${i.price == 0 ? '' : ' (+${i.price}원)'}",
                                ),
                                value: i.id,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.group,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...e.items.map((i) {
                        final isSelected = select[e.group]!.contains(i.id);
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: mainColor,
                          title: Text(
                            "${i.name}${i.price == 0 ? '' : ' (+${i.price}원)'}",
                          ),
                          value: isSelected,
                          onChanged: (checked) {
                            set(() {
                              if (checked!) {
                                select[e.group]!.add(i.id);
                              } else {
                                select[e.group]!.remove(i.id);
                              }
                            });
                          },
                        );
                      }),
                      SizedBox(height: 8),
                    ],
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "수량",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: mainColor,
                          ),
                          onPressed: () {
                            if (currentIndex > 1) set(() => currentIndex--);
                          },
                        ),
                        Text(
                          "$currentIndex",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          // key: Key(Keys.menu_qty_plus),
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: mainColor,
                          ),
                          onPressed: () => set(() => currentIndex++),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                buttons(
                  // key: Key(Keys.menu_addcart),
                  context: context,
                  text: "담기",
                  onTap: () {
                    final requiredMissing = model.options
                        .where((g) => g.required)
                        .any((g) => select[g.group]!.isEmpty);

                    if (requiredMissing) {
                      showMessage("필수 옵션을 선택해주세요.");
                      return;
                    }

                    int itemPrice = model.price;
                    final optionIds = <int>[];
                    final optionNames = <String>[];

                    for (final group in model.options) {
                      for (final item in group.items) {
                        if (select[group.group]!.contains(item.id)) {
                          itemPrice += item.price;
                          optionIds.add(item.id);
                          optionNames.add(item.name);
                        }
                      }
                    }

                    if (cartController.storeId == null) {
                      cartController.set(
                        storeId: widget.storeId,
                        storeName: storeController.storeDetailModel!.name,
                        minPrice: storeController.storeDetailModel!.minOrderPrice,
                        fee: storeController.storeDetailModel!.deliveryFee,
                      );
                    }

                    cartController.add(
                      CartItem(
                        menuId: model.id,
                        menuName: model.name,
                        imageUrl: model.imageUrl,
                        optionName: optionNames,
                        optionId: optionIds,
                        unitPrice: itemPrice,
                        quantity: currentIndex,
                      ),
                    );

                    Navigator.pop(context);
                    setState(() {});
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