import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:common_utils/common_utils.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';
import '../routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var page = 0;
  final logic = Get.find<MainController>();

  @override
  void initState() {
    super.initState();
    logic.requestBanner();
    logic.requestArticleList(page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("玩flutter"),
      ),
      body: EasyRefresh(
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        controller: logic.controller,
        onRefresh: () async {
          loadData();
        },
        onLoad: () async {
          loadMore();
        },
        child: GetBuilder<MainController>(
          builder: (controller) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: logic.stateBanner.isEmpty
                        ? Container()
                        : Container(
                            alignment: Alignment.topCenter,
                            height: 200,
                            child: Swiper(
                              itemBuilder: (context, i) {
                                return CachedNetworkImage(
                                    imageUrl:
                                        logic.stateBanner[i].imagePath ?? "");
                              },
                              itemCount: logic.stateBanner.length,
                              indicatorLayout: PageIndicatorLayout.SCALE,
                              autoplay: true,
                              autoplayDelay: 1000,
                              pagination: const SwiperPagination(),
                              fade: 1.0,
                              viewportFraction: 0.85,
                            ))),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: logic.stateArticle.length,
                        (BuildContext context, int index) {
                  var article = logic.stateArticle[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.web,
                          parameters: {"link":logic.stateArticle[index].link,"title":article.title});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 15, bottom: 10, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              logic.stateArticle[index].fresh
                                  ? Container(
                                      //设置 child 居中
                                      alignment: const Alignment(0, 0),
                                      height: 18,
                                      width: 32,
                                      margin: const EdgeInsets.only(right: 5),
                                      //边框设置
                                      decoration: BoxDecoration(
                                        //背景
                                        color: Colors.white,
                                        //设置四周圆角 角度
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0)),
                                        //设置四周边框
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.redAccent),
                                      ),
                                      child: const Text("新",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.redAccent)),
                                    )
                                  : Container(),
                              Expanded(
                                child: Text(
                                  logic.stateArticle[index].title,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(article.shareUser.isNotEmpty
                                  ? "分享人：${article.shareUser}"
                                  : "作者：${article.author}"),
                              const SizedBox(width: 20,),
                              Text("时间：${article.niceDate}")
                            ],
                          ),
                          const SizedBox(height: 10,),
                          const Divider(height: 1,)
                        ],

                      ),
                    ),
                  );
                }))
              ],
            );
          },
        ),
      ),
      // body: Container(
      //   alignment: Alignment.topCenter,
      //   height: 200,
      //   child: FutureBuilder<List<BannerEntity>?>(
      //     future: MainController.requestBanner4(),
      //     builder: (BuildContext context,
      //         AsyncSnapshot<List<BannerEntity>?> snapshot) {
      //       if (snapshot.hasData) {
      //         return Swiper(
      //           itemBuilder: (context, i) {
      //             return CachedNetworkImage(
      //                 imageUrl: snapshot.data?[i].imagePath ?? "");
      //           },
      //           itemCount: snapshot.data!.length,
      //           autoplay: true,
      //         );
      //       }
      //       return const CircularProgressIndicator();
      //     },
      //   ),
      // )

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  loadData() {
    page = 0;
    LogUtil.e("刷新");
    logic.requestBanner();
    logic.requestArticleList(page: page);
  }

  loadMore() {
    page++;
    LogUtil.e("加载");
    logic.requestArticleList(page: page);
  }
}
