import 'package:flutter/material.dart';
import 'package:flutter_covy/model/category_list_entity.dart';

import 'KeepAliveWrapper.dart';
import 'ProjectListWidget.dart';

class CovyTabBarWidget extends StatefulWidget {
  const CovyTabBarWidget({super.key, this.tabItems});

  final List<Datum>? tabItems;

  @override
  State<CovyTabBarWidget> createState() => _State();
}

class _State extends State<CovyTabBarWidget> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.tabItems!.length, vsync: this);
  }

  void _onTabTapped(int index) {
    // logic.requestProjectList(page: 1, id: widget.tabItems[index].key)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("项目"),
        bottom: TabBar(
          tabs: widget.tabItems!
              .map((e) => Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(e.name),
                  ))
              .toList(),
          controller: _tabController,
          isScrollable: true,
          onTap: (index) {
            _tabController?.animateTo(_tabController!.index,
                duration: const Duration(), curve: Curves.easeIn);
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.tabItems!.map((e) {
          return KeepAliveWrapper(
              child: ProjectListWidget(id: e.id.toString()));
        }).toList(),
      ),
    );
  }
}
