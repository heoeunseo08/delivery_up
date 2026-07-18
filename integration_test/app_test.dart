import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:delivery_up/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:delivery_up/utils/info.dart';

Future<void> wait(WidgetTester tester) async {
  for (int i = 5; i > 0; i--) {
    print('$i초');
    await tester.pump(const Duration(seconds: 1));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('test', () {
    testWidgets('Module C 통합 테스트 (STEP 20~22 리뷰 작성 제외)', (tester) async {
      print('[STEP No.1] 애플리케이션 실행');
      app.main();
      await wait(tester);

      print('[STEP No.2] 하단 네비게이션의 "프로필" 탭 클릭');
      await tester.tap(find.byKey(const Key(Keys.tab_profile)));
      await wait(tester);

      print('[STEP No.3] "로그인" 버튼 클릭');
      await tester.tap(find.byKey(const Key(Keys.button_login)));
      await wait(tester);

      print('[STEP No.4] 정상 값으로 로그인 시도');
      await tester.enterText(find.byKey(const Key(Keys.login_email)), 'user001@mad.co.kr');
      await tester.enterText(find.byKey(const Key(Keys.login_password)), 'Mobile001!');
      await tester.tap(find.byKey(const Key(Keys.try_login)));
      await wait(tester);

      print('[STEP No.5] 하단 네비게이션의 "홈" 탭 클릭');
      await tester.tap(find.byKey(const Key(Keys.tab_home)));
      await wait(tester);

      print('[STEP No.6] 카테고리 필터 "치킨" 선택');
      await tester.tap(find.byKey(const Key(Keys.tab_chicken)));
      await wait(tester);

      print('[STEP No.7] 카테고리 필터 "분식" 추가 선택(중복 선택)');
      await tester.tap(find.byKey(const Key(Keys.tab_snack)));
      await wait(tester);

      print('[STEP No.8] 정렬 "별점 높은순" 선택');
      await tester.tap(find.byKey(const Key(Keys.sort_open)));
      await tester.pump();
      await tester.tap(find.byKey(const Key(Keys.tab_star)));
      await tester.tap(find.byKey(const Key(Keys.sort_apply)));
      await wait(tester);

      print('[STEP No.9] 첫 번째 가게 카드 클릭');
      await tester.tap(find.byKey(const Key(Keys.tab_frist_card)));
      await wait(tester);

      print('[STEP No.10] 찜(하트) 아이콘 클릭 (등록)');
      await tester.tap(find.byKey(const Key(Keys.tab_heart_on)));
      await wait(tester);

      print('[STEP No.11] 찜(하트) 아이콘 재클릭 (해제)');
      await tester.tap(find.byKey(const Key(Keys.tab_heart_on)));
      await wait(tester);

      print('[STEP No.12] 찜(하트) 아이콘 클릭 (재등록)');
      await tester.tap(find.byKey(const Key(Keys.tab_heart_on)));
      await wait(tester);

      print('[STEP No.13] 메뉴 클릭 (후라이드 치킨)');
      await tester.tap(find.byKey(const Key(Keys.tab_menu)));
      await wait(tester);

      print('[STEP No.14] 옵션 선택·수량 2로 변경 후 "담기" 버튼 클릭');
      await tester.tap(find.byType(RadioListTile<int>).first);
      await tester.pump();
      await tester.tap(find.byKey(const Key(Keys.menu_qty_plus)));
      await tester.tap(find.byKey(const Key(Keys.menu_addcart)));
      await wait(tester);

      print('[STEP No.15] 하단 장바구니 이동 버튼 클릭');
      await tester.tap(find.byKey(const Key(Keys.tab_cart)));
      await wait(tester);

      print('[STEP No.16] 수량 "+" 버튼 클릭');
      await tester.tap(find.byKey(const Key(Keys.cart_qty_plus)));
      await wait(tester);

      print('[STEP No.17] 수량 "−" 버튼 클릭');
      await tester.tap(find.byKey(const Key(Keys.cart_qty_minus)));
      await wait(tester);

      print('[STEP No.18] "주문하기" 버튼 클릭');
      await tester.tap(find.byKey(const Key(Keys.cart_order)));
      await wait(tester);

      print('[STEP No.19] 접수된 주문 카드 확인');
      expect(find.textContaining('원'), findsWidgets);
      await wait(tester);

      // [STEP No.20~22] 리뷰 작성 - 아직 미구현이라 생략

      print('[STEP No.23] 하단 네비게이션의 "프로필" 탭 클릭');
      await tester.tap(find.byKey(const Key(Keys.tab_profile)));
      await wait(tester);

      print('[STEP No.24] "배송지 관리" 클릭');
      await tester.tap(find.byKey(const Key(Keys.profile_address)));
      await wait(tester);

      print('[STEP No.25] "배송지 추가" 버튼 클릭');
      await tester.tap(find.byKey(const Key(Keys.address_add)));
      await wait(tester);

      print('[STEP No.26] 주소 입력·라벨 선택 후 "저장" 버튼 클릭');
      await tester.enterText(find.byKey(const Key(Keys.address_text)), '서울시 강남구 테헤란로 123');
      await tester.tap(find.text('회사'));
      await tester.tap(find.byKey(const Key(Keys.address_save)));
      await wait(tester);

      print('[STEP No.27] "로그아웃" 텍스트 버튼 클릭');
      await tester.tap(find.byKey(const Key(Keys.profile_check_logout)));
      await wait(tester);

      print('[STEP No.28] 로그아웃 확인 다이얼로그의 "확인" 버튼 클릭');
      await tester.tap(find.byKey(const Key(Keys.profile_logout)));
      await wait(tester);
    });
  });
}
