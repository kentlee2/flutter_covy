
import 'package:flutter/material.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      color: Colors.redAccent,
      child: const Text('商务', style: TextStyle(
          color: Colors.black,
          fontSize: 40.0
      ),),
    );
  }
}