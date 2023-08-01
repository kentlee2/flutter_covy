import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';

class Base64Image extends StatefulWidget {
  const Base64Image({required this.imagePath, super.key});

  final String imagePath;

  @override
  State<Base64Image> createState() => _Base64ImageState();
}

class _Base64ImageState extends State<Base64Image> {
  final logic = Get.find<MainController>();

  @override
  void initState() {
    super.initState();
    logic.loadData(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => logic.imageUrl.value.isNotEmpty
        ? Image.memory(
            base64.decode(logic.imageUrl.value),
            gaplessPlayback: true,
             fit: BoxFit.fill,
          )
        : const CircularProgressIndicator());
  }
}
