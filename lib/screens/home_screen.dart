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

  String get currentSortText =>
      sortText[sortCode.indexOf(storeController.sort)];

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: subColor.withOpacity(0.2)),
        ),
        filled: true,
        fillColor: subColor.withOpacity(0.2),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99),
              ),
              selectedColor: mainColor,
              backgroundColor: subColor.withOpacity(0.1),
              showCheckmark: false,
              selected: select,
              label: Text(
                categoryText[index],
                style: TextStyle(
                  color: select ? Colors.white : Colors.black,
                ),
              ),
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
    return ValueListenableBuilder(
      valueListenable: storeController.sortNotifier,
      builder: (context, value, child) {
        final filterText = storeController.category.isEmpty
            ? "필터"
            : "${storeController.category.length}개 선택됨";
        return InkWell(
          onTap: showSort,
          child: Row(
            children: [
              Icon(Icons.article_outlined, color: subColor, size: 20),
              SizedBox(width: 10),
              Text(
                "$currentSortText · ",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                filterText,
                style: TextStyle(
                  color: storeController.category.isEmpty
                      ? Colors.black
                      : mainColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showSort() async {
    String tempSort = storeController.sort;

    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, set) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: MediaQuery.widthOf(context)),
                  SizedBox(height: 20),
                  header(),
                  titleText("정렬"),
                  SizedBox(height: 8),
                  ...List.generate(
                    sortText.length,
                    (index) {
                      return RadioListTile(
                        activeColor: mainColor,
                        title: Text(sortText[index]),
                        groupValue: tempSort,
                        value: sortCode[index],
                        onChanged: (value) => set(() => tempSort = value!),
                      );
                    },
                  ),
                SizedBox(height: 20),
                  buttons(context: context, text: "적용하기", onTap: () async{
                    if(tempSort == storeController.sort){
                      Navigator.pop(context);
                      return;
                    }
                    storeController.sort = tempSort;
                    await storeController.loadList();
                     Navigator.pop(context);
                     setState(() {

                     });
                  }),
                SizedBox(height: 50)
                ],
              ),
            );
          },
        ),
    );
  }

  Widget cards() {
    return Container();
  }
}
