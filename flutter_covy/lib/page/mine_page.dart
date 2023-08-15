import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covy/routes.dart';
import 'package:flutter_covy/widget/sliver_flexible_header.dart';
import 'package:get/get.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverFlexibleHeader(
            visibleExtent: 250,
            builder: (context, availableHeight, direction) {
              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://img-qn.51miz.com/preview/element/00/01/11/44/E-1114426-586DEA2C.jpg!/quality/90/unsharp/true/compress/true/format/jpg/fw/300",
                    width: MediaQuery.of(context).size.width,
                    height: availableHeight,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 30,
                    top: 70,
                    child: Image.asset(
                      "assets/images/default_avatar.webp",
                      width: 65,
                      height: 65,
                    ),
                  ),
                  Positioned(
                    left: 120,
                    top: 85,
                    child: GestureDetector(
                      child: const Text(
                        "登录/注册",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.login);
                      },
                    ),
                  ),
                ],
              );
            }),
        SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return Center(child: Text(index.toString()));
            })
      ],
    );
  }
}
