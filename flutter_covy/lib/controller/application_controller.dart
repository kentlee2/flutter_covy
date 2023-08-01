import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_covy/api.dart';
import 'package:flutter_covy/model/Project_list_entity.dart';
import 'package:flutter_covy/model/category_list_entity.dart';
import 'package:flutter_covy/net/request_client.dart';
import 'package:get/get.dart';

/// 处理网络数据请求
class ApplicationController extends GetxController {
  var page = 0;

  List<DataElement> projectList = [];
  List<Datum> categoryList = [];
  final EasyRefreshController _controller = EasyRefreshController(
      controlFinishLoad: true, controlFinishRefresh: true);

  get controller => _controller;

  @override
  void onReady() {
    super.onReady();

  }

  //项目列表
  void requestProjectList({required int page, required String id}) async {
    this.page = page;
    var response = await requestClient
        .get<ProjectListEntity>("${Api.projectList}$page/json?cid=$id");
    var resp = response?.data;
    if (page == 0) {
      projectList = resp!.datas;
    } else {
      projectList.addAll(resp!.datas);
    }
    update();
    _controller.finishLoad();
  }
  //项目列表
  Future<List<DataElement>> requestProjectList2({required int page, required String id}) async {
     List<DataElement> projectList=[];
    this.page = page;
    var response = await requestClient
        .get<ProjectListEntity>("${Api.projectList}$page/json?cid=$id");
    var resp = response?.data;
    if (page == 0) {
      projectList = resp!.datas;
    } else {
      projectList.addAll(resp!.datas);
    }
    return projectList;
  }
  //项目分类
  void requestCategory({required int page}) async {
    this.page = page;
    var response =
        await requestClient.get<CategoryListEntity>(Api.categoryList);
    var resp = response?.data;
    if (page == 0) {
      categoryList = resp!;
    } else {
      categoryList.addAll(resp!);
    }

    update();
    _controller.finishLoad();
  }
}
