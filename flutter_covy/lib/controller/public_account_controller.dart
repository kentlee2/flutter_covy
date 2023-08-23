import 'package:get/get.dart';

import '../api.dart';
import '../model/account_detail.dart';
import '../model/public_account.dart';
import '../net/request_client.dart';

class PublicAccountController extends GetxController {
  List<Datum> mDatas = [];
  List<DataElement> datas = [];
  //获取公众号tab
  void requestTabs() async {
    var resp = await requestClient.get<PublicAccount>(Api.publicAccount);
    mDatas = resp!.data;
    update();
  }

  void requestTabDetail(String id, int page) async {
    var resp = await requestClient
        .get<AccountDetail>("${Api.publicAccountDetail}$id/$page/json");
    if (page == 1) {
      datas = resp!.data.datas;
    } else {
      datas.addAll(resp!.data.datas);
    }
    update();
  }
}
