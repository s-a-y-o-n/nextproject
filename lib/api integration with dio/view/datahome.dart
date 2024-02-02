import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nextproject/api%20integration%20with%20dio/controller/dataController.dart';
import 'package:nextproject/api%20integration%20with%20dio/utils/colors.dart';
import 'package:nextproject/api%20integration%20with%20dio/utils/snackbar_const.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DataHome extends StatelessWidget {
  DataHome({super.key});
  DataController controller = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio'),
        backgroundColor: Mycolors.prcolor,
      ),
      backgroundColor: Mycolors.bgcolor,
      floatingActionButton: Obx(
          () => controller.isNetConnected.value ? _buildFAB() : Container()),
      body: Obx(() => SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: controller.isNetConnected.value
                ? (controller.isloading.value
                    ? Center(child: CircularProgressIndicator())
                    : getData())
                : noInternet(context),
          )),
    );
  }

  FloatingActionButton _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        controller.isListDown.value
            ? controller.scrollToup()
            : controller.scrollTodown();
      },
      backgroundColor: Mycolors.prcolor,
      child: FaIcon(controller.isListDown.value
          ? FontAwesomeIcons.arrowUp
          : FontAwesomeIcons.arrowDown),
    );
  }

  RefreshIndicator getData() {
    return RefreshIndicator(
      onRefresh: () {
        return controller.fetchdata();
      },
      child: ScrollablePositionedList.builder(
          itemScrollController: controller.scrollController,
          itemCount: controller.datas.length,
          itemBuilder: (context, index) {
            return InkWell(
              // onTap: ()=> Get.to(),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Mycolors.sccolor,
                    child: Text(controller.datas[index].id.toString()),
                  ),
                  title: Text("${controller.datas[index].title}"),
                  subtitle: Text("${controller.datas[index].body}"),
                ),
              ),
            );
          }),
    );
  }

  Center noInternet(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("No Internet"),
          MaterialButton(
            onPressed: () {
              if (controller.isNetConnected.value) {
                controller.fetchdata();
              } else {
                showCustomSnackbar(context);
              }
            },
            child: Text("Try Again"),
          )
        ],
      ),
    );
  }
}
