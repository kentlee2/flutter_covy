import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_covy/page/mine_page.dart';
import 'package:get/get.dart';
import 'application_page.dart';
import 'bisiness_page.dart';
import 'home_page.dart';
import 'public_accnount_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late List<Widget> pages = [const MyHomePage(),const ApplicationPage(),const PublicAccountPage(),const MinePage()];
  var _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    try{
      if(Platform.isAndroid){
        SystemUiOverlayStyle style = const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            ///这是设置状态栏的图标和字体的颜色
            ///Brightness.light  一般都是显示为白色
            ///Brightness.dark 一般都是显示为黑色
            statusBarIconBrightness: Brightness.light
        );
        SystemChrome.setSystemUIOverlayStyle(style);
      }
    }catch(e){
      e.printError(info: e.toString());
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index){
          print("当前的页面是 $index");
        },
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.window),
            label: '项目',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: '公众号',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: '我的',
          ),
        ],
      ),
    );

  }
  _navigationPageChanged(index) {
    // if (_currentIndex == index) {
    //   return;
    // }
    _currentIndex = index;
    _pageController.jumpToPage(_currentIndex);
  }

}
