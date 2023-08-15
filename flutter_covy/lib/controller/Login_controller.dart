import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_covy/api.dart';
import 'package:flutter_covy/net/request_client.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../model/base_entity.dart';
import '../routes.dart';

class LoginController extends GetxController {
  var isLogin = false.obs;

  void requestLogin(String username, String password) async {
    var resp = await requestClient.post<BaseEntity>(Api.login,
        queryParameters: {"username": username, "password": password});
    if (resp?.data != null) {
      isLogin.value = true;
    } else {
      isLogin.value = false;
    }
    update();
  }
}
