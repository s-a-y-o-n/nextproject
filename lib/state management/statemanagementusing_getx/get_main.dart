import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextproject/state%20management/statemanagementusing_getx/controller.dart';

void main() {
  runApp(GetMaterialApp(
    home: GetMain(),
  ));
}

class GetMain extends StatelessWidget {
  GetMain({super.key});
  final CountController controller = Get.put(CountController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Obx(
              () => Text('Count : ${controller.count}'),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.increment();
                },
                child: Text('Increment')),
            ElevatedButton(
                onPressed: () {
                  controller.decrement();
                },
                child: Text('decrement')),
          ],
        ),
      ),
    );
  }
}
