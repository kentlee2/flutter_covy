import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CommonAppBar({super.key,required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        child: const Icon(Icons.arrow_back_ios),
        onTap: () {
          Get.back();
        },
      ),
      title:  Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
