import 'package:delivery_up/controller/store_controller.dart';
import 'package:delivery_up/utils/info.dart';
import 'package:delivery_up/utils/widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController keywordController = TextEditingController();
  StoreController storeController = StoreController();

  final sortText = ["기본순", "별점 높은순", "최소주문금액 낮은순", "배달팁 낮은순"];
  final sortCode = ["DEFAULT", "RATING", "MIN_ORDER", "DELIVERY_FEE"];
  final categoryText = ["전체", '치킨', '분식', '카페', '한식'];
  final categoryCode = [null, 'CHICKEN', 'BUNSIK', 'CAFE', 'KOREAN'];

  @override
  void initState() {
    super.initState();
    if (isLogin) load();
  }

  Future<void> load() async {
    await storeController.loadList();
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
            Icon(Icons.location_on_outlined, color: subColor, size: 35),
            Text(
              "서울시 강남구",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 16),
            Icon(Icons.arrow_forward_ios, size: 25, color: subColor),
          ],
        ),
      ),
      body: !isLogin
          ? Center(child: Text("home"))
          : storeController.isListLoading
          ? loadingWidget()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    fieldWidget(),
                    SizedBox(height: 30),
                    categoryWidget(),
                    SizedBox(height: 30),
                    sortWidget(),
                    SizedBox(height: 30),
                    cards(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }

  Widget fieldWidget() {
    return TextField(
      controller: keywordController,
      onSubmitted: (value) async {
        storeController.keyword = keywordController.text.trim();
        await storeController.loadList();
        setState(() {});
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: subColor.withOpacity(0.3),
        prefixIcon: Icon(Icons.search, size: 30, color: subColor),
        hint: hintTexts("가게·메뉴를 검색해보세요"),
      ),
    );
  }

  Widget categoryWidget() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryText.length,
        itemBuilder: (context, index) {
          final code = categoryCode[index];
          final select = code == null
              ? storeController.category.isEmpty
              : storeController.category.contains(code);

          return Padding(
            padding: EdgeInsets.only(left: 8),
            child: FilterChip(
              selected: select,
              label: Text(categoryText[index]),
              onSelected: (value) async {
                if (code == null) {
                  storeController.category.clear();
                } else if (value) {
                  storeController.category.add(code);
                } else {
                  storeController.category.remove(code);
                }
                await storeController.loadList();
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }

  Widget sortWidget() {
    return SizedBox(
      width: 40,
    );
  }

  Widget cards() {
    return Container();
  }
}
