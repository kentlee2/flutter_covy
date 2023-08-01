import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_covy/api.dart';
import 'package:flutter_covy/model/article_list_entity.dart';
import 'package:flutter_covy/model/banner_entity.dart';
import 'package:flutter_covy/net/request_client.dart';
import 'package:get/get.dart';

/// 处理网络数据请求
class MainController extends GetxController {
  List<BannerListEntity> stateBanner = [];
  List<DataElement> stateArticle = [];
  var imageUrl = "".obs;

  // List<BannerData> get getList => mList;
  final EasyRefreshController _controller = EasyRefreshController(
      controlFinishLoad: true, controlFinishRefresh: true);

  var page = 0;

  get controller => _controller;

  //getX
  void requestBanner() async {
    var response = await requestClient.get<BannerEntity>(Api.banner);
    var resp = response?.data;
    stateBanner = response!.data;
    update();
    _controller.finishRefresh();
  }

  //Dio封装 FutureBuilder
  static Future<List<BannerListEntity>> requestBanner2() async {
    var response = await requestClient.get<BannerEntity>(Api.banner);
    return response!.data;
  }

  void requestArticleList({required int page}) async {
    this.page = page;
    var response = await requestClient
        .get<ArticleListEntity>("${Api.articleList}$page/json");
    var resp = response?.data;
    if (page == 0) {
      stateArticle = resp!.datas;
    } else {
      stateArticle.addAll(resp!.datas);
    }
    update();
    _controller.finishLoad();
  }

  Future<String?> loadData(String base64Url) async {
    var response = await requestClient.get<String>(base64Url);
    imageUrl.value = response ?? "";
    return response;
  }
}
