import 'package:delivery_up/model/store_detail_model.dart';
import 'package:delivery_up/model/store_list_model.dart';

class StoreController {
  String? error;
  bool isListLoading = false;
  bool isDetailLoading = false;
  List<StoreListModel>? storeListModel;
  StoreDetailModel? detailModel;

  Future<void> listLoad() async {
    isListLoading = true;
    error = null;

    try{

    }catch(e){
      print("네트워크 오류: $e");
    }
    isListLoading = false;
  }
}
