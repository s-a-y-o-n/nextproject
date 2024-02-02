import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextproject/api%20integration%20with%20dio/view/datahome.dart';

void main() {
  runApp(Diomain());
}

class Diomain extends StatelessWidget {
  const Diomain({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: DataHome(),
    );
  }
}
