import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/application_controller.dart';
import '../model/Project_list_entity.dart';

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
      builder: (BuildContext context, AsyncSnapshot<List<DataElement>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          } else {
            // 请求成功，显示数据
            var projectList =snapshot.data;
            return  ListView.separated(
              itemCount: projectList!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = projectList[index];
                return Column(
                  children: [
                    Text(data.title),
                    Text(data.desc),
                    Text(data.niceDate),
                  ],
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
