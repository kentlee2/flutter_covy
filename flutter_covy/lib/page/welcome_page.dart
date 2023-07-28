import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_covy/routes.dart';
import 'package:get/get.dart';

import '../controller/count_controller.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var splashImage =
      "http://p1.itc.cn/images03/20200520/dbe47dc8e6e1487f9278551490a64874.jpeg";
  final CountController verificationController =Get.find();
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    //   systemNavigationBarContrastEnforced: true,
    //   systemStatusBarContrastEnforced: true,
    //   systemNavigationBarColor: Colors.transparent,
    //   systemNavigationBarIconBrightness: Brightness.light,
    // ));

    return MaterialApp(
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
        useMaterial3: true,
      ),
      home: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CachedNetworkImage(
              imageUrl: splashImage,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: 30,
              right: 30,
              child: GetBuilder(
                init: CountController(),
                builder: (CountController controller) {
                  if(!controller.isStart()!) {
                    controller.startCountdown();
                  }
                  // print(verificationController.countdownTime);
                  return ElevatedButton(
                    onPressed: () {
                      if(controller.countdownTime==0) {
                        Get.offNamed(Routes.main);
                      }
                    },
                    child: Text(controller.countdownTime.toString()),
                  );
                },

              ))
        ],
      ),
    );
  }

}


