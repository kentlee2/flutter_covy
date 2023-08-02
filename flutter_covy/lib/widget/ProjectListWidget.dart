import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/application_controller.dart';
import '../model/Project_list_entity.dart';
import '../routes.dart';

class ProjectListWidget extends StatefulWidget {
  const ProjectListWidget({super.key, this.id});

  final String? id;

  @override
  State<ProjectListWidget> createState() => _ProjectListWidgetState();
}

class _ProjectListWidgetState extends State<ProjectListWidget> {
  var logic = Get.find<ApplicationController>();
  var page = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: logic.requestProjectList2(page: page, id: widget.id.toString()),
      builder:
          (BuildContext context, AsyncSnapshot<List<DataElement>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          } else {
            // 请求成功，显示数据
            var projectList = snapshot.data;
            return ListView.separated(
              itemCount: projectList!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = projectList[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.web,
                        parameters: {"link":projectList[index].link,"title":projectList[index].title});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.title,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(data.desc),
                              Text(data.niceDate),
                            ],
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl: projectList[index].envelopePic,
                          width: 80,
                          height: 110,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                );
              },
            );
          }
        } else {
          // 请求未结束，显示loading
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
