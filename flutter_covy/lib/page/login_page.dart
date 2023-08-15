import 'package:flutter/material.dart';
import 'package:flutter_covy/controller/Login_controller.dart';
import 'package:flutter_covy/widget/common_appbar.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final logic = Get.find<LoginController>();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(title: "登录"),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: const InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person),
                ),
                // 校验用户名
                validator: (v) {
                  return v!.trim().isNotEmpty ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                autofocus: true,
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "密码",
                  hintText: "请输入8位数密码",
                  icon: Icon(Icons.lock),
                ),
                // 校验用户名
                validator: (v) {
                  return v!.trim().isNotEmpty ? null : "用户名不能为空";
                },
              ),
              Obx(() {
                if(logic.isLogin.value){
                  Get.back();
                }
                return Padding(
                  padding: const EdgeInsets.all(25),
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          //验证通过提交数据
                          login(_unameController.text.toString(),
                              _passwordController.text.toString());
                        }
                      },
                      child: const Text("登录"),
                    ),
                  ),
                );
              })
            ],
          ),
        )
    );
  }

  void login(String username, String password) async {
    logic.requestLogin(username, password);
  }

}

