
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../routes.dart';



class CountController extends GetxController {

  var _countdownTime = 1;

  Timer?   _timer;

  int get countdownTime => _countdownTime;

  bool? isStart(){
    if(_timer==null){
      return false;
    }else{
      return _timer?.isActive;
    }
  }
  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownTime > 0) {
        _countdownTime=_countdownTime-1;
        if (kDebugMode) {
          print(countdownTime);
        }
        update();
      } else {
        stopCountdown();
        Get.offNamed(Routes.main);
      }
    });

  }

  void stopCountdown() {
    _timer?.cancel();
  }

  @override
  void onClose() {
    stopCountdown();
    super.onClose();
  }
}
