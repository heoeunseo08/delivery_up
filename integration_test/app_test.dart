import 'package:delivery_up_test4/utils/info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:delivery_up_test4/main.dart';
import 'package:integration_test/integration_test.dart';

Future<void> wait(WidgetTester tester) async {
  for (int i = 5; i > 0; i--) {
    print("$i초");
    await tester.pump(Duration(seconds: 1));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('test', (tester) async {
      testMode = true;

      print("[STEP No.1] 애플리케이션 실행");
      await tester.pumpWidget(const MyApp());
      await wait(tester);

      print('[STEP No.2] 하단 네비게이션의 "프로필" 탭 클릭');
      await tester.tap(find.byKey(Keys.step2));
      await wait(tester);

      print('[STEP No.3] "로그인" 버튼 클릭');
      await tester.tap(find.byKey(Keys.step3));
      await wait(tester);

      print('[STEP No.4] 정상 값으로 로그인 시도');
      await tester.enterText(find.byKey(Keys.step4_email), "user102@mad.co.kr");
      await tester.enterText(find.byKey(Keys.step4_password), "Mobile102!");
      await tester.tap(find.byKey( Keys.step4));
      await wait(tester);

      print('[STEP No.5] 하단 네비게이션의 "홈" 탭 클릭');
      await tester.tap(find.byKey( Keys.step5));
      await wait(tester);

      print('[STEP No.6] 카테고리 필터 "치킨" 선택 ');
      await tester.tap(find.byKey( Keys.step6));
      await wait(tester);

      print('[STEP No.7] 카테고리 필터 "분식" 추가 선택(중복 선택)');
      await tester.tap(find.byKey( Keys.step7));
      await wait(tester);

      print('[STEP No.8] 정렬에서 "별점 높은순" 선택 ');
      await tester.tap(find.byKey( Keys.step8));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey( Keys.step8_star));
      await tester.tap(find.byKey( Keys.step8_sort));
      await wait(tester);

      print('[STEP No.9] 첫 번째 가게 카드 클릭');
      await tester.tap(find.byKey( Keys.step9));
      await wait(tester);

      print('[STEP No.10] 찜(하트) 아이콘 클릭');

      await tester.tap(find.byKey( Keys.step10));
      await wait(tester);

      print('[STEP No.11] 찜(하트) 아이콘 재클릭');

      await tester.tap(find.byKey( Keys.step10));
      await wait(tester);

      print('[STEP No.12] 찜(하트) 아이콘 클릭');
      await tester.tap(find.byKey( Keys.step10));
      await wait(tester);

      print('[STEP No.13] 메뉴 클릭');
      await tester.tap(find.byKey( Keys.step13));
      await wait(tester);

      print('[STEP No.14] 옵션 선택, 수량 2로 변경 후 "담기" 버튼 클릭');
      await tester.tap(find.textContaining("순살"));
      await tester.tap(find.byKey( Keys.step14_up));
      await tester.tap(find.byKey( Keys.step14_add));
      await wait(tester);

      print('[STEP No.15] 하단 장바구니 이동 버튼 클릭');
      await tester.tap(find.byKey( Keys.step15));
      await wait(tester);

      print('[STEP No.16] 수량 "+" 버튼 클릭');
      await tester.tap(find.byKey( Keys.step16));
      await wait(tester);

      print('[STEP No.17] 수량 "-" 버튼 클릭');
      await tester.tap(find.byKey( Keys.step17));
      await wait(tester);

      print('[STEP No.18] "주문하기" 버튼 클릭');
      await tester.tap(find.byKey( Keys.step18));
      await wait(tester);

      print('[STEP No.19] 방금 접수된 주문 카드 확인');
      await wait(tester);

      print('[STEP No.20] "리뷰 작성" 버튼 클릭');
      await tester.tap(find.byKey( Keys.step20));
      await wait(tester);

      print('[STEP No.21] "사진 첨부" 영역 클릭 후 이미지 선택');
      await tester.tap(find.byKey( Keys.step21));
      testMode = true;
      await tester.pump();
      await wait(tester);

      print('[STEP No.22] 별점 선택, 리뷰 내용 입력 후 "등록" 버튼 클릭');
      await tester.tap(find.byKey( Keys.step22_star));
      await tester.enterText(find.byKey( Keys.step22_review),"맛있게 잘 먹었습니다");
      await tester.tap(find.byKey( Keys.step22_add));
      await wait(tester);

      print('[STEP No.23] 하단 네비게이션의 "프로필" 탭 클릭');
      await tester.tap(find.byKey( Keys.step2));
      await wait(tester);

      print('[STEP No.24] "배송지 관리" 클릭');
      await tester.tap(find.byKey( Keys.step24));
      await wait(tester);

      print('[STEP No.25] "배송지 추가" 버튼 클릭');
      await tester.tap(find.byKey( Keys.step25));
      await wait(tester);

      print('[STEP No.26] 주소 입력, 라벨 선택 후 "저장" 버튼 클릭');
      await tester.enterText(find.byKey( Keys.step26_address),"서울시 강남구 테헤란로 123");
      await tester.tap(find.byKey( Keys.step26_add));
      await wait(tester);

      print('[STEP No.27] "로그아웃" 텍스트 버튼 클릭');
      await tester.tap(find.byKey( Keys.step27));
      await wait(tester);

      print('[STEP No.28] 로그아웃 확인 다이얼로그의 "확인" 버튼 클릭');
      await tester.tap(find.byKey( Keys.step28));
      await wait(tester);

      testMode = false;
      });
  });
}

