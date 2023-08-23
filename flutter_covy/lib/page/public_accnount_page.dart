import 'package:flutter/material.dart';
import 'package:flutter_covy/controller/public_account_controller.dart';
import 'package:flutter_covy/widget/KeepAliveWrapper.dart';
import 'package:flutter_covy/widget/public_account_list.dart';
import 'package:get/get.dart';

/// 公众号
class PublicAccountPage extends StatefulWidget {
  const PublicAccountPage({super.key});

  @override
  State<PublicAccountPage> createState() => _PublicAccountPageState();
}

class _PublicAccountPageState extends State<PublicAccountPage> {
  int currentItem = 0;
  late PublicAccountController logic;
  @override
  void initState() {
    super.initState();
    Get.put(PublicAccountController());
    logic = Get.find<PublicAccountController>();
    logic.requestTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("公众号"),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 100,
            child: GetBuilder<PublicAccountController>(
              builder: (controller) {
                return ListView.separated(
                  itemCount: logic.mDatas.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentItem = i;
                        });
                      },
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 3, right: 3, top: 20, bottom: 20),
                            child: Center(child: Text(logic.mDatas[i].name))),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 0.5,
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: logic.mDatas.isEmpty
                  ? Container()
                  : KeepAliveWrapper(
                      child: PublicAccountListWidget(
                          id: logic.mDatas[currentItem].id)))
        ],
      ),
    );
  }
}
