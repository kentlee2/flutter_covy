import 'package:flutter/material.dart';
import 'bisiness_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final List<Widget> pages = [const MyHomePage(), const BusinessPage()];
  var _currentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            // 图标
            icon: Icon(Icons.home),
            // 文字内容
            label: '首页',
          ),
          BottomNavigationBarItem(
            // 图标
            icon: Icon(Icons.face),
            // 文字内容
            label: '我的',
          ),
        ],
      ),
    );
  }

  Widget buildBodyFunction() {
    ///帧布局结合透明布局
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: _currentIndex == 0 ? 1 : 0,
          child: const MyHomePage(),
        ),
        Opacity(
          opacity: _currentIndex == 1 ? 1 : 0,
          child: const BusinessPage(),
        ),
      ],
    );
  }
}
