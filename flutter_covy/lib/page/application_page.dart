import 'package:common_utils/common_utils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covy/controller/application_controller.dart';
import 'package:flutter_covy/widget/covy_tabbar_widget.dart';
import 'package:get/get.dart';

import '../model/category_list_entity.dart';
import '../widget/KeepAliveWrapper.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  var page = 0;
  List<Datum> tabs = [];
  late ApplicationController logic;

  @override
  void initState() {
    super.initState();
    Get.put(ApplicationController());
    logic = Get.find<ApplicationController>();
    logic.requestCategory(page: page);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(builder: (logic) {
      return logic.categoryList.isEmpty
          ? Container()
          : CovyTabBarWidget(tabItems: logic.categoryList);
    });
  }

  loadData(bool isRefresh) async {
    if (isRefresh) {
      page = 0;
    } else {
      page++;
    }
    LogUtil.e("刷新");
    // logic.requestProjectList(page: page);
  }
}
