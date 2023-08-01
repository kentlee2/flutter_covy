import 'package:flutter_covy/page/web_page.dart';
import 'package:flutter_covy/page/welcome_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'binding/main_binding.dart';
import 'binding/welcome_binding.dart';
import 'page/main_page.dart';

class Routes {
  static const String welcome = "/";
  static const String main = "/main";
  static const String web = "/web";
  static const String application = "/application";
  static const String category = "/project/tree/json";

  // static final String loading = "/loading";


  static  List<GetPage> pages=[
    GetPage(name: welcome, binding: WelcomeBinding(), page: () =>  const WelcomePage()),
    GetPage(name: main, binding: MainBinding(), page: () =>  const MainPage()),
    GetPage(name: web,  page: () =>  const WebPage()),
  ];

}





