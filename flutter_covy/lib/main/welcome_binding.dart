import 'package:get/get.dart';

import '../controller/count_controller.dart';


class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountController());
  }
}
