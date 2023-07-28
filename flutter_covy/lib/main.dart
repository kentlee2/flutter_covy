
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_covy/routes.dart';
import 'package:get/get.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, //强制竖屏
      DeviceOrientation.portraitDown
    ]);
    return GetMaterialApp(
      initialRoute: Routes.welcome,
      getPages: Routes.pages,
      enableLog: true,
    );
  }
}
