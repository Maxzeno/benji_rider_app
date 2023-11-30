// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/error_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/models/delivery_model.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum StatusType { delivered, pending, cancelled }

class OrderController extends GetxController {
  static OrderController get instance {
    return Get.find<OrderController>();
  }

  var isLoad = false.obs;
  var vendorsOrderList = <DeliveryModel>[].obs;

  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;
  var total = 0.obs;
  var status = StatusType.pending.obs;

  deleteCachedOrders() {
    vendorsOrderList.value = <DeliveryModel>[];
    loadedAll.value = false;
    isLoadMore.value = false;
    loadNum.value = 10;
    total.value = 0;
    status.value = StatusType.pending;
  }

  resetOrders() async {
    vendorsOrderList.value = <DeliveryModel>[];
    loadedAll.value = false;
    isLoadMore.value = false;
    loadNum.value = 10;
    total.value = 0;
    status.value = StatusType.pending;
    setStatus();
  }

  Future<void> scrollListener(scrollController) async {
    if (OrderController.instance.loadedAll.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      OrderController.instance.isLoadMore.value = true;
      update();
      await OrderController.instance.getOrdersByStatus();
    }
  }

  setStatus([StatusType newStatus = StatusType.delivered]) async {
    status.value = newStatus;
    vendorsOrderList.value = [];
    loadNum.value = 10;
    loadedAll.value = false;
    update();
    await getOrdersByStatus();
  }

  Future getOrdersByStatus() async {
    if (loadedAll.value) {
      return;
    }
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}/drivers/getTasksByStatus/$id/${statusTypeConverter(status.value)}?start=0&end=100";
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }
    List<DeliveryModel> data = [];
    try {
      data = (jsonDecode(responseData)['items'] as List)
          .map((e) => DeliveryModel.fromJson(e))
          .toList();
      vendorsOrderList.value = data;
    } catch (e) {}
    isLoad.value = false;
    update();
  }
}
