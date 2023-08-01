import 'package:flutter_covy/controller/application_controller.dart';
import 'package:flutter_covy/controller/main_controller.dart';
import 'package:get/get.dart';


class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}
