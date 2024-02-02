import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nextproject/api%20integration%20with%20dio/model/datamodel.dart';
import 'package:nextproject/api%20integration%20with%20dio/services/dioService.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DataController extends GetxController {
  RxList<DataModel> datas = RxList(); //similar to  var datas=[].obs
  RxBool isloading = true.obs;
  RxBool isListDown = false.obs;
  RxBool isNetConnected = true.obs;
  var url = "https://jsonplaceholder.typicode.com/posts";
  var scrollController = ItemScrollController();

  void isInternetconnected() async {
    isNetConnected.value = await InternetConnectionChecker().hasConnection;
  }

  //to fetch all data
  fetchdata() async {
    isInternetconnected();
    isloading.value = true;
    var response = await DioService().getdata(url);
    if (response.statusCode == 200) {
      response.data.forEach((data) {
        datas.add(DataModel.fromJson(data));
      });
      isloading.value = false;
    }
  }

  scrollTodown() {
    scrollController.scrollTo(
        index: datas.length,
        duration: Duration(seconds: 3),
        curve: Curves.decelerate);
    isListDown.value = true;
  }

  scrollToup() {
    scrollController.scrollTo(
        index: 0, duration: Duration(seconds: 3), curve: Curves.decelerate);
    isListDown.value = false;
  }

  @override
  void onInit() {
    fetchdata();
    isInternetconnected();
    super.onInit();
  }
}
