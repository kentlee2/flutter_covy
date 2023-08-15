import 'package:flutter_covy/controller/application_controller.dart';
import 'package:flutter_covy/controller/main_controller.dart';
import 'package:get/get.dart';

import '../controller/Login_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
